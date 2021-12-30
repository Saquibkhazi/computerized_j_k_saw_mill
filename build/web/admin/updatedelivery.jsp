<%-- 
    Document   : updatedelivery
    Created on : 21 Mar, 2019, 2:14:24 PM
    Author     : SAQUIB
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
    String ordernumber="",orderdate="",customerid="",name="",address="",deliverydate="",msg="";
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
      ordernumber=request.getParameter("ordernumber");
      orderdate=request.getParameter("orderdate");
      customerid=request.getParameter("customerid");
       name=request.getParameter("name");
        address=request.getParameter("address");
      deliverydate=request.getParameter("delivery");
     }
     catch(Exception ex)
     {
         msg=ex.getMessage();
     }
    }
    public void insert()
    {
        try{
            stmt=conn.prepareStatement("update orders set deliverydate=?,status=? where ordernumber=?");
           
            stmt.setString(1,deliverydate);
             stmt.setString(2,"delivered");
             stmt.setString(3,ordernumber);
             
          
            x=stmt.executeUpdate();
            if(x==1){
               msg="Deliverydate Updated";
              }
            else{
                msg="Deliverydate Not Updated";
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
<%=ordernumber%>
<%=orderdate%>
<%=customerid%>
<%=name%>
<%=address%>
<%=deliverydate%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="link.jspf" %>
    </head>
    <body>
        <h3>
         <%@include file="header.jspf" %>
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

