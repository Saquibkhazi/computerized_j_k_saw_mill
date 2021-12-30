<%-- 
    Docudment   : vieworders
    Created on : Mar 8, 2019, 4:01:14 PM
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
            
            //get ordernumber parameter from cancelmyorders.jsp
            int ordernumber = Integer.parseInt(request.getParameter("x"));
            Vector orderdate = new Vector();
            Vector deliverydate = new Vector();
            Vector vcustomerid = new Vector();
            Vector totalamount = new Vector();
            Vector cgst = new Vector();
            Vector sgst = new Vector();
            Vector shippingcharges = new Vector();
            Vector order_netamount = new Vector();
            Vector status = new Vector();
            
            
            Vector frameid=new Vector();
            Vector quantity=new Vector();
            Vector price=new Vector();
            Vector amount=new Vector();
            Vector pic=new Vector();
             
            
            String msg = "";
            int f = 0, vvcustomerid = 0;
            Connection conn = null;
            PreparedStatement stmt = null;
            PreparedStatement stmt1=null;

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);

            HttpSession obj = request.getSession(false);
            vvcustomerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
            obj.setAttribute("session_ordernumber", ordernumber);

            stmt = conn.prepareStatement("select* from orders where ordernumber=?");
            stmt.setInt(1, ordernumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                orderdate.add(rs.getString("orderdate"));
                deliverydate.add(rs.getString("deliverydate"));
                vcustomerid.add(rs.getString("customerid"));
                totalamount.add(rs.getString("totalamount"));
                cgst.add(rs.getString("cgst"));
                sgst.add(rs.getString("sgst"));
                shippingcharges.add(rs.getString("shippingcharges"));
                order_netamount.add(rs.getString("order_netamount"));
                status.add(rs.getString("status"));
                f = 1;
            }
            rs.close();
            stmt.clearParameters();
            stmt.close();
            
           
        %>
        
           <div style="margin-left: 40px;margin-top: 55px;margin-right: 250px;">
            <table class="table table-hover">
            <%if (f == 1) {%>
            <thead>
            <tr>
                <td>orderdate</td><td>delivery</td>
                <td>totalamount</td><td>cgst</td><td>sgst</td>
                <td>shippingcharges</td>
                <td>netamount</td>
                <td>status</td>
            </tr>
            </thead>
            <% for (int i = 0; i < orderdate.size(); i++) {
            %>
            <tr>  
                <td><%=orderdate.get(i)%></td>
                <td><%=deliverydate.get(i)%></td>
                <td><%=totalamount.get(i)%></td>
                <td><%=cgst.get(i)%></td>
                <td><%=sgst.get(i)%></td>
                <td><%=shippingcharges.get(i)%></td>
                <td><%=order_netamount.get(i)%></td>
                <td><%=status.get(i)%></td>
            </tr>
            <%}
            
            //display orderdetails
            %>.
            
            <table border="2">
                 
             <%
             for(int i=0;i<frameid.size();i++){ 
              String  image="..//upload/"+pic.get(i).toString();
            %>   
            <tr>                
                
                <td><%=frameid.get(i)%></td>
                <td><%=price.get(i)%></td>
                <td><%=quantity.get(i)%></td>
                <td><%=amount.get(i)%></td>
                <td><img src="<%=image%>" alt="img<%=pic%>" style="height: 80px; width: 80px"/></td>
             </tr>
           
            <%} 
            }%>
            <form method="POST" action="cancelorder.jsp">
                 <div class="container">
                <input class="btn btn-large btn-theme btn-rounded" type="submit" name="btn" value="Cancel order"/>
                 </div>
            </form>
        </table>
           </div>
        <%@include file="footer.jspf" %>
    </body>
</html>

