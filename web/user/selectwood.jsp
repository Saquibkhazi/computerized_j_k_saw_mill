<%-- 
    Document   : selectwood
    Created on : 19 Feb, 2019, 4:52:53 PM
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
if (obj.getAttribute("session_emailid").toString() == null ) {                               
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
            Vector woodtype=new Vector();
             Vector price=new Vector();
             
              

            String msg="";
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
             stmt=conn.prepareStatement("select * from wood");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    woodtype.add(rs.getString("woodtype"));
                    price.add(rs.getInt("price"));
                      
                    
                }

                rs.close();
                stmt.clearParameters();
                stmt.close();
                conn.close();

                
          %>
        
      <div style="margin-left: 40px;margin-top: 55px;margin-right: 900px;">
            <table class="table table-hover">
        <thead>
            <tr>
               <th>Woodtype</th><th>Price</th>
            </tr>
            </thead>
            <% for(int i=0;i<woodtype.size();i++){ 
            
                String x=woodtype.get(i).toString();
                String y=price.get(i).toString();%>
             <tbody>
                <tr>                
              <td><a href="addframesform.jsp?x=<%=x%>&y=<%=y%>"/><%=x%></a></td>
             <td><%=price.get(i)%></td>
              </tr>
              <%
            }
              %>
               </tbody>
        </table>
          </div>
              <%@include file="footer.jspf" %>
    </body>
</html>