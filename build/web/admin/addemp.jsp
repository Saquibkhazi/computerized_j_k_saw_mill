<%-- 
    Document   : addframes
    Created on : feb 27, 2019, 4:25:57 PM
    Author     : SAQUIB
--%>

<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
<%
      
        String msg="";
        String name="",address="",mobile="",city="";
        Connection conn=null;
        PreparedStatement stmt=null;
       

     
        
    //insert row into product table    
     Class.forName("com.mysql.jdbc.Driver");
    conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null) ; 
   
                name=request.getParameter("txtemployeename");
             address=request.getParameter("txtaddress");
              mobile=request.getParameter("txtmobile");
               city=request.getParameter("txtcity");

   stmt=conn.prepareStatement("insert into employee(employeename,address,mobile,city)values(?,?,?,?)");
        stmt.setString(1,name);
        stmt.setString(2,address);
        stmt.setString(3,mobile);
        stmt.setString(4,city);
        int x=stmt.executeUpdate();
        if(x==1)
            msg="employee added";
        else
            msg="employee add failed";
 %>
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%=msg%>
        </body>
    </html>
