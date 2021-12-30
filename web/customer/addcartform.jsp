
<%-- 
    Document   : addcartform
    Created on : Mar 09, 2019, 3:37:52 PM
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
    <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Add To Cart</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">Add To Cart</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
<table>


<tr>
<td>Frameid</td>
<td><input type="text" name="frameid" value="<%=frameid%>"></td>
</tr>
<tr>
<td>Framename</td>
<td><input type="text" name="framename" value="<%=framename%>"></td>
</tr>
<tr>
<td>Amount</td>
<td><input type="text" name="amount" value="<%=amount%>"></td>
</tr>
<tr>
<td>Quantity</td>
<td><input type="text" name="quantity" ></td>
</tr>


    <tr>
        <td colspan="2">
             <div class="container">
            <input class="btn btn-large btn-theme btn-rounded" type="submit" value="Add To Cart" name="btn">
        </div>
            </td>
    </tr>
            </table>
        </form>
   <%@include file="footer.jspf" %>
    </body>
</html>
