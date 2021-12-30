<%-- 
    Document   : logout
    Created on : Mar 18, 2019, 4:32:19 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="link.jspf" %>
    </head>
    <body>
         <%@include file="header.jspf" %>
        <%
            HttpSession obj = request.getSession(false);
            if(obj != null) {
                obj.removeAttribute("session_emailid");
                obj.invalidate();
            }
            request.getRequestDispatcher("loginform.jsp").forward(request,response);
            %>
             <%@include file="footer.jspf" %>
    </body>
</html>
