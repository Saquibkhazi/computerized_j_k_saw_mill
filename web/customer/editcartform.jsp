<%-- 
    Document   : editcartform
    Created on : 26 Mar, 2019, 5:10:50 PM
    Author     : SAQUIB
--%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
        String msg="";
        int quantity=0;
        String frameid="",framename="";
        float amount=0;
        
           public void getproductSelected(HttpServletRequest request)
            {
                
           frameid=request.getParameter("y");
           framename=request.getParameter("framename");
           amount=Float.parseFloat(request.getParameter("amount"));
           quantity=Integer.parseInt(request.getParameter("quantity"));
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
            getproductSelected(request);
        %>
            
<form action="addtocart.jsp">
<table border="1">


<tr>
<td>frameid</td>
<td><input type="text" name="frameid" value="<%=frameid%>"></td>
</tr>
<tr>
<td>framename</td>
<td><input type="text" name="framename" value="<%=framename%>"></td>
</tr>
<tr>
<td>amount</td>
<td><input type="text"  name="amount" value="<%=amount%>"></td>
</tr>
<tr>
<td>quantity</td>
<td><input type="text" name="quantity" ></td>
</tr>


    <tr>
        <td colspan="2">
            <input type="submit" value="Add to cart" name="btn">
        </td>
    </tr>
            </table>
        </form>
   <%@include file="footer.jspf" %>
    </body>
</html>
