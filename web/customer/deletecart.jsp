<%-- 
    Document   : addtocart
    Created on : Jan 12, 2019, 12:56:16 PM
    Author     : ISCT
--%>

<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
<%!
    //
    Connection conn = null;
    PreparedStatement stmt = null;
    String msg = "";
   
    int customerid = 0;
    String frameid = "";
    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void close() {
        try {
            conn.close();
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void getInput(HttpServletRequest request) {
        frameid = request.getParameter("x");
       
        //get custcode from session
        HttpSession obj = request.getSession(false);
        customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());

    }

    public void deleteCartItem() {
        try {
            stmt = conn.prepareStatement("delete from cart where frameid=? and customerid=?");
            stmt.setString(1, frameid);
            stmt.setInt(2, customerid);
            stmt.executeUpdate();
            stmt.clearParameters();
            stmt.close();
            msg ="deleted from cart";
           

        } catch (Exception ex) {
            msg = " deletion from cart failed, try again";
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="link.jspf" %>
    </head>
    <body style="background-color:white ">
        <%@include file="header.jspf" %>
        <%
            getInput(request);
            connect();
            deleteCartItem();
            close();
        %>
        <div><%=msg%></div>       
        <br>
      
    <%@include file="footer.jspf" %>
    </body>
</html>
