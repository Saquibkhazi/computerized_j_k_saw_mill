<%-- 
    Document   : wages
    Created on : 19 Mar, 2019, 7:33:22 PM
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
    String msg = "";
    String fromdate = "", todate = "",paiddate="";
    int wagespaid = 0, perdaywages = 0,x=0;
    String[]employeeid;
    String[]dayspresent;
    
    
    Connection conn = null;
    PreparedStatement stmt = null;

    //insert row into product table    
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);

    
    fromdate = request.getParameter("fromdate");
    todate = request.getParameter("todate");
    paiddate = request.getParameter("paiddate");
    perdaywages = Integer.parseInt(request.getParameter("perdaywages"));
    employeeid =  request.getParameterValues("empid");
    dayspresent = request.getParameterValues("dayspresent");
     
    int len=employeeid.length;
    for(int i=0;i<len;i++){
        wagespaid=Integer.parseInt(dayspresent[i])*perdaywages;
    
    stmt = conn.prepareStatement("insert into wages(fromdate,todate,perdaywages,employeeid,dayspresent,wagespaid,paiddate)values(?,?,?,?,?,?,?)");
    stmt.setString(1, fromdate);
    stmt.setString(2, todate);
    stmt.setInt(3, perdaywages);
    stmt.setInt(4,Integer.parseInt(employeeid[i]));
    stmt.setInt(5, Integer.parseInt(dayspresent[i]));
    stmt.setInt(6, wagespaid);
    stmt.setString(7, paiddate);
    x = stmt.executeUpdate();
    }
    if (x == 1) {
        msg = "Wages Added";
    } else {
        msg = "Wages Add Failed";
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h3>
        <%=msg%>
        </h3>
    </body>
</html>
