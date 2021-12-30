<%-- 
    Document   : login
    Created on : Dec 31, 2018, 3:16:31 PM
    Author     : SAQUIB
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%!
        //sales login
        Connection conn=null;
        PreparedStatement stmt=null;
        String msg="", emailid="",password="";
        
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
                stmt.clearParameters();
                conn.close();
            }
            catch(Exception ex){
                msg=ex.getMessage();
        }
    }
    public void getInput(HttpServletRequest request)
    {
        //fetch saleslogin input
        emailid=request.getParameter("txtemailid");
        password=request.getParameter("txtpassword");
    }

    public void checkLogin(HttpServletRequest request,HttpServletResponse response)
    {
        //check in sales table
        try{
        stmt=conn.prepareStatement("select * from users where emailid=? and password=? and status='A'");
        stmt.setString(1, emailid);
        stmt.setString(2, password);
        
        ResultSet rs=stmt.executeQuery();
        
        //if active salesuser row is found
        if (rs.next())
        {
            rs.close();
            stmt.clearParameters();
            close();
            
            //store salesuser's emailid and pwd in session
            HttpSession obj=request.getSession(true);
            obj.setAttribute("session_emailid",emailid);
            obj.setAttribute("session_password",password);
            response.sendRedirect("home.jsp");            
        }
         else
        {
            rs.close();
            stmt.clearParameters();
            close();
            msg="Sorry Emailid or Password Invalid!";
            request.setAttribute("errorMessage",msg);
            request.setAttribute("emailid", emailid);
          
            RequestDispatcher rd=request.getRequestDispatcher("loginform.jsp");  
            rd.include(request, response);  
        }
     }
    catch(Exception ex)
    {
        msg=ex.getMessage();
    }
}    //end of class
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            connect();
            getInput(request);
            checkLogin(request, response);
         %>
    </body>
</html>
