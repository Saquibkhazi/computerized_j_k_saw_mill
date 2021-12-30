
<%--
    Document   : reg
    Created on : 28 feb, 2019, 1:32:06 PM
    Author     : SAQUIB
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%!
        String name="",emailid="",address="",city="",pincode="",mobile="",password="",msg="";
        Connection conn=null;
        PreparedStatement stmt=null;
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
            name=request.getParameter("txtname");
            emailid=request.getParameter("txtemailid");
            address=request.getParameter("txtaddress");
            city=request.getParameter("txtcity");
            pincode=request.getParameter("txtpincode");
            mobile=request.getParameter("txtmobile");
            password=request.getParameter("txtpassword");
             
            

        }
        public void insert()
        {
            try{
                  stmt=conn.prepareStatement("insert into customer(name,emailid,password,address,city,mobile,pincode) values(?,?,?,?,?,?,?)");
                  stmt.setString(1,name );
                  stmt.setString(2, emailid);
                  stmt.setString(3,password );
                  stmt.setString(4,address);
                  stmt.setString(5,city);
                  stmt.setString(6,mobile );
                  stmt.setString(7,pincode);
                  stmt.executeUpdate();
                  msg="Registraion successful";
            }
            catch(Exception ex)
            {
                msg=ex.getMessage();
            }
        }
        public void close()
        {
            try{
                stmt.clearParameters();            
                conn.close();
            }
            catch(Exception ex){
                msg=ex.getMessage();
            }
            
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
           <%@include file="regheader.jspf" %>
      
             
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
