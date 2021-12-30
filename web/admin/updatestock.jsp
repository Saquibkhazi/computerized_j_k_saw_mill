<%-- 
    Document   : editprice
    Created on : Feb 19, 2019, 5:26:24 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
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
<%!
    String frameid="",stock="",msg="";
    Connection conn=null;
    PreparedStatement stmt=null;
    int x;
    public void connect()
    {
        try{
             Class.forName("com.mysql.jdbc.Driver");
                 conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
        }
        catch(Exception ex)
        {
            msg=ex.getMessage();
        }
        
    }
    public void getInput(HttpServletRequest request)
    {
     try
     {
      frameid=request.getParameter("ddlframename");
      
      stock=request.getParameter("txtstock");
     }
     catch(Exception ex)
     {
         msg=ex.getMessage();
     }
    }
    public void insert()
    {
        try{
            stmt=conn.prepareStatement("update frames set stock=stock+? where frameid=?");
            stmt.setInt(1,Integer.parseInt(stock));
              stmt.setString(2,frameid);
          
            x=stmt.executeUpdate();
            if(x==1){
                msg="Stock Is Updated";
              }
            else{
                msg="Stock Is Not Updated";
            }
            
        }
        catch(Exception ex)
        {
            msg=ex.getMessage();
        }
    }
    public void close()
    {
        try
        {
           stmt.clearParameters();
           conn.close();

        }
        catch(Exception ex)
        {
            msg=ex.getMessage();
        }
    }
%>
<%=frameid%>
<%=stock%>
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
            connect();
            getInput(request);
            insert();
            close();
        %>
        <%=msg%>
        </h3>
        <%@include file="footer.jspf" %>
     </body>
</html>

