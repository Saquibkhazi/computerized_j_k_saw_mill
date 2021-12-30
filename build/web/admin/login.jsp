<%-- 
    Document   : login.jsp
    Created on : 27 Dec, 2018, 4:51:21 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%
            String vemailid="", vpassword="",msg="";
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(true);
            vemailid=request.getParameter("txtemailid");
            vpassword=request.getParameter("txtpassword");
            stmt=conn.prepareStatement("select count(*) as cnt from admin where emailid=? and password=?");
            stmt.setString(1, vemailid);
            stmt.setString(2, vpassword);
            ResultSet rs=stmt.executeQuery();
            rs.next();
            int c=rs.getInt("cnt");
            rs.close();
            stmt.clearParameters();            
            conn.close();
            if(c==1){
                msg="";
                obj.setAttribute("s_emailid",vemailid);
                obj.setAttribute("s_password",vpassword);
                response.sendRedirect("home.jsp");
                
            }
            else{
                    msg="invalid login id";
            }
            %>
            <%=msg%>

    </body>
</html>
