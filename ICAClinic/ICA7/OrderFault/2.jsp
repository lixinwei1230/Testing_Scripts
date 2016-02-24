
            
<html>
<head>
<title>Book Store</title>
<meta name="GENERATOR" content="YesSoftware CodeCharge v.1.2.0 / JSP.ccp build 05/21/2001"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body style="background-color: #FFFFFF; color: #000000; font-family: Arial, Tahoma, Verdana, Helveticabackground-color: #FFFFFF; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica">

<center>
 <table>
  <tr>
   <td valign="top">
    <table style="">
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Default.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/Logo_bookstore.gif" border="0"></font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Default.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/icon_home.gif" border="0"></font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Registration.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/icon_reg.gif" border="0"></font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="ShoppingCart.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/icon_shop.gif" border="0"></font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Login.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/icon_sign.gif" border="0"></font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="AdminMenu.jsp"><font style="font-size: 10pt; color: #000000"><img src="images/icon_admin.gif" border="0"></font></a></td>
     </tr>
    </table>
   
   </td>
  </tr>
 </table>
</center>
<hr>

 <table>
  <tr>
   
   <td valign="top">
    <table style="">
     <form method="get" action="OrdersGrid.jsp" name="Search">
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Item</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><select name="item_id"><option value="">All</option><option value="21" >1001 Web Site Construction Tips and Tricks</option><option value="18" >Beginning Active Server Pages 3.0</option><option value="10" >Beginning ASP Databases</option><option value="12" >Black Belt Web Programming Methods; Servers, Security, Databases and Sites</option><option value="22" >C# - Programming with the Public Beta</option><option value="17" >ColdFusion Fast &amp; Easy Web Development</option><option value="8" >Flash 4 Magic (WITH CD-ROM)</option><option value="20" >HTML 4 for the World Wide Web Visual Quickstart Guide</option><option value="15" >Mastering ColdFusion 4.5</option><option value="6" >MySQL &amp; PHP From Scratch</option><option value="4" >MySQL (OTHER NEW RIDERS)</option><option value="7" >MySQL and mSQL</option><option value="11" >Oracle8i Web Development</option><option value="3" >Perl and CGI for the World Wide Web: Visual QuickStart Guide</option><option value="5" >PHP and MySQL Web Development</option><option value="14" >Professional Java Server Programming J2EE Edition</option><option value="2" >Programming Perl (3rd Edition)</option><option value="16" >Teach Yourself ColdFusion in 21 Days (Teach Yourself -- 21 Days)</option><option value="9" >Web Application Development with PHP 4.0 (with CD-ROM)</option><option value="1" >Web Database Development : Step by Step</option><option value="19" >Web Design in a Nutshell : A Desktop Quick Reference</option><option value="13" >Web Development with Java Server Pages</option></select></td>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Member</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><select name="member_id"><option value="">All</option><option value="1" >admin</option><option value="2" >guest</option></select></td>
      <td ><input type="submit" value="Search"/></td>
     </tr>
     </form>
    </table>


    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
    <table style="">
     <tr>
      <td style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1" colspan="4"><a name="Orders"><font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">Orders</font></a></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-style: inset; border-width: 0"><a &"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-style: inset; border-width: 0"><a href="OrdersGrid.jsp?item_id=&member_id=&FormOrders_Sorting=1&FormOrders_Sorted=0&"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Item</font></a></td>
      <td style="background-color: #FFFFFF; border-style: inset; border-width: 0"><a href="OrdersGrid.jsp?item_id=&member_id=&FormOrders_Sorting=2&FormOrders_Sorted=0&"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Member</font></a></td>
      <td style="background-color: #FFFFFF; border-style: inset; border-width: 0"><a href="OrdersGrid.jsp?item_id=&member_id=&FormOrders_Sorting=3&FormOrders_Sorted=0&"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Quantity</font></a></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=7&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1001 Web Site Construction Tips and Tricks&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=4&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">Beginning ASP Databases&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=5&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">Black Belt Web Programming Methods; Servers, Security, Databases and Sites&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=6&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">C# - Programming with the Public Beta&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=8&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">Flash 4 Magic (WITH CD-ROM)&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=2&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">MySQL &amp; PHP From Scratch&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=3&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">MySQL and mSQL&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="OrdersRecord.jsp?item_id=&member_id=&order_id=1&"><font style="font-size: 10pt; color: #000000">Edit</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">Web Database Development : Step by Step&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
      <td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">1&nbsp;</font></td>
     </tr>
     <tr>
      <td colspan="4" style="background-color: #FFFFFF; border-style: inset; border-width: 0">
       <font style="font-size: 10pt; color: #CE7E00; font-weight: bold">
        <a href="OrdersRecord.jsp?item_id=&member_id=&"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      </td>
     </tr>
    </table>

    
   </td>
  </tr>
 </table>


<center>
<hr size=1 width=60%>
 <table>
  <tr>
   <td valign="top">
    <table style="">
     <tr>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Default.jsp"><font style="font-size: 10pt; color: #000000">Home</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Registration.jsp"><font style="font-size: 10pt; color: #000000">Registration</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="ShoppingCart.jsp"><font style="font-size: 10pt; color: #000000">Shopping Cart</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="Login.jsp"><font style="font-size: 10pt; color: #000000">Sign In</font></a></td>
      <td style="background-color: #FFFFFF; border-width: 1"><a href="AdminMenu.jsp"><font style="font-size: 10pt; color: #000000">Administration</font></a></td>
     </tr>
    </table>
    </td>
   
  </tr>
 </table>
 

<center><font face="Arial"><small>This dynamic site was generated with <a href="http://www.codecharge.com">CodeCharge</a></small></font></center>
</body>
</html>


