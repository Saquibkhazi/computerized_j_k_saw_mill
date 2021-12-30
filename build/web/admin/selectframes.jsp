<%-- 
    Document   : selectproduct
    Created on : Feb 19, 2019, 4:39:34 PM
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
            Vector frameid=new Vector();
             Vector framename=new Vector();
             Vector netamount=new Vector();
              

            String msg="",x,z;
           
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
             stmt=conn.prepareStatement("select   frameid, framename,netamount from frames ");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    frameid.add(rs.getString("frameid"));
                    framename.add(rs.getString("framename"));
                     netamount.add(rs.getString("netamount"));
 
                   
                       f=1;
                    
                }

                rs.close();
                stmt.clearParameters();
                stmt.close();
                conn.close();

                
          %>
        <div style="margin-left: 40px;margin-top: 55px;margin-right: 900px;">
            <table class="table table-hover">
       <%if(f==1){%>
       <thead>
            <tr>
               <th>Frameid</th><th>Framename</th><th>Netamount</th>
            </tr>
             </thead>
            <% for(int i=0;i<frameid.size();i++){ %>
            <% x=frameid.get(i).toString();%>
            <% z=framename.get(i).toString();%>
            <% float y=Float.parseFloat(netamount.get(i).toString());%>
            <tbody> 
            <tr>                
                <td>    <a href="updatepriceform.jsp?x=<%=x%>&y=<%=y%>&z=<%=z%><%=x%>"> <%=x%></a></td>
                 <td><%=z%></td>
                 <td><%=y%></td>
            </tr>
           
            <%} 
            }
            else{
                %> Sorry <br>
                No product is available<%
            }
      
            %>
             </tbody>
        </table>
             </div>
              <%@include file="footer.jspf" %>
    </body>
</html>