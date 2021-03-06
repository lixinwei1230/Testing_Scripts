#!/usr/bin/python
import xml.etree.ElementTree as ET
import os

hit_dict = {}

def traverse(root):
	for child in root.iterfind("packages/package/classes/class"):
		jsp_name = child.get("name")[15:];
		#print child.get("name")
		for line in child.iter(tag = 'line'):
			if line.get("hits") != '0':
				hit_dict[jsp_name+'_'+line.get('number')] = 1

def oracle():
	os.chdir('/home/student/ICAClinic')
	#os.system('mysql -uroot -proot < bookstore/database/bookstore.sql')
	os.system('ant undeploy')
	os.system('ant instrument')
	os.system('ant deploy')
	os.chdir('/home/student/ICAClinic/ICA7/OrderOracle')
	os.system('wget -P /home/student/ICAClinic/ICA7/OrderOracle --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/bookstore/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"')
	#print 'wget -P /home/student/ICAClinic/ICA7/OrderOracle --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/bookstore/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"'
	#os.chdir('/home/student/ICAClinic/ICA7/OrderOracle')
	wget = "wget -P /home/student/ICAClinic/ICA7/OrderOracle --load-cookies cookies.txt "
	with open('/home/student/ICAClinic/ICA7/testCase200.txt') as f:
		for line in f:
			wgetNew = wget + line
			os.system(wgetNew)
			#print wgetNew
	os.system('wget -P /home/student/ICAClinic/ICA7/OrderOracle localhost:8080/bookstore/DumpServlet.jsp')
	os.chdir('/home/student/ICAClinic')
	os.system('ant report')
	os.system('mv /home/student/ICAClinic/bookstore/report/coverage.xml /home/student/ICAClinic/ICA7')

def orderFault():
	file_ = 1
	wget = "wget -P /home/student/ICAClinic/ICA7/OrderFault --load-cookies cookies.txt "
	with open('/home/student/ICAClinic/ICA7/testCase200.txt') as f:
		for line in f:
			os.chdir('/home/student/ICAClinic')
			#os.system('mysql -uroot -proot < bookstore/database/bookstore.sql')
			os.system('ant undeploy')
			os.system('ant instrument')
			os.system('ant deploy')
			os.chdir('/home/student/ICAClinic/ICA7/OrderFault')
			os.system('wget -P /home/student/ICAClinic/ICA7/OrderFault --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/bookstore/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"')
			#os.chdir('/home/student/ICAClinic/ICA7/OrderFault')
			wgetNew = wget + line
			os.system(wgetNew)
			os.system('wget -P /home/student/ICAClinic/ICA7/OrderFault localhost:8080/bookstore/DumpServlet.jsp')
			os.chdir('/home/student/ICAClinic')
			os.system('ant report')
			os.system('mv /home/student/ICAClinic/bookstore/report/coverage.xml /home/student/ICAClinic/ICA7')
			#print wgetNew
			fp = open('/home/student/ICAClinic/ICA7/coverage.xml')
			tree = ET.parse(fp)
			root = tree.getroot()
			#hit_dict = {}
			#hit_list = []
			os.chdir('/home/student/ICAClinic/ICA7/OrderOutput/')
			filename = "%d.txt" % file_
			file_ = file_ + 1
			target = open(filename, 'w')
			traverse(root)
			for key, value in hit_dict.iteritems():
				target.write(key + " " + str(value) + "\n")
			target.close()
	os.chdir('/home/student/ICAClinic/ICA7')
	os.system('diff -p --brief OrderOracle OrderFault')

def result():
	path = '/home/student/ICAClinic/ICA7/OrderOutput/'
	os.chdir('/home/student/ICAClinic/ICA7/OrderOutput/')
	success = ['1.txt', '6.txt', '7.txt']
	fail = ['2.txt', '3.txt', '4.txt', '5.txt']
	fail_dict = {}
	pass_dict = {}
	result = [[0 for col in range(4)]for row in range(10000)]
	for files in os.walk(path):
		#print files[2]
		for i in files[2]:
			if i in fail:
				with open(i) as f:
					for line in f:
						a, b = line.strip().split(" ")
						if b == '1':
							fail_dict[a] = 1 + fail_dict.get(a, 0)
			else:
				with open(i) as f1:
					for line in f1:
						a, b = line.strip().split(" ")
						if b == '1':
							pass_dict[a] = 1 + pass_dict.get(a, 0)

	suspicious = 0
	result = []
	count = 0
	for key in fail_dict.keys():
		failcase = fail_dict.get(key)
		successcase = pass_dict.get(key,0)
		sus = ((1.0*failcase)/len(fail))/((1.0*failcase/len(fail))+(1.0*successcase/len(success)))
		oneline = [key, failcase, successcase, sus]
		result.append(oneline)
	result.sort(key = lambda x: x[3], reverse = True)
	for row in result:
		print row
		#print "hello world"

#oracle()
#orderFault()
result()
