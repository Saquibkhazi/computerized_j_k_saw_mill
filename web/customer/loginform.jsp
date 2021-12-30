<%-- 
    Document   : loginform
    Created on : 10 Jan, 2019, 6:31:49 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <%@include file="link.jspf" %>
    </head>
    <body>
          <%@include file="login_header.jspf" %>
             
              <div class="modal-body">
                <form class="form-horizontal" method="post" action="login.jsp">
                  <div class="control-group">
                    <label class="control-label" for="inputText">Customername</label>
                    <div class="controls">
                      <input type="text" name="txtusername" placeholder="emailid" value="${email}" id="inputText" placeholder="Username">
                    </div>
                  </div>
                  <div class="control-group">
                    <label class="control-label" for="inputSigninPassword">Password</label>
                    <div class="controls">
                      <input type="password" name="txtpassword" placeholder="password" id="inputSigninPassword" placeholder="Password">
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="controls">
                      <button class="btn btn-theme btn-large e_wobble" type="submit" name="btn" value="Login">Login</button>
                    </div>
                    <p>
                     If Not Register Here<a href="regform.jsp">Register here</a> 
                    </p>

                  </div>
                </form>
              </div>

             
                    
         <%@include file="login_footer.jspf" %>
    </body>
</html>
