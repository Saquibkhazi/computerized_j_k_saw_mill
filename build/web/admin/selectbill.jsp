<%-- 
    Document   : selectbill
    Created on : 23 Mar, 2019, 1:12:14 PM
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
            Vector ordernumber = new Vector();
            Vector orderdate = new Vector();
            Vector customerid = new Vector();
            Vector status = new Vector();

            String msg = "",x,y,z,a;

            int f = 0;
            Connection conn = null;
            PreparedStatement stmt = null;
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
            stmt = conn.prepareStatement("select * from orders where status='processed'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                ordernumber.add(rs.getString("ordernumber"));
                orderdate.add(rs.getString("orderdate"));
                customerid.add(rs.getString("customerid"));
                status.add(rs.getString("status"));

                f = 1;

            }

            rs.close();
            stmt.clearParameters();
          conn.close();

        %>

         <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
            <%if (f == 1) {%>
             <thead>
            <tr>
                <th>ordernumber</th>
                <th>orderdate</th>
                <th>customerid</th>
                <th>status</th>
            </tr>
             </thead>
            <% for (int i = 0; i < ordernumber.size(); i++) { %>
              <tbody>
            <% x = ordernumber.get(i).toString();%>
            <% y = orderdate.get(i).toString();%>
            <% z = customerid.get(i).toString();%>
            <% a = status.get(i).toString();%>

            <tr>                
                <td>    <a href="bill.jsp?x=<%=x%>"><%=x%></a></td>
                <td><%=y%></td>
                <td><%=z%></td>
                <td><%=a%></td>

            </tr>

            <%}
            } else {
            %> Sorry <br>
            No bill is available<%
                }

            %>
           </tbody>
        </table>
                </div>
        <%@include file="footer.jspf" %>
    </body>
</html>