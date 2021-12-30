<%--    
    Document   : fbform
    Created on : Mar 23, 2019, 12:08:53 PM
    Author     : SAQUIB
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<% 
int customerid=0;
    HttpSession obj=request.getSession(false);
     String feedbackdate = new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());
    customerid=Integer.parseInt(obj.getAttribute("session_customerid").toString());
    
 %>
   <!DOCTYPE html>
   
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>feedback</title>
           <%@include file="link.jspf" %>
        </head>
        <body>
                                  <%@include file="header.jspf" %>
               <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>FeedBack</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Profile</a><i class="icon-angle-right"></i></li>
              <li class="active">FeedBack</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
               <br>
            <form method="post" action="fb.jsp" name="feedback">
                  <table>
            <tr>
            <td>Customerid</td>
            <td><input type="text" name="txtcustomerid" value="<%=customerid%>" readonly=""></td>
            </tr>
            <tr>
            <td>Feedbackdate</td>
            <td><input type="text" name="txtfeedbackdate" value="<%=feedbackdate%>" readonly=""> </td>
            </tr>
            <tr>
            <td>Rating</td>
            <td><input type="radio" name="rdbrating" value="1" style="float:left; color: black"><font style="color: black">1 Bad</font><br/>
                <input type="radio" name="rdbrating" value="2" style="float:left; color: black"><font style="color: black">2 Average</font><br/>
                <input type="radio" name="rdbrating" value="3" style="float:left; color: black"><font style="color: black">3 Good</font><br/>
                <input type="radio" name="rdbrating" value="4" style="float:left; color: black"><font style="color: black">4 Very Good</font><br/>
                <input type="radio" name="rdbrating" value="5" style="float:left; color: black"><font style="color: black">5 Excellent</font><br/>
            </td>
            </tr>
            <tr>
            <td>Review</td>
            <td><textarea style="color: black" name="txtreview" required=""></textarea> </td>
            </tr>
            <td colspan="2"><input class="btn btn-large btn-theme btn-rounded"
  type="submit" name="btn" value="submit" ></td>
            </table>
            </form>
             <%@include file="footer.jspf" %>    
</body>
</html>
