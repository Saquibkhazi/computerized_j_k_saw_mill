<%-- 
    Document   : addtocart
    Created on : Mar 09, 2019, 3:28:55 PM
    Author     : SAQUIB
--%>
<%@page import="java.util.Vector" %>
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
if (obj.getAttribute("session_emailid").toString() == null ) {                               
     response.sendRedirect("loginform.jsp");
                
 }
    }catch(Exception ex)
    {
        response.sendRedirect("loginform.jsp");
    }
        
%>
<%!
//
Connection conn=null;
PreparedStatement stmt=null;
String msg="";
String framename="",frameid="";
int quantity=0,customerid=0;
float amount=0,totalamount;

public void connect()
{
    try{
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
        }catch(Exception ex){
         msg=ex.getMessage();
        }
}
public void close()
{
    try{
        conn.close();
    }catch(Exception ex){
        msg=ex.getMessage();
    }
}
public void getInput(HttpServletRequest request)
{
    frameid=request.getParameter("frameid");
    framename=request.getParameter("framename");
    quantity=Integer.parseInt(request.getParameter("quantity"));
    amount=Float.parseFloat(request.getParameter("amount"));
    totalamount=amount*quantity;
    //get customer code from session
    
    HttpSession obj=request.getSession(false);
    customerid=Integer.parseInt(obj.getAttribute("session_customerid").toString());
}     
public void addcart()
{  
    try{
    stmt=conn.prepareStatement("insert into cart(customerid,frameid,price,quantity,amount) values (?,?,?,?,?)");
         stmt.setInt(1,customerid);
         stmt.setString(2,frameid);
         stmt.setFloat(3,amount);
         stmt.setInt(4,quantity);
         stmt.setFloat(5,totalamount);
         
         stmt.executeUpdate();
         stmt.clearParameters();
         stmt.close();
            msg=" Added To Cart Successfull";
    }catch(Exception ex)
    {
         msg="Failed To Add To Cart";
    }
            
            
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
            connect();
            getInput(request);
            addcart();
            close();
        %>  
        <h3><%=msg%></h3>
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 750px;">
            <table class="table table-hover">
       <tr> 
            <td><a href="fetchcategory.jsp">Continue Shopping</a></td>
            </tr>
        
        <tr> 
            <td><a href="checkout.jsp">Checkout And Accept Order</a></td>
       
        </tr>
            </table>
         </div>
        <%@include file="footer.jspf" %>
    </body>
</html>
