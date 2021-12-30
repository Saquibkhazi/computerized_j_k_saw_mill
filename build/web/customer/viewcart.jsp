<%-- 
    Document   : viewcart
    Created on : Mar 16, 2019, 5:07:14 PM
    Author     :SAQUIB
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
          
            Vector frameid=new Vector();
            Vector quantity=new Vector();
            Vector price=new Vector();
            Vector amount=new Vector();
            Vector vpic=new Vector();
            
            String msg="";
            int f=0;
            int customerid=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);
            customerid=Integer.parseInt(obj.getAttribute("session_customerid").toString());
            stmt=conn.prepareStatement(" select cart.customerid,cart.frameid,cart.quantity,cart.price,cart.amount,frames.pic from cart inner join frames on cart.frameid=frames.frameid where customerid=?;");
            stmt.setInt(1, customerid);
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    frameid.add(rs.getString("frameid"));
                    quantity.add(rs.getString("quantity"));
                    price.add(rs.getString("price"));
                    amount.add(rs.getString("amount"));
                    vpic.add("..//upload//"+ rs.getString("pic"));
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
              <h2>View Cart</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">View Cart</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
       
            <div style="margin-left: 40px;margin-top: 55px;margin-right: 750px;">
            <table class="table table-hover">
            <%if(f==1)
            {%>
            <thead>
            <tr>
               <td>Frameid</td>
               <td>Quantity</td>
               <td>Price</td>
               <td>Amount</td>
               <td>Pic</td>
               <td>Edit</td>
               <td>Delete</td>
            </tr>
            </thead>
            <% for(int i=0;i<frameid.size();i++){
            String pic="..//upload/"+vpic.get(i).toString();    
            String x=frameid.get(i).toString();
            %>
            
            <tr>                
                
                <td><%=frameid.get(i)%></td>
                <td><%=quantity.get(i)%></td>
                <td><%=price.get(i)%></td>
                <td><%=amount.get(i)%></td>
                <td><img src="<%=pic%>" alt="img<%=i%>" style="height:80px; width:80px"/></td>
                <td><a href="editcart.jsp?x=<%=x%>">edit</a></td>
                  <td><a href="deletecart.jsp?x=<%=x%>">delete</a></td>
            </tr>
           
            <%} 
            }
            else{
                %><h4> Sorry </h4><br>
                <h5>Your Cart Is Empty
                    Please Continue the Shopping</h5><%
            }
            %>
           </table>
             <br>
        <a href="fetchcategory.jsp">Continue shopping</a>
        <br>
        <a href="order.jsp">Checkout and Accept Order</a>
  <%@include file="footer.jspf" %>
            </body>
</html>


