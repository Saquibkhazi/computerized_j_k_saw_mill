<%-- 
    Document   : createsalesform
    Created on : 27 Dec, 2018, 4:14:34 PM
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
if (obj.getAttribute("s_emailid").toString() == null ) {                               
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
              <h2>Create Users</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Create</a><i class="icon-angle-right"></i></li>
              <li class="active">Users</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>
        <form method="POST" action="createusers.jsp">
         
           <table>
                <tr>
                <td>Name</td>
                <td><input type="text" name="txtname"/> </td>
               </tr>
               <tr>
                <td>Emailid</td>
                <td><input type="text" name="txtemailid"/> </td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="txtpassword"/> </td>
            </tr>
          
            <tr>
                <td colspan="2"><input class="btn btn-large btn-theme btn-rounded" type="submit" value="Submit" name="btn"/></td>
            </tr>
            </table> 
        </form>
         <%@include file="footer.jspf" %>
    </body>
</html>
