
<%-- 
    Document   : checkout
    Created on : Mar 7, 2019, 5:22:42 PM
    Author     : SAQUIB
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@ page import="java.util.*" %>
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
    String orderdate = new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());

    int customerid = 0, amt = 0;

    Vector frameid = new Vector();
    Vector quantity = new Vector();
    Vector amount = new Vector();
    Vector price = new Vector();
   

    float shippingcharges, order_netamount, cgst, sgst;
    int totalamount = 0;

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

    public void fetchCart(HttpServletRequest request) {
        try {

            frameid.clear();
            quantity.clear();
            amount.clear();
            price.clear();

            HttpSession obj = request.getSession(false);
            customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
            stmt = conn.prepareStatement("select cart.frameid, cart.price, cart.quantity,amount from cart "
                    + " inner join frames on cart.frameid=frames.frameid where customerid=?");
            stmt.setInt(1, customerid);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                frameid.add(rs.getString("frameid"));
                price.add(rs.getInt("price"));
                quantity.add(rs.getInt("quantity"));
                amt = rs.getInt("amount");
                amount.add(amt);
                totalamount += amt;
            }
            rs.close();
            stmt.clearParameters();
            stmt.close();
            cgst = 3.0f / 100 * totalamount;
            sgst = cgst;
            shippingcharges = .04f * totalamount;
            order_netamount = cgst + sgst + totalamount + shippingcharges;

            msg = "";
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }
%>
<%
    connect();
    fetchCart(request);
    close();
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
              <h2>Your Order </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
                <li><a href="#">Add to Cart</a><i class="icon-angle-right"></i></li>
              <li><a href="#">Order</a><i class="icon-angle-right"></i></li>
              
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>
        
      
       <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
       
            <tr>
                <td colspan="2">Order Date=<%=orderdate%></td> 
            </tr>
             
            <tr>
                <td>Total amount=<%=totalamount%></td> 
            </tr>
             <tr>   <td>Cgst=<%=cgst%></td></tr>
             <tr> <td>Sgst=<%=sgst%></td></tr>
            <tr> <td>Shipping charges=<%=shippingcharges%></td></tr>
            <tr><td>Net amount=<%=order_netamount%></td></tr>
         </table>
       </div>
       <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
           <thead>
                <tr>
                   
                    <th>Frameid</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <%for (int i = 0; i < frameid.size(); i++) {%>
                <tr>

                    <td><%=frameid.get(i).toString()%></td>
                    <td><%=price.get(i).toString()%></td>
                    <td><%=quantity.get(i).toString()%></td>
                    <td><%=amount.get(i).toString()%></td>
                </tr>
                <%}%>

            </tbody>
        </table>
       </div>
                  
       
                <a href="changeaddress.jsp" class="btn btn-theme">Place Order</a><br>
       
    <%@include file="footer.jspf" %>
</body>
</html>
