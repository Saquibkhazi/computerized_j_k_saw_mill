<%-- 
    Document   : reportform
    Created on : 23 Mar, 2019, 5:26:09 PM
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
        <form method="post" action="report.jsp">
            <table>
                 
                <tr>
                    <td>From Date</td>
                    <td><input type="date" name="fromdate" /></td>
                </tr>
                 <tr>
                    <td>To Date</td>
                    <td><input type="date" name="todate" /></td>
                </tr>
                <tr>
                      <td colspan="2"><input type="submit" name="btn" value="VIEW" /></td>
                  </tr>
                                
            </table>
        </form> 
         <%@include file="footer.jspf" %>
     </body>
</html>
