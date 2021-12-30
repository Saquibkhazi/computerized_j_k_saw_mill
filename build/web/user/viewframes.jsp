<%-- 
    Document   : viewframes
    Created on : 27 feb, 2019, 5:35:29 AM
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
          
 <% 
            Vector woodtype=new Vector();
            Vector frameid=new Vector();
            Vector framename=new Vector();
            Vector framesize=new Vector();
            Vector totalsize=new Vector();
            Vector makingcharges=new Vector();
            Vector netamount=new Vector();
            Vector stock=new Vector();
            Vector pic=new Vector();
            Vector category=new Vector();
            String msg="";
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);
            stmt=conn.prepareStatement("select  frames.woodtype,frameid,framename,framesize,totalsize,makingcharges,netamount,stock,pic,category from frames inner join wood where frames.woodtype=wood.woodtype");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    woodtype.add(rs.getString("woodtype"));
                    frameid.add(rs.getString("frameid"));
                    framename.add(rs.getString("framename"));
                    framesize.add(rs.getString("framesize"));
                    totalsize.add(rs.getString("totalsize"));
                    makingcharges.add(rs.getString("makingcharges"));
                    netamount.add(rs.getString("netamount"));
                    stock.add(rs.getString("stock"));
                    pic.add(rs.getString("pic"));
                    category.add(rs.getString("category"));
                   
                       f=1;
                    
                }

                rs.close();
                stmt.clearParameters();
                stmt.close();
                conn.close();

                
          %>
          <%@include file="header.jspf" %>
          <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>List Of Frames </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of Frames</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 500px;">
            <table class="table table-hover">
            <%if(f==1)
            {%>
            <thead>
            <tr>
                <th>Woodtype</th><th>Frameid</th> <th>Framename</th><th>Framesize</th>
                <th>Makingcharges</th><th>Netamount</th><th>Stock</th><th>Category</th><th>Pic</th>
            </tr>
             </thead>
            <% for(int i=0;i<woodtype.size();i++){ %>
            
            <tr>                
                <td><%=woodtype.get(i)%></td>
                <td><%=frameid.get(i)%></td>
                <td><%=framename.get(i)%></td>
                <td><%=framesize.get(i)%></td>
                <td><%=makingcharges.get(i)%></td>
                <td><%=netamount.get(i)%></td>
                <td><%=stock.get(i)%></td>
                <td><%=category.get(i)%></td>
                <%
                String xe="..//upload/"+pic.get(i).toString();
                %>
                <td><%=pic.get(i)%><img src="<%=xe%>" height="100" width="100"/></td>
              </tr>
           
            <%} 
            }
            else{
                %> Sorry <br>
                No product is available<%
            }
            %>   
            
            
            
            
            
        </table>
         </div>
            <%@include file="footer.jspf" %>
            </body>  
</html>
