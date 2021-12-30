<%-- 
    Document   : delivery
    Created on : Mar 9, 2019, 5:29:17 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession;" %>
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
<%!
     String ordernumber="";

public void getParameter(HttpServletRequest request)
{
    ordernumber=request.getParameter("x");
 }
    %>
    <%
        
        getParameter(request);
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
    <form method="post" action="updatedelivery.jsp">
            <table> 
                <tr>
                    <td>Order Number</td>
                    <td><input type="text" name="ordernumber" value="<%=ordernumber%>"> </td>
                </tr>
                <tr>
                    <td>Delivery</td>
                    <td><input type="date" name="delivery"></td>
                </tr>
                <tr>
                   <td colspan="2"><input type="submit" name="btn" value="ORDER" /></td> 
                </tr>
            </table>
    </form>
         <%@include file="footer.jspf" %>
    </body>
</html>
//update order set deliverydate=? where orderno=?