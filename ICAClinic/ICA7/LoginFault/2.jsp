
            
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
     <tr>
      <td style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1" colspan="2"><font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">MyInfo</font></td>
     </tr>
     <form method="get" action="MyInfo.jsp" name="Form">
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Login</font></td><td style="background-color: #FFFFFF; border-width: 1"><font style="font-size: 10pt; color: #000000">admin&nbsp;</font></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Password*</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="password"  name="member_password" maxlength="20" value="admin" size="20"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">First Name*</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="name" maxlength="50" value="Administrator" size="50"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Last Name*</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="last_name" maxlength="50" value="Account" size="50"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Email*</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="email" maxlength="50" value="admin@localhost" size="50"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Address</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="address" maxlength="50" value="" size="50"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Phone</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="phone" maxlength="50" value="" size="50"></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Notes</font></td><td style="background-color: #FFFFFF; border-width: 1"><textarea name="notes" cols="50" rows="5"></textarea></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Credit Card Type</font></td><td style="background-color: #FFFFFF; border-width: 1"><select name="card_type_id"><option value=""></option><option value="2" >American Express</option><option value="1" >Visa</option></select></td>
     </tr>
     <tr>
      <td style="background-color: #FFEAC5; border-style: inset; border-width: 0"><font style="font-size: 10pt; color: #000000">Credit Card Number</font></td><td style="background-color: #FFFFFF; border-width: 1"><input type="text"  name="card_number" maxlength="50" value="" size="50"></td>
     </tr>
     <tr>
      <td colspan="2" align="right"><input type="submit" value="Update" onclick="document.Form.FormAction.value = 'update';"><input type="submit" value="Cancel" onclick="document.Form.FormAction.value = 'cancel';"><input type="hidden" name="FormName" value="Form"><input type="hidden" value="update" name="FormAction"><input type="hidden" name="member_id" value="1"><input type="hidden" name="PK_member_id" value="1"/></td>
     </tr>
     </form>
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


