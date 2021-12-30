<%-- 
    Document   : addframeform
    Created on : feb 25, 2019, 3:03:38 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.util.Vector"%>
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
              <h2>Add Employee</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Add</a><i class="icon-angle-right"></i></li>
              <li class="active">Employee</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       <br>
        <form method="POST" action="addemp.jsp">
            <table>
                
                <tr>
                    <td>Employee Name</td>
                    <td><input type="text"  name="txtemployeename"/></td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td><input type="text" name="txtaddress" /></td>
                </tr>
                 <tr>
                    <td>Mobile</td>
                    <td><input type="text" name="txtmobile" /></td>
                </tr>
                
                <tr>
                    <td>City</td>
                    <td><input type="text" name="txtcity" /></td>
                </tr>
                
                
                <tr>
                    <td colspan="2">
                        <input class="btn btn-large btn-theme btn-rounded" type="submit" value="ADD" name="btn">
                    </td>
                </tr>
            </table>
        </form>
         <%@include file="footer.jspf" %>
    </body>
</html>
