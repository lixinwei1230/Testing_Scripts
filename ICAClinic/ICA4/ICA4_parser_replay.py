print "mysql -uroot -proot < empldir/database/empldir.sql"

#print "ant undeploy"
#print "ant instrument"
#print "ant deploy"

print 'wget -P /home/student/ICAClinic/test1 --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/empldir-1-ica4/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"'

wgetStr = "wget -P /home/student/ICAClinic/test1 --load-cookies cookies.txt "

with open("localhost_access_log.2015-10-07.txt") as f:
    for line in f:
        line = line.split(" ")
        del line[0]
        del line[len(line) - 1]
        for a in line:
            if a == "":
                line.remove(a)
        str = ''
        for a in line:
            str = str + a
        str = str.replace("empldir", "empldir-1-ica4")
        #print str
        print wgetStr + '"http://localhost:8080' + str + '"'

print "wget -P /home/student/ICAClinic/test1 localhost:8080/empldir-1-ica4/DumpServlet.jsp"
#print "ant report"

print "diff test test1 > diff.txt"

