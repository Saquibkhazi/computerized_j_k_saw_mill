<%-- 
    Document   : viewcart
    Created on : Mar 6, 2019, 5:07:14 PM
    Author     : Dell
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
     <% 
          
            String msg="";
            int f=0;
            int customerid=0;
            int ordernumber=0;
            
            Connection conn=null;
            PreparedStatement stmt=null;
            PreparedStatement stmt1=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            
            HttpSession obj=request.getSession(false);
            customerid=Integer.parseInt(obj.getAttribute("session_customerid").toString());
            ordernumber=Integer.parseInt(obj.getAttribute("session_ordernumber").toString());
    
            stmt=conn.prepareStatement("delete from orderdetails  where ordernumber=?");
            stmt.setInt(1, ordernumber);
            stmt.executeUpdate();
            stmt.clearParameters();
            stmt.close();
                
            stmt1=conn.prepareStatement("delete from orders where ordernumber=? and customerid=?");
            stmt1.setInt(1,ordernumber);
            stmt1.setInt(2,customerid);
            stmt1.executeUpdate();
            conn.close();
            
                
          %>
          <h3>Order Canceled</h3>
         <%@include file="footer.jspf" %>
    </body>
</html>


