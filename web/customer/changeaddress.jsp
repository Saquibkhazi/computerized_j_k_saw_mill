<%-- 
    Document   : changeaddress
    Created on : Apr 2, 2019, 3:46:57 PM
    Author     : DELL
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

<%
    Connection conn = null;
    PreparedStatement stmt = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);

    HttpSession obj = request.getSession(false);
    int customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
    String address = "", city = "", pincode = "",mobile = "", msg = "";

    try {

        stmt = conn.prepareStatement("select address, city, pincode,mobile from customer where customerid=?");
        stmt.setInt(1, customerid);
        ResultSet rs = stmt.executeQuery();
        rs.next();
        address = rs.getString("address");
        city = rs.getString("city");
        pincode = rs.getString("pincode");
        mobile = rs.getString("mobile");
        rs.close();
        stmt.clearParameters();
        stmt.close();

    } catch (Exception ex) {
        msg = ex.getMessage();
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
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
                <h2>Change Address </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
                <li><a href="#">Order</a><i class="icon-angle-right"></i></li>
              <li><a href="#">Change Address</a><i class="icon-angle-right"></i></li>
              
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>

        <form method="POST" action="order.jsp">
            <table>
               
                <tr>
                    <td>Your Delivery Address </td>
                    <td><input type="text" name="address" value="<%=address%>" required=""></td>
                </tr>
                <tr>
                    <td>City</td>
                    <td><input type="text" name="city" value="<%=city%>" required=""></td>
                </tr>
                <tr>
                    <td>Pincode</td>
                    <td><input type="text" name="pincode" value="<%=pincode%>" required=""></td>
                </tr>
                <tr>
                    <td>Mobile</td>
                    <td><input type="text" name="mobile" value="<%=mobile%>" required=""></td>
                </tr>
                <tr>
                    <td><input class="btn btn-theme" type="submit" name="btn" value="NEXT"></td>
                </tr>

            </table>
        </form>
                <%@include file="footer.jspf" %>
    </body>
</html>
