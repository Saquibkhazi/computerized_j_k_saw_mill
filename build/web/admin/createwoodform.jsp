<%--
    Document   : createwoodform
    Created on : Dec 31, 2018, 3:46:41 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
              <h2>Create Wood</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Create</a><i class="icon-angle-right"></i></li>
              <li class="active">Wood</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>
        <form method="POST" action="createwoodlist.jsp">
            <table>
                <tr>
                    <td>Woodtype</td>
                    <td><input type="text" name="txtwooodtype"></td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td><input type="text" name="txtprice"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input class="btn btn-large btn-theme btn-rounded" type="submit" value="Create" name="btn">
                    </td>
                </tr>
            </table>
        </form>
         <%@include file="footer.jspf" %>
    </body>
</html>
