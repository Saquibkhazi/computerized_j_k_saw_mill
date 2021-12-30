<%-- 
    Document   : vieworderdetails
    Created on : Mar 11, 2019, 5:37:30 PM
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
            Vector vframeid = new Vector();
            Vector vquantity = new Vector();
            Vector vprice = new Vector();
            Vector vamount = new Vector();
            String msg = "";
            int f = 0, ordernumber = 0;
            Connection conn = null;
            PreparedStatement stmt = null;
            
            vordernumber.clear();
            vframeid.clear();
            vquantity.clear();
            vprice.clear();
            vamount.clear();
                       
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);

            ordernumber = Integer.parseInt(request.getParameter("x"));

            //store orderno in session
            HttpSession obj = request.getSession(false);
            obj.setAttribute("session_ordernumber", ordernumber);

            stmt = conn.prepareStatement("select * from orderdetails where ordernumber =?");
            stmt.setInt(1, ordernumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                vordernumber.add(rs.getString("ordernumber"));
                vframeid.add(rs.getString("frameid"));
                vquantity.add(rs.getString("quantity"));
                vprice.add(rs.getString("price"));
                vamount.add(rs.getString("amount"));
               
                f = 1;

            }

            rs.close();
            stmt.clearParameters();
            stmt.close();
            conn.close();

        %>
              <div style="margin-left: 40px;margin-top: 55px;margin-right: 750px;">
            <table class="table table-hover">
                <%if (f == 1) {%>
                <thead>
                <tr>
                    <th>ordernumber</th> <th>frameid</th><th>quantity</th><th>price</th><th>amount</th>
                </tr>
                </thead>
                <% for (int i = 0; i < vordernumber.size(); i++) {

                %>
                <tr>  

                    <td><%=vordernumber.get(i)%></td>
                    <td><%=vframeid.get(i)%></td>
                    <td><%=vquantity.get(i)%></td>
                    <td><%=vprice.get(i)%></td>
                    <td><%=vamount.get(i)%></td>
              
                </tr>
                <%}}%>
            </table>
                 <div class="container">
            <a class="btn btn-large btn-theme btn-rounded" href="process.jsp">Process</a> 
                 </div>
              </div>
             <%@include file="footer.jspf" %>
    </body>