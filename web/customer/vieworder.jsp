<%-- 
    Docudment   : vieworders
    Created on :  Mar 18, 2019, 4:01:14 PM
    Author     :  SAQUIB
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
            Vector ordernumber = new Vector();
            Vector orderdate = new Vector();
            Vector totalamount = new Vector();
            Vector cgst = new Vector();
            Vector sgst = new Vector();
            Vector shippingcharges = new Vector();
            Vector order_netamount = new Vector();
            Vector address=new Vector();
            Vector city=new Vector();
            Vector pincode=new Vector();
            Vector mobile=new Vector();
            Vector deliverydate = new Vector();
            Vector status = new Vector();
            
            String msg = "";
            int f = 0, customerid = 0;
            Connection conn = null;
            PreparedStatement stmt = null;
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
            HttpSession obj = request.getSession(false);
            customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
            stmt = conn.prepareStatement("select * from orders where customerid=?");
            stmt.setInt(1, customerid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ordernumber.add(rs.getString("ordernumber"));
                orderdate.add(rs.getString("orderdate"));
                totalamount.add(rs.getString("totalamount"));
                cgst.add(rs.getString("cgst"));
                sgst.add(rs.getString("sgst"));
                shippingcharges.add(rs.getString("shippingcharges"));
                order_netamount.add(rs.getString("order_netamount"));
                address.add(rs.getString("address"));
                city.add(rs.getString("city"));
                pincode.add(rs.getString("pincode")); 
                mobile.add(rs.getString("mobile"));
                deliverydate.add(rs.getString("deliverydate"));
                status.add(rs.getString("status"));

                f = 1;

            }

            rs.close();
            stmt.clearParameters();
            stmt.close();
            conn.close();

        %>
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>View Order</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
                <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li><a href="#">Order</a><i class="icon-angle-right"></i></li>
              
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>
        <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
                <%if (f == 1) {%>
                 <thead>
                 <tr>
                    <th>ordernumber</th>
                    <th>orderdate</th>
                    <th>totalamount</th>
                    <th>cgst</th>
                    <th>sgst</th>
                    <th>shippingcharges</th>
                    <th>netamount</th>
                    <th>address</th>
                    <th>city</th>
                    <th>pincode</th>
                     <th>mobile</th>
                      <th>deliverydate</th>
                    <th>status</th>
                    </tr>
                </thead>
                <% for (int i = 0; i < ordernumber.size(); i++) {

                %>
                 <tbody>
                <tr>  
                    <td><%=ordernumber.get(i)%></td>
                    <td><%=orderdate.get(i)%></td>
                    <td><%=totalamount.get(i)%></td>
                    <td><%=cgst.get(i)%></td>
                    <td><%=sgst.get(i)%></td>
                    <td><%=shippingcharges.get(i)%></td>
                    <td><%=order_netamount.get(i)%></td>
                    <td><%=address.get(i)%></td>
                    <td><%=city.get(i)%></td>
                    <td><%=pincode.get(i)%></td>
                     <td><%=mobile.get(i)%></td>
                     <td><%=deliverydate.get(i)%></td>
                    <td><%=status.get(i)%></td>
                    
                </tr>
                 
                <%}
                } else {
                    %><h4> Sorry <br>
                     order is not available</h4> <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%@include file="footer.jspf" %>
    </body>
</html>

