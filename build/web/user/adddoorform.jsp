<%-- 
    Document   : adddoorform
    Created on : mar 01, 2019, 3:03:38 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.util.Vector"%>
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
    String msg = "";
   
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
        <%
            connect();
            close();
        %>
       <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Add Doors</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Add</a><i class="icon-angle-right"></i></li>
              <li class="active">Product</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       <br>
        <form method="POST"  enctype="multipart/form-data" action="adddoor.jsp">
            <table>
                <tr>
                    <td>Woodtype</td>
                    <td><input type="text" name="txtwoodtype"/></td>
                </tr>
                
                <tr>
                    <td>Category</td>
                    <td><select name="ddlcategory">
                            <option value="DOORS">Door</option>
                            <option value="WINDOW DOORS">Window Door</option>
                        </select>
                    </td>
                </tr>
                
                 <tr>
                    <td>Frameid</td>
                    <td><input type="text" name="txtframeid"/></td>
                </tr>
                
                <tr>
                    <td>Framename</td>
                    <td><input type="text" name="txtframename"/></td>
                </tr>
                <tr>
                    <td>Framesize</td>
                    <td><input type="text" name="txtframesize"></td>
                </tr>
                <tr>
                    <td>Makingcharges</td>
                    <td><input type="text" name="txtmakingcharges"></td>
                </tr>
                <tr>
                    <td>Netamount</td>
                    <td><input type="text" name="txtnetamount"></td>
                </tr>
                 <tr>
                    <td>Stock</td>
                    <td><input type="text" name="txtstock"></td>
                </tr>
                <tr>
                    <td>Select file to upload</td>
                    <td><input type="file" name="file" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input class="btn btn-large btn-theme btn-rounded"  type="submit" value="ADD" name="btn">
                    </td>
                </tr>
            </table>
        </form>
        
        <%@include file="footer.jspf" %>
    </body>
</html>
