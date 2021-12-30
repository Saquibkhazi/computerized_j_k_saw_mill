<%-- 
    Document   : changepwd
    Created on : Mar 18, 2019, 3:58:04 PM
    Author     : SAQUIB
--%>


<%@page import="java.io.PrintWriter"%>
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
if (obj.getAttribute("session_emailid").toString() == null ) {                               
     response.sendRedirect("loginform.jsp");
                
 }
    }catch(Exception ex)
    {
        response.sendRedirect("loginform.jsp");
    }     
%>
<%!
    //sales login
    Connection conn = null;
    PreparedStatement stmt = null;
    String msg = "", sessionemailid = "", vpassword = "", vnewpassword = "", vconfirmpassword = "", sessionpassword = "";
    
    int flag = 0;
    HttpSession obj;

    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void close() {
        try {
            stmt.clearParameters();
            conn.close();
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void getInput(HttpServletRequest request) {
        //fetch   input
        obj = request.getSession(false);
     
        vpassword = request.getParameter("txtcurrentpwd");
        vnewpassword = request.getParameter("txtnewpassword");
        sessionpassword = obj.getAttribute("s_password").toString();
        sessionemailid=obj.getAttribute("s_emailid").toString();
        //check if password and sessionpwd match
        if (vpassword.equals(sessionpassword)) {
            flag = 1;
        } else {
            flag = 0;
        }
    }

    public void updatePassword(HttpServletRequest request, HttpServletResponse response) {

        //check in sales table
        try {
            stmt = conn.prepareStatement("update admin set password=? where emailid=?");
            stmt.setString(1, vnewpassword);
            stmt.setString(2, sessionemailid);
            stmt.executeUpdate();
            stmt.clearParameters();
            close();
             msg = "Password Updated!";
            } 
        catch (Exception ex) {
            close();
            msg = ex.getMessage();
        }
    }    //end of class
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        </head>
    
    <body>
    
        <%
            connect();
            getInput(request);
            if (flag == 1) {
                updatePassword(request, response);
                 if (flag == 1) {
                //store new pwd in session
                obj.setAttribute("session_password", vpassword);
                request.setAttribute("successMessage", msg);

                RequestDispatcher rd = request.getRequestDispatcher("successpage.jsp");
                rd.include(request, response);
            } else {
                request.setAttribute("errorMessage", msg);
                RequestDispatcher rd = request.getRequestDispatcher("errorpage.jsp");
                rd.include(request, response);
            }
               
            } else {
                msg = "invalid current password";
                request.setAttribute("errorMessage", msg);

                RequestDispatcher rd = request.getRequestDispatcher("errorpage.jsp");
                rd.include(request, response);

            }
           
        %> 
    
    </body>
</html>
