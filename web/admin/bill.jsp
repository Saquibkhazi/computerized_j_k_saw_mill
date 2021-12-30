<%-- 
    Document   : bill
    Created on : 23 Mar, 2019, 1:12:30 PM
    Author     : SAQUIB
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
        <%
            int ordernumber = 0;
            Vector orderdate = new Vector();
            Vector customerid = new Vector();
            Vector totalamount = new Vector();
            Vector cgst = new Vector();
            Vector sgst = new Vector();
            Vector shippingcharges = new Vector();
            Vector order_netamount = new Vector();
            Vector status = new Vector();
            Vector deliverydate = new Vector();
            Vector address = new Vector();
            Vector city = new Vector();
            Vector pincode = new Vector();
            Vector mobile = new Vector();

            String msg = "", a, b, c, d, e, g, h, j, k, l ,q,t,u,v;
            int f = 0;
            Connection conn = null;
            PreparedStatement stmt = null;
             Vector frameid = new Vector();
            Vector quantity = new Vector();
            Vector price = new Vector();
            Vector amount = new Vector();
            String msg1 = "", m, n, o, p;
            int s = 0;
            PreparedStatement stmt1 = null;

            //fetch orderno
             ordernumber = Integer.parseInt(request.getParameter("x"));
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
            stmt = conn.prepareStatement("select * from orders where ordernumber=?");
            stmt.setInt(1, ordernumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                orderdate.add(rs.getString("orderdate"));
                customerid.add(rs.getString("customerid"));
                totalamount.add(rs.getString("totalamount"));
                cgst.add(rs.getString("cgst"));
                sgst.add(rs.getString("sgst"));
                shippingcharges.add(rs.getString("shippingcharges"));
                order_netamount.add(rs.getString("order_netamount"));
                address.add(rs.getString("address"));
                city.add(rs.getString("city"));
                pincode.add(rs.getString("pincode"));
                mobile.add(rs.getString("mobile"));
                status.add(rs.getString("status"));
           
                f = 1;

            }

            rs.close();
            stmt.clearParameters();
            stmt.close();

           
           

            stmt1 = conn.prepareStatement("select * from orderdetails where ordernumber=?");
            stmt1.setInt(1, ordernumber);
            ResultSet r = stmt1.executeQuery();
            while (r.next()) {

                frameid.add(r.getString("frameid"));
                quantity.add(r.getString("quantity"));
                price.add(r.getString("price"));
                amount.add(r.getString("amount"));

                s = 1;

            }

            r.close();
            stmt1.clearParameters();
            stmt1.close();
            conn.close();

      
        %>

        <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
            <%if (f == 1) {%>
              <thead>
            <tr>
                <th>orderdate</th> <th>customerid</th>
                <th>totalamount</th> <th>cgst</th>
                <th>sgst</th> <th>shippingcharges</th>
                <th>order_netamount</th> <th>address</th><th>city</th><th>pincode</th>
                <th>mobile</th><th>status</th>
            </tr>
            </thead>
            <% for (int i = 0; i < orderdate.size(); i++) { %>

            <% b = orderdate.get(i).toString();%>
            <% c = customerid.get(i).toString();%>
            <% d = totalamount.get(i).toString();%>
            <% e = cgst.get(i).toString();%>
            <% g = sgst.get(i).toString();%>
            <% h = shippingcharges.get(i).toString();%>
            <% j = order_netamount.get(i).toString();%>
            <% q = address.get(i).toString();%>
            <% t = city.get(i).toString();%>
            <% u = pincode.get(i).toString();%>
            <% v = mobile.get(i).toString();%>
            <% k = status.get(i).toString();%>

             <tbody>
            <tr>                
                <td><%=b%></td>
                <td><%=c%></td>
                <td><%=d%></td>
                <td><%=e%></td>
                <td><%=g%></td>
                <td><%=h%></td>
                <td><%=j%></td> 
                <td><%=k%></td>
                <td><%=q%></td>
                <td><%=t%></td>
                <td><%=u%></td>
                <td><%=v%></td>
            </tr>
            <%}
                } else {
                }

            %>
            </tbody>
        </table>
            </div>
        <br>
        
        <%@include file="footer.jspf" %>
    </body>
</html>
