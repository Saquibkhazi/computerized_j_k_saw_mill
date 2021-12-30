<%-- 
    Document   : addframeform
    Created on : feb 25, 2019, 3:03:38 PM
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
if (obj.getAttribute("s_emailid").toString() == null ) {                               
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
    String wtype;
    int price;

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
    
    public void GetInt(HttpServletRequest request)
    {
        try{
            wtype=request.getParameter("x");
            price=Integer.parseInt(request.getParameter("y"));
        }
        catch(Exception e)
        {
            msg=e.getMessage();
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
             <%@include file="link.jspf" %>
                 <script type="text/javascript">
            function check()
            {
                var frameid=/^[a-zA-Z .]+[0.9]$/;
                if(document.addframesform.txtframeid.value.search(frameid)===-1)
                {
                    alert("Invalid Name. It should contain only characters and spaces");
                }
                 var stock=/^[0-9](3)$/;
                if(document.addframesform.txtstock.value.search(stock)===-1)
                {
                    alert("Invalid Name. It should contain only numbers and spaces");
                }
                {
                
                
    }
        </script>
    
    </head>
    <body>
            <%@include file="header.jspf" %>
        <%
            connect();
            GetInt(request);
            close();
        %>
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Add Frames</h2>
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
        <form method="POST"  enctype="multipart/form-data" action="addframes.jsp">
            <table>
                <tr>
                    <td>Woodtype</td>
                    <td><input type="text" value="<%=wtype%>" readonly="" name="txtwoodtype" /></td>
                </tr>
                <tr>
                    <td>Category</td>
                    <td><select name="ddlcategory">
                            <option value="CHOKAT FRAMES">Choukat Frame</option>
                            <option value="WINDOW FRAMES">Window Frame</option>
                            <option value="CUTSIZE">Cutsize</option>
                            
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Price</td>
                    <td><input type="text" name="txtprice" value="<%=price%>" readonly=""/></td>
                </tr>
                 <tr>
                    <td>Frameid</td>
                    <td><input type="text" name="txtframeid" required=""/></td>
                </tr>
                
                <tr>
                    <td>Framename</td>
                    <td><input type="text" name="txtframename" required=""/></td>
                </tr>
                <tr>
                    <td>Framesize</td>
                    <td><input type="text" name="txtframesize" required=""></td>
                </tr>
                <tr>
                    <td>Totalsize</td>
                    <td><input type="text" name="txttotalsize" required=""></td>
                </tr>
                <tr>
                    <td>Makingcharges</td>
                    <td><input type="text" name="txtmakingcharges" required=""></td>
                </tr>
                 <tr>
                    <td>Stock</td>
                    <td><input type="number" name="txtstock" required=""></td>
                </tr>
                <tr>
                    <td>Select file to upload</td>
                    <td><input type="file" name="file" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input class="btn btn-large btn-theme btn-rounded" type="submit" value="Add" name="btn">
                    </td>
                    <td> <input class="btn btn-large btn-theme btn-rounded" type="reset" value="reset" name="btn"></td>
                </tr>
            </table>
        </form>
                 <%@include file="footer.jspf" %>
    </body>
</html>
