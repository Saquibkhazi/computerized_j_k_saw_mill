<%-- 
    Document   : createcatlist
    Created on : 09 Mar, 2019, 4:12:16 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession" %>
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
        <h2>
        <% 
            String catname="",msg="";
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);
            catname=request.getParameter("txtcatname");
            stmt=conn.prepareStatement("insert into category (catname) values(?)");
            stmt.setString(1, catname);
            int x=stmt.executeUpdate();
           
            if(x==1){
                msg="Category List Created";
              }
            else{
                msg="Category List Not Created";
            }
             stmt.clearParameters();            
            conn.close();
            %>
            
            <%=msg%>
            </h2>
              <%@include file="footer.jspf" %>
     </body>
     
</html>
