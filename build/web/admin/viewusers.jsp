<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.*"%>
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
<%
   Vector vemailid=new java.util.Vector();
   Vector vname=new java.util.Vector();
   Vector vpassword=new java.util.Vector();
   
   Connection conn=null;
   PreparedStatement stmt=null;
   String msg="";
   try
   {
    Class.forName("com.mysql.jdbc.Driver");
    conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
    stmt=conn.prepareStatement("select * from users");    
    //fetch data from table
    ResultSet rs=stmt.executeQuery();
   
    while(rs.next()){
        vemailid.add(rs.getString("emailid"));
        vname.add(rs.getString("name"));  
        vpassword.add(rs.getString("password"));
    }
    rs.close();
    stmt.close();
    conn.close();
    msg="";
   }     
   catch(Exception ex)
   {
       msg=ex.getMessage();
   }
   finally
   {
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
         <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>List Of Users </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of Users</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
  <div style="margin-left: 40px;margin-top: 55px;margin-right: 800px;">
            <table class="table table-hover">
        
                <thead>
            <tr>
                    <th>Emailid</th>
                    <th>Name</th>
                    <th>Password</th>
             </tr>
                </thead>
             <%
                int i;
               //get rows from vectors and display
               int len=vemailid.size();
               for(i=0;i<len;i++)
               {
              %> 
              <tr>
                  <td><%=vemailid.get(i).toString()%></td>
                  <td><%=vname.get(i).toString()%></td>
                  <td><%=vpassword.get(i).toString()%></td>
               </tr>
               <%
               }
               %>
             </table>
         <%@include file="footer.jspf" %>
    </body>
</html>
