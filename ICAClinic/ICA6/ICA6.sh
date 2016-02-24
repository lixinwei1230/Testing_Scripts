cd ..
mysql -uroot -proot < bookstore/database/bookstore.sql
ant undeploy
ant instrument 
ant deploy
cd ICA6/
cucumber features/newUser.feature
cd ..
mysql -uroot -proot < bookstore/database/bookstore.sql
cd ICA6/
cucumber features/buybook.feature
cd ..
mysql -uroot -proot < bookstore/database/bookstore.sql
cd ICA6/
cucumber features/DeleteItem.feature
cd ..
mysql -uroot -proot < bookstore/database/bookstore.sql
cd ICA6/
cucumber features/search.feature
cd ..
mysql -uroot -proot < bookstore/database/bookstore.sql
cd ICA6/
cucumber features/guest.feature

wget -P /home/student/ICAClinic/ localhost:8080/bookstore/DumpServlet.jsp

cd ..
ant report
