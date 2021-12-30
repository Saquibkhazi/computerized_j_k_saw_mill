<%-- 
    Document   : regform
    Created on : 28 FEB, 2019, 1:45:55 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
           <%@include file="link.jspf" %>
            
    
    </head>
    <body>
          <%@include file="regheader.jspf" %>
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Register </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              
              
              <li class="active">Register</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
        <br>
  

        <script type="text/javascript">
            function check()
            {
                var Name=/^[a-zA-Z .]+$/;
                if(document.regform.txtname.value.search(Name)===-1)
                {
                
            alert("Invalid Name. It should contain only characters and spaces");
                    return false;  
                }
                
                 var Mobile=/^[0-9]{10}$/;
                if(document.regform.txtmobile.value.search(Mobile)===-1)
                {
                    
                     alert("Invalid mobile.It should contain only 10 number");
                     return false;
                }
                 
                  var Pincode =/^[0-9]{6}$/;
                if(document.regform.txtpincode.value.search(Pincode)===-1)
                {
                    
                     alert("Invalid pincode.It should contain only 6 number");
                     return false;
                }
                
          }
        </script>
        <form method="post" action="reg.jsp" name="regform" onsubmit="return check();" >
              
            <table>
                 <tr>
                    <td>Name</td>
                    <td><input type="text" name="txtname"  required=""  /></td>
                </tr>
                <tr>
                    <td>Emailid</td>
                    <td><input type="email" name="txtemailid" /></td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td><input type="text" name="txtaddress" /></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><input type="text" name="txtcity" /></td>
                </tr>
                 <tr>
                    <td>Pincode</td>
                    <td><input type="text" name="txtpincode" required=""/></td>
                </tr>
                 <tr>
                    <td>Mobile</td>
                    <td><input type="number" name="txtmobile" required=""/></td>
                </tr>
                 <tr>
                    <td>Password</td>
                    <td><input type="password" name="txtpassword" /></td>
                </tr>
                                   
                  <tr>
                      <td colspan="2"><input class="btn btn-large btn-theme btn-rounded" type="submit" name="btn" value="Submit" /></td>
                  </tr>
                                
            </table>
             
        </form>
           <%@include file="regfooter.jspf" %>
     </body>
</html>
