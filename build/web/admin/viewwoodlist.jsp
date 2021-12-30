<%-- 
    Document   : viewwoodlist
    Created on : 31 Dec, 2018, 4:13:35 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession;" %>
<%@page import="java.util.Vector;" %>
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
            Vector vwoodtype=new Vector();
            Vector vprice=new Vector();
            

            String msg="";
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);
            stmt=conn.prepareStatement("select * from wood");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    vwoodtype.add(rs.getString("woodtype"));
                    vprice.add(rs.getString("price"));
                   
                       f=1;
                    
                }

                rs.close();
                stmt.clearParameters();
                stmt.close();
                conn.close();

                
          %>
        
        <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>List Of WoodList </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of WoodList</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
       
        
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 1000px;">
            <table class="table table-hover">
      
        
            <%if(f==1)
            {%>
            <thead>
            <tr>
                <td>Woodtype</td> <td>Price</td>
            </tr>
            </thead>
            <% for(int i=0;i<vprice.size();i++){ %>
            <tr>                
                <td><%=vwoodtype.get(i)%></td>
                <td><%=vprice.get(i)%></td>
             </tr>
           
            <%} 
            }
            else{
                %> Sorry <br>
                No category list is available <%
            }
            %>
        </table>
         <%@include file="footer.jspf" %>
    </body>
</html>
