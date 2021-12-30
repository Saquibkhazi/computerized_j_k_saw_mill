<%-- 
    Document   : advieworders
    Created on : Mar 11, 2019, 5:17:33 PM
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
            Vector vordernumber = new Vector();
            Vector vorderdate = new Vector();
            Vector vcustomerid = new Vector();
           
            Vector vtotalamount = new Vector();
            Vector vcgst = new Vector();
            Vector vsgst = new Vector();
            Vector vshippingcharges = new Vector();
            Vector vorder_netamount = new Vector();
            Vector vstatus = new Vector();
            String msg = "";
            int f = 0, customerid = 0;
            Connection conn = null;
            
            vordernumber.clear();
            vorderdate.clear();
           
            vcustomerid.clear();
            vtotalamount.clear();
            vcgst.clear();
            vsgst.clear();
            vshippingcharges.clear();
            vorder_netamount.clear();
            vstatus.clear();
            PreparedStatement stmt = null;
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
                   stmt = conn.prepareStatement("select* from orders where status ='new'");
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                vordernumber.add(rs.getString("ordernumber"));
                vorderdate.add(rs.getString("orderdate"));
               
                vcustomerid.add(rs.getString("customerid"));
                vtotalamount.add(rs.getString("totalamount"));
                vcgst.add(rs.getString("cgst"));
                vsgst.add(rs.getString("sgst"));
                vshippingcharges.add(rs.getString("shippingcharges"));
                vorder_netamount.add(rs.getString("order_netamount"));
                vstatus.add(rs.getString("status"));

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
              <h2>List Of New Orders </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of New Orders</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
       
        
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 275px;">
            <table class="table table-hover">
      
            <%if (f == 1) {%>
               <thead>
            <tr>
                <th>Ordernumber</th><th>Orderdate</th>
                <th>Totalamount</th><th>Cgst</th><th>Sgst</th>
                <th>Shippingcharges</th><th>Order_netamount</th><th>Status</th>
            </tr>
               </thead>
            <% for (int i = 0; i < vordernumber.size(); i++) {

            %>
            <tr>  

                <td>
                    <a href="vieworderdetails.jsp?x=<%=vordernumber.get(i).toString()%>"><%=vordernumber.get(i).toString()%></a>

                    
                <td><%=vorderdate.get(i)%></td>
              
                <td><%=vtotalamount.get(i)%></td>
                <td><%=vcgst.get(i)%></td>
                <td><%=vsgst.get(i)%></td>
                <td><%=vshippingcharges.get(i)%></td>
                <td><%=vorder_netamount.get(i)%></td>
                <td><%=vstatus.get(i)%></td>
            </tr>


            <%}
            } else {
            %> Sorry <br>
            No orders is available <%
                }
            %>
            <div style="color: red;">${errormsg}</div>
        </table>
         </div>
           <%@include file="footer.jspf" %>
  </body>
</html>
