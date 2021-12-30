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
   Vector employeeid=new java.util.Vector();
   Vector employeename=new java.util.Vector();
   Vector address=new java.util.Vector();
   Vector mobile=new java.util.Vector();
   Vector city=new java.util.Vector();
   
   Connection conn=null;
   PreparedStatement stmt=null;
   String msg="";
   try
   {
    Class.forName("com.mysql.jdbc.Driver");
    conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
    stmt=conn.prepareStatement("select * from employee");    
    //fetch data from table
    ResultSet rs=stmt.executeQuery();
   
    while(rs.next()){
        employeeid.add(rs.getString("employeeid"));
        employeename.add(rs.getString("employeename"));  
        address.add(rs.getString("address"));
        mobile.add(rs.getString("mobile"));
        city.add(rs.getString("city"));
        
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
              <h2>List Of Employees </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of Employees</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
       
        
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 700px;">
            <table class="table table-hover">
            <thead>
                <tr>
                    <th>Employeeid</th>
                    <th>Employeename</th>
                    <th>Address</th>
                    <th>Mobile</th>
                    <th>City</th>
             </tr>
            </thead>
             <%
                int i;
               //get rows from vectors and display
               int len=employeeid.size();
               for(i=0;i<len;i++)
               {
              %> 
              <tr>
                  <td><%=employeeid.get(i).toString()%></td>
                  <td><%=employeename.get(i).toString()%></td>
                  <td><%=address.get(i).toString()%></td>
                  <td><%=mobile.get(i).toString()%></td>
                  <td><%=city.get(i).toString()%></td>
                  
               </tr>
               <%
               }
               %>
             </table>
         </div>
         <%@include file="footer.jspf" %>
    </body>
</html>
