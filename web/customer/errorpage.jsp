<%-- 
    Document   : errorpage
    Created on : Mar 18, 2019, 4:57:59 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>error page</title>
         <%@include file="link.jspf" %>
    </head>
    <body>
         <%@include file="header.jspf" %>
        <h3>${errorMessage}</h3>
         <%@include file="footer.jspf" %>
    </body>
</html>
