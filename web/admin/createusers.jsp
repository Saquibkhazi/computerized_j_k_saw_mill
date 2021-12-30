<%-- 
    Document   : createsales
    Created on : 27 Dec, 2018, 4:14:47 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
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
        <h3>
        <%
           String vemailid="", vname="",vpassword="", msg="";
           Connection conn=null;
           PreparedStatement stmt=null;
         
           Class.forName("com.mysql.jdbc.Driver");
           conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
           HttpSession obj=request.getSession(true);
           
        //fetch input
           vemailid=request.getParameter("txtemailid");
           vpassword=request.getParameter("txtpassword");
           vname=request.getParameter("txtname");
        
        //insert row into table
        stmt=conn.prepareStatement("insert into users(emailid,name,password) values(?,?,?)");
        stmt.setString(1,vemailid); 
        stmt.setString(2,vname);
        stmt.setString(3,vpassword);
        int x=stmt.executeUpdate();
        stmt.clearParameters();
        conn.close();
        if(x==1)
            msg="User Created";
        else
            msg="Insert Failed";
        %>
        <%=msg%>
    </h3>
    <%@include file="footer.jspf" %>
</body>
</html>
