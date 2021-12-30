<%-- 
    Document   : fb
    Created on : Mar 23, 2019, 1:59:52 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*" %>
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
<!DOCTYPE html>
<%!
            Connection conn = null;
            PreparedStatement stmtfeedback = null;
            PreparedStatement stmtfeedbackdate = null;
            PreparedStatement stmtrating = null;
            PreparedStatement stmtreview = null;

            String msg = "";
            String rating = "";
            String review = "";
            String feedbackdate = "";
            int customerid = 0;
                    
            
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

                    conn.close();
                } catch (Exception ex) {
                    msg = ex.getMessage();
                }
            }
            
            
            public void getFeedback(HttpServletRequest request) {
                try {
                    
                    feedbackdate=request.getParameter("txtfeedbackdate");
                    rating=request.getParameter("rdbrating");
                    review=request.getParameter("txtreview");
                     //get customercode from session
                     HttpSession obj = request.getSession(false);
                    customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
                    stmtfeedback = conn.prepareStatement("insert into feedback(customerid,feedbackdate,rating,review) values(?,?,?,?)");
                    stmtfeedback.setInt(1, customerid);
                    stmtfeedback.setString(2, feedbackdate);
                    stmtfeedback.setString(3, rating);
                    stmtfeedback.setString(4, review);
                    int x = stmtfeedback.executeUpdate();
                if (x == 1) {
                    msg = "Feedback added";
                } else {
                    msg = "Feedback adding failed";
                }                     } 
                catch (Exception ex) {
                    
                }
            }
  
          %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                   <%@include file="link.jspf" %>
    </head>
    <body>
          <%@include file="header.jspf" %> 
        <%
            connect();
            getFeedback(request);
            close();
%> 
<h3>  <%=msg%></h3>
            <%@include file="footer.jspf" %> 
    </body>
</html>
