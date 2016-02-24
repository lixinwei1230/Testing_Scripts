cd ../..
ant undeploy
ant instrument 
ant deploy

mysql -uroot -proot < ICAClinic/bookstore/database/bookstore.sql

cd /ICA6
cucumber newUser.feature
cucumber buybooks.feature
cucumber search.feature
cucumber guest.feature

wget -P /home/student/ICAClinic/ localhost:8080/bookstore/DumpServlet.jsp
ant report
