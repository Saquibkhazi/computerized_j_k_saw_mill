<%-- 
    Document   : editpriceform
    Created on : Feb 19, 2019, 5:07:21 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession;" %>
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
<%! float netamount=0;
    String frameid="",framename="";

public void getParameter(HttpServletRequest request)
{
    frameid=request.getParameter("x");
    framename=request.getParameter("z");
    netamount=Float.parseFloat(request.getParameter("y"));

    
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
            getParameter(request);
            
        %>
         <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Update Price </h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Update</a><i class="icon-angle-right"></i></li>
              <li class="active">Price</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
         <br>
         <form method="POST" action="updateprice.jsp">
            <table>
                <tr>
                    <td>
                        Frameid
                    </td>
                    <td>
                        <input type="text" name="frameid" value="<%=frameid%>" />
                    </td>
                </tr>
                 <tr>
                    <td>
                        Framename
                    </td>
                    <td>
                        <input type="text" name="framename" value="<%=framename%>" />
                    </td>
                </tr>
                   <tr>
                    <td>
                     NetAmount
                    </td>
                    <td>
                        <input type="text" name="netamount" value="<%=netamount%>"/>
                    </td> 
                             </tr>
                             <tr>
                     <td>
                       New Price
                    </td>
                    <td>
                        <input type="text"  name="txtnewprice" />
                    </td>
                </tr>
                    <tr>
                   <td>
                        <input class="btn btn-large btn-theme btn-rounded" type="submit"  name="btn" value="ADD"/>
                    </td>
                </tr>
                
            </table>
        </form>
                 <%@include file="footer.jspf" %>    
     </body>
</html>