from xml.etree import ElementTree
from xml.etree import cElementTree
import os
import difflib
from pprint import pprint
import time

regressionTime = {}
savingTime = {}
selectTestcases = {}
dangerIdentify = {}

def main():
    selectTestcases, regressionTime = RegTesting()
    runAllTime = RunAllCases()
    danger = open('/home/student/ICAClinic/ICA9/fault_analysis.txt', 'r').readlines()
    for j in range(len(danger)):
        dangerIdentify[j] = float(danger[j])

    RevealCoverage()

    for i in range(len(regressionTime)):
        print 'Senario:',i+1
        analysisTime = dangerIdentify[i]+selectTestcases[i]
        savingTime[i] = runAllTime-regressionTime[i]-analysisTime
        print 'Run All: ' + str(runAllTime)
        print 'Analysis: ' + str(analysisTime)
        print 'Run Selected: ' + str(regressionTime[i])
        print 'Saving: ' + str(savingTime[i])
        print '\n'
    
def RegTesting():
    result = {}
    rerunAnalysis={}
    os.system('javac -cp bcel-5.2.jar myDejaVu.java')
    os.system('java -cp bcel-5.2.jar:. myDejaVu')
    dangerousLines =  open('faultEdges.txt','r').readlines()
    #print dangerousLines;
    dangerousLines = parseDangerousLines(dangerousLines)
    #print dangerousLines;
    rerunAnalysis,rerunTestSuite = RerunTestSuites('/home/student/ICAClinic/ICA9/testSuite/', dangerousLines)
    
    for i in range(len(rerunTestSuite)):
        start = time.time()
        testSuite = rerunTestSuite[str(dangerousLines[i])]        
        for testcase in testSuite:
            os.system('cd /home/student/ICAClinic/; ant undeploy -f /home/student/ICAClinic/build.xml')
            os.system('cd /home/student/ICAClinic/; ant instrument -f /home/student/ICAClinic/build.xml')
            os.system('cd /home/student/ICAClinic/; ant deploy -f /home/student/ICAClinic/build.xml')
            os.system('wget --save-cookies cookies --keep-session-cookies \"http://localhost:8080/bookstore/Login.jsp?FormName=Login&Login=admin&Password=admin&FormAction=login\"')
            os.system('wget --load-cookies cookies \"'+ testcase +"\"")
        end = time.time() 
        result[i] = end-start
    return rerunAnalysis,result

def RerunTestCases(j,testSuite, reportPath, dangerLine):
    rerunTestSuite = []
    results = {}
    mapping = open('mapping_stmts.txt','a')
    for i in range(len(testSuite)):
        mapping.write('testcase'+str(i+1)+'\n')
        results,rerun = parseReport(reportPath+ str(i+1) + '.xml', dangerLine)   
    for a in results:
        mapping.write(a+': ')
        for b in results[a]:
            mapping.write(b +' ')
        mapping.write('\n')
    mapping.write('\n')
    if rerun == True:
        rerunTestSuite.append(testSuite[i])
    return rerunTestSuite

def parseReport(fcoverage, dangerLine):
    SourceFile = dangerLine[0]
    methodName = dangerLine[1]
    lineNumber = dangerLine[2]
    boolean = ''
    results = {}
    with open(fcoverage,'rt') as f:
        tree = cElementTree.parse(f)
        root = tree.getroot()
    for child in root.iterfind("packages/package/classes/class"):
        if child.get('filename') != SourceFile:
            continue
        for method in child.iter('method'):
            if method.get('name') != methodName:
                continue
            for line in method.iter('line'):
                if line.get('number') == lineNumber:
			if line.get("hits") != '0':
		    		results.setdefault(SourceFile,[]).append(lineNumber)
                    		boolean = True
			else:
		    		boolean = False
	for method in child.iter('method'):
            if method.get('name') != methodName:
                continue
            for line in method.iter('line'):
                if line.get("hits") != '0':
		    results.setdefault(SourceFile,[]).append(line.get('number'))
    for child in root.iterfind("packages/package/classes/class"):
	if child.get('filename') != SourceFile:
		for method in child.iter('method'):
			for line in method.iter('line'):
				if line.get("hits") != '0':
					results.setdefault(child.get('filename'),[]).append(line.get('number'))
    return results,boolean


def parseDangerousLines(DangerousLines):
    results = []
    for line in DangerousLines:
        currLine = line.split()
        currLine[0] = 'org/apache/jsp/'+ currLine[0][40:-5] + 'java'
        results.append(currLine)
    return results

def RunAllCases():
    results = {}
    start = time.time()        
    testSuite = open('/home/student/ICAClinic/ICA9/testSuite/testsuite.txt', 'r').readlines()       
    
    for testcase in testSuite:
        os.system('cd /home/student/ICAClinic/; ant undeploy -f /home/student/ICAClinic/build.xml')
        os.system('cd /home/student/ICAClinic/; ant instrument -f /home/student/ICAClinic/build.xml')
        os.system('cd /home/student/ICAClinic/; ant deploy -f /home/student/ICAClinic/build.xml')
        os.system('wget --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/bookstore/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"') 
        testcase = testcase.strip()
        myWget = 'wget --load-cookies cookies.txt '+ '"' + testcase + '"'
        os.system(myWget)
    
    end = time.time()
    return (end-start)

def RerunTestSuites(SuiteFolder, dangerLines):
    faultySuiteDict = {}
    rerunAnalysis= {}
    for i in range(len(dangerLines)):
	start = time.time()
        testSuite = open(SuiteFolder + 'testsuite.txt', 'r').readlines()
        reportPath = '/home/student/ICAClinic/ICA9/CoverageReport/'
        faultySuiteDict[str(dangerLines[i])] = RerunTestCases(i,testSuite, reportPath,dangerLines[i])
	end = time.time()
	rerunAnalysis[i] = end - start
    mapping = open('rerun_cases.txt', 'w')
    for a in faultySuiteDict:
        mapping.write(a + '\n')
        for b in faultySuiteDict[a]:
            mapping.write(str(b) + '\n')
    return rerunAnalysis,faultySuiteDict

def RevealCoverage():
    testSuite = open('/home/student/ICAClinic/ICA9/testSuite/testsuite.txt', 'r').readlines()  
    os.system('cd /home/student/ICAClinic/; ant undeploy -f /home/student/ICAClinic/build.xml')
    os.system('cd /home/student/ICAClinic/; ant instrument -f /home/student/ICAClinic/build.xml')
    os.system('cd /home/student/ICAClinic/; ant deploy -f /home/student/ICAClinic/build.xml')
    os.system('wget --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/bookstore/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"') 
    os.system
    for testcase in testSuite:  
        testcase = testcase.strip()
        myWget = 'wget --load-cookies cookies.txt '+ '"' + testcase + '"'
        os.system(myWget)
        #print myWget
    os.system('wget http://localhost:8080/bookstore/DumpServlet.jsp')
    os.system('cd /home/student/ICAClinic/; ant report -f /home/student/ICAClinic/build.xml')

if __name__ == "__main__": main()