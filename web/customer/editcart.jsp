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

    int customerid = 0, quantity = 0, price = 0, amount = 0;
    String frameid = "", pic = "";

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

        //get customercode from session
        HttpSession obj = request.getSession(false);
        customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());

    }

    public void getCartItem() {
        try {
            quantity = 0;
            amount = 0;
            stmt = conn.prepareStatement("select cart.frameid, cart.price, cart.quantity,"
                    + " amount from cart "
                    + " inner join frames on cart.frameid=frames.frameid where customerid=? and cart.frameid=?");
            stmt.setInt(1, customerid);
            stmt.setString(2, frameid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                frameid = rs.getString("frameid");
                quantity += rs.getInt("quantity");
                price = rs.getInt("price");
                amount += rs.getInt("amount");
                pic = "..//upload//" + rs.getString("image");
            }
            stmt.clearParameters();
            stmt.close();
        } catch (Exception ex) {
            msg = " failed, try again";
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
            getCartItem();
            close();
        %>
        <form method="POST" action="updatecart.jsp">
            <table border="1">

                <tr>
                    <td>frameid</td>
                    <td><input type="text" readonly="" name="frameid" value="<%=frameid%>"></td>
                </tr>
                <tr>
                <img src="<%=pic%>" height="80" width="80"/>
                </td>
                </tr>

                <tr>
                    <td>price</td>
                    <td><input type="text" readonly="" name="price" value="<%=price%>"></td>
                </tr>
                <tr>
                    <td>amount</td>
                    <td><input type="text" readonly="" name="amount" value="<%=amount%>"></td>
                </tr>
                <tr>
                    <td>edit quantity</td>
                    <td><input type="text" name="quantity" value="<%=quantity%>"></td>
                </tr>
                <tr>
                    <td><input type="submit" name="btn" value="update"></td>
                </tr>
            </table>
        </form>
        <div>
            <%=msg%></div>       

        <br>

        <a href="viewaddcart.jsp">View cart</a>
        <br>

        <a href="browsecategory.jsp">Continue shopping</a>
        <br>
        <a href="checkout.jsp">Checkout</a>
        <%@include file="footer.jspf" %>
    </body>
</html>
