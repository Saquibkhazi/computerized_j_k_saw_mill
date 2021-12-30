<%--
    Document   : selectcat_to_edit
    Created on : Mar 09, 2019, 3:15:42 PM
    Author     : SAQUIB
--%>
<%@page import="java.util.Vector"%>
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
    //
    Connection conn = null;
    PreparedStatement stmt = null;
    String msg = "";
    Vector catname = new Vector();

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
        } 
        catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void getCategory() {
        try {
            stmt = conn.prepareStatement("select * from category");
            ResultSet rs = stmt.executeQuery();
             catname.clear();
            while (rs.next()) {
                //add to vectors
                
                catname.add(rs.getString("catname"));
            }
            rs.close();
            stmt.close();
        } catch (Exception ex) {
            msg = ex.getMessage();
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
            getCategory();
            close();
        %>
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Select Category </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">Category </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 750px;">
            <table class="table table-hover">
           
                <tr>
                    <td>
            <%
                String y;
                int size = catname.size();
                for (int i = 0; i < size; i++) {
                     
                    y = catname.get(i).toString();
            %>
            <a href="browseproducts.jsp?y=<%=y%>"/><%=catname.get(i).toString()%></a><br/>
                
        <%
                }
                %>
                    </td>
            </tr>
        </table>
         </div>
          <%@include file="footer.jspf" %>
    </body>
</html>

