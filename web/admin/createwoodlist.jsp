<%-- 
    Document   : createwoodlist
    Created on : Dec 31, 2018, 3:47:58 PM
    Author     : SAQUIB
--%>
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
<%!
        //declare variables
        Connection conn=null;
        PreparedStatement stmt=null;
        String vwoodtype="",vprice="",msg="";
          
         public void connect()
        {
            try{
             Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null) ;
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
               
                conn.close();
            }
            catch(Exception ex){
                msg=ex.getMessage();
        }
    }
        
        public void getInput(HttpServletRequest request){
            vwoodtype=request.getParameter("txtwooodtype");
            vprice=request.getParameter("txtprice");
                
        }
        public void insert() throws Exception{
            try{
                 stmt=conn.prepareStatement("insert into Wood (woodtype,price) values(?,?)");
                 stmt.setString(1, vwoodtype);
                 stmt.setString(2, vprice);
                 int flag=stmt.executeUpdate();
                 if(flag==1)
                    msg="Wood Created";
                 else
                    msg="Wood Creation Failed";
                 stmt.clearParameters();
                 stmt.close();
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
    </head>
    <body>
        <h3>
            <%
            
            connect();
            getInput(request);
            insert();
            close();
            HttpSession obj=request.getSession(false);
            
           
        %>
        <%=msg%>
        </h3>
        </body>
</html>
