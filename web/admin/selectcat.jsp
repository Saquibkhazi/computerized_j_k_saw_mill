<%-- 
    Document   : selectcat
    Created on : 02  Mar, 2019, 4:57:03 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession;" %>
<%@page import="java.util.Vector;" %>
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
              <h2>SELECT CATEGORY</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">ADD</a><i class="icon-angle-right"></i></li>
              <li class="active">SELECT CATEGORY</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 900px;">
            <table class="table table-hover">
              
                  <tbody>
            <tr>
                   <td><a href="selectwood.jsp">Add Chokat Frame</a></td>
            </tr> 
            <tr>
                   <td><a href="selectwood.jsp">Add Window Frame</a></td>
            </tr> 
            <tr>
                <td> <a href="adddoorform.jsp">Add Window Door</a></td>
            </tr>
            <tr>
                <td> <a href="adddoorform.jsp">Add Door</a></td>
            </tr>
            <tr>
                <td> <a href="selectwood.jsp">Add Cut Size</a></td>
            </tr>
            
             </tbody>
             
        </table>
         </div>
      <%@include file="footer.jspf" %>
    </body>
</html>
