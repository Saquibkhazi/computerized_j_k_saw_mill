<%-- 
    Document   : viewfb
    Created on : Mar 23, 2019, 1:18:25 PM
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
   
 <% 
            Vector vcustomerid=new Vector();
            Vector vfeedbackdate=new Vector();
            Vector vrating=new Vector();
            Vector vreview=new Vector();
            String msg="";
            int f=0;
            Connection conn=null;
            vcustomerid.clear();
            vfeedbackdate.clear();
            vrating.clear();
            vreview.clear();
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);  
            //orderdetails=Integer.parseInt(obj.getAttribute("session_orderdetails").toString());
            stmt=conn.prepareStatement("select *from feedback");
            //stmt.setInt(1,orderdetails);
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                   vcustomerid.add(rs.getString("customerid"));
                   vfeedbackdate.add(rs.getString("feedbackdate"));
                   vrating.add(rs.getString("rating"));
                   vreview.add(rs.getString("review"));
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
              <h2>List Of FeedBacks </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of FeedBacks</li>
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
                <th>customerid</th> <th>feedbackdate</th><th>rating</th><th>review</th>
            </tr>
            </thead>
            <% for(int i=0;i<vcustomerid.size();i++){ 
                
            %>
            <tr>  
                
                 <td><%=vcustomerid.get(i)%></td>
                <td><%=vfeedbackdate.get(i)%></td>
                <td><%=vrating.get(i)%></td>
                <td><%=vreview.get(i)%></td>
               
             </tr>
           
            <%} 
            }
            else{
               %> Sorry <br>
                No feedback is available <%
            }
            %>
        </table>
           <%@include file="footer.jspf" %>
    </body>
</html>
         
