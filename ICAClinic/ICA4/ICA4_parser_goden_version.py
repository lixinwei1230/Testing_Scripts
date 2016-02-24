print "mysql -uroot -proot < empldir/database/empldir.sql"

print "ant undeploy"
print "ant instrument"
print "ant deploy"

print 'wget -P /home/student/ICAClinic/test --save-cookies cookies.txt --keep-session-cookies "http://localhost:8080/empldir/Login.jsp?Login=admin&Password=admin&FormAction=login&FormName=Login"'

wgetStr = "wget -P /home/student/ICAClinic/test --load-cookies cookies.txt"

with open("localhost_access_log.2015-10-07.txt") as f:
    for line in f:
        line = line.split(" ")
        #print line
        del line[0]
        del line[len(line) - 1]
        #print line0
        for a in line:
            if a == "":
                line.remove(a)
        #print line
        str = ''
        for a in line:
            str = str + a
        print "wget -P /home/student/ICAClinic/test --load-cookies cookies.txt " + '"http://localhost:8080' + str + '"'

print "wget -P /home/student/ICAClinic/test localhost:8080/empldir/DumpServlet.jsp"
print "ant report"

#print "diff -q test test1"

