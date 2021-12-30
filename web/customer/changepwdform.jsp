<%-- 
    Document   : changepwdform
    Created on : Mar 18, 2019, 4:01:28 PM
    Author     : SAQUIB
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{
HttpServletResponse httpResponse = (HttpServletResponse)response;

httpResponse.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
httpResponse.setHeader("Pragma","no-cache"); 
httpResponse.setDateHeader ("Expires", 0); 
HttpSession obj=request.getSession(false);
if (obj.getAttribute("session_emailid").toString() == null ) {                               
     response.sendRedirect("loginform.jsp");
                
 }
    }catch(Exception ex)
    {
        response.sendRedirect("loginform.jsp");
    }
        
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="link.jspf" %>
    </head>
    <body>
    <%@include file="header.jspf" %>     
         <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Change Password</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Profile</a><i class="icon-angle-right"></i></li>
              <li class="active">Change Password</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
         <br>
       
        <form action="changepwd.jsp" method="POST">
             <table>
                <tr>
                    <td>current password</td>
                    <td><input type="text" name="txtcurrentpwd"></td>
                </tr>
                <tr>
                    <td>new password</td>
                    <td><input type="password" name="txtnewpassword"></td>
                </tr>
                    <tr>
                    <td>confirm password</td>
                    <td><input type="password" name="txtconfirmpassword" ></td>
                </tr>
                <tr>
                    
                    <td><input class="btn btn-large btn-theme btn-rounded" type="submit" name="btn" value="update password"></td>
                </tr>
            </table>
        </form>
         <%@include file="footer.jspf" %>
    </body>
</html>
