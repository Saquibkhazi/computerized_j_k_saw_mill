<%-- 
    Document   : addwagesform
    Created on : feb 25, 2019, 3:03:38 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.util.Vector"%>
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
<%
    //select empid,name from employee and store in vectors. display vectors 

    Vector employeeid = new Vector();
    Vector employeename = new Vector();
    employeeid.clear();
    employeename.clear();
    String msg = "";
    int f = 0;
    Connection conn = null;
    PreparedStatement stmt = null;
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
    HttpSession obj = request.getSession(false);
    stmt = conn.prepareStatement("select  * from employee");
    ResultSet rs = stmt.executeQuery();
    while (rs.next()) {

        employeeid.add(rs.getString("employeeid"));
        employeename.add(rs.getString("employeename"));

        f = 1;

    }

    rs.close();
    stmt.clearParameters();
    stmt.close();
    conn.close();

                
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
              <h2>Add Wages </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">ADD</a><i class="icon-angle-right"></i></li>
              <li class="active">Wages</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
        <br>
        <form method="POST" action="wages.jsp">
            <table>

                <tr>
                    <td>Fromdate</td>
                    <td><input type="date"  name="fromdate"/></td>
                </tr>
                <tr>
                    <td>Todate</td>
                    <td><input type="date" name="todate" /></td>
                </tr>
                <tr>
                    <td>Perdaywages</td>
                    <td><input type="text" name="perdaywages" /></td>
                </tr>
                 <tr>
                    <td>Paiddate</td>
                    <td><input type="date" name="paiddate" /></td>
                </tr>
            </table>
            <br><br>
             <div style="margin-left: 40px;margin-top: 55px;margin-right: 500px;">
                 <table class="table table-hover">
                <%if (f == 1) {%>
                <thead>
                <tr>
                    <th>Employeeid</th><th>Employeename</th><th>Dayspresent</th>
                </tr>
                </thead>
                <% for (int i = 0; i < employeeid.size(); i++) {%>
                <tr>                
                    <td><input type="text" name="empid" value="<%=employeeid.get(i)%>" readonly=""/></td>
                    <td><%=employeename.get(i)%></td>
                    <td><input type="text" name="dayspresent" /></td>
                  </tr>
                  <%} %>   

  
                  
            
                 </table>
                 <div class="container">
             <input class="btn btn-large btn-theme btn-rounded" type="submit" value="ADD" name="btn">
                 </div>
          <%  } else {
            %> Sorry <br>
            No wages is available<%
                }
            %>  

        </form>
        <%@include file="footer.jspf" %>
    </body>
</html>
