<%-- 
    Document   : selectordertodelivery
    Created on : 21 Mar, 2019, 1:18:09 PM
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
            Vector ordernumber=new Vector();
             Vector orderdate=new Vector();
             Vector customerid=new Vector();
             Vector name=new Vector();
             Vector address=new Vector();
              

            String msg="",x,z,y,a,b;
           
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
             stmt=conn.prepareStatement("select  customer.customerid,customer.name,"
                     + "customer.address,orderdate, ordernumber  from customer inner join orders on"
                     + " orders.customerid=customer.customerid where status='new' ");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    ordernumber.add(rs.getString("ordernumber"));
                    orderdate.add(rs.getString("orderdate"));
                    customerid .add(rs.getString("customerid"));
                    name.add(rs.getString("name"));
                    address.add(rs.getString("address"));
 
                   
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
              <h2>Delivery Date</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Delivery Date</a><i class="icon-angle-right"></i></li>
              
            </ul>
          </div>
        </div>
      </div>
    </section>
          <br>
        
        <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
            <%if(f==1) {%>
            <thead>
            <tr>
               <th>ordernumber</th><th>orderdate</th><th>customerid</th><th>name</th><th>address</th>
            </tr>
            <% for(int i=0;i<ordernumber.size();i++){ %>
            <% x=ordernumber.get(i).toString();%>
            <% y=orderdate.get(i).toString();%>
            <% z=customerid.get(i).toString();%>
            <% a=name.get(i).toString();%>
            <% b=address.get(i).toString();%>
             <tr>
             </thead>
                <tbody>  
             <td><a href="delivery.jsp?x=<%=x%>"><%=x%></a></td>
                <td><%=y%></td>
                <td><%=z%></td>
                <td><%=a%></td>
                <td><%=b%></td>
                
 
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