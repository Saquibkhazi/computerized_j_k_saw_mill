<%-- 
    Document   : updatecart
    Created on : Apr 2, 2019, 1:06:46 PM
    Author     : Dell
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
    String frameid ="",  msg = "";
    int  price = 0, quantity = 0, amount = 0, customerid = 0;

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
        frameid = request.getParameter("frameid");
        quantity = Integer.parseInt(request.getParameter("quantity"));
        price = Integer.parseInt(request.getParameter("price"));
        
        amount = quantity * price;
        //get custcode from session
        HttpSession obj = request.getSession(false);
        customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
    }

    public void updateCart() {
        try {
            PreparedStatement stmt1 = conn.prepareStatement("update cart set quantity=?, amount=? where customerid=? and frameid=?");
            stmt1.setInt(1, quantity);
            stmt1.setInt(2, amount);
            stmt1.setInt(3, customerid);
            stmt1.setString(4, frameid);
            stmt1.executeUpdate();
            msg = "cart items updated";

        } catch (Exception ex) {
            msg = frameid + " failed to update cart, try again"+ex.getMessage();
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
    <body>
                        <%@include file="header.jspf" %>

        <%
            getInput(request);
            connect();
            updateCart();
            close();
        %>
        <div><%=msg%></div>
        <br>
        <a href="viewcart.jsp">View cart</a>
        <br>
        
           <a href="fetchtype.jsp">Continue shopping</a>
        <br>
        <a href="checkoutform.jsp">Checkout</a>
                    <%@include file="footer.jspf" %>

    </body>
</html>
