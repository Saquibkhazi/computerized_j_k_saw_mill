<%-- 
    Document   : viewwages
    Created on : 20 Mar, 2019, 3:13:24 PM
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
            Vector slno=new Vector();
            Vector fromdate=new Vector();
            Vector todate=new Vector();
            Vector employeeid=new Vector();
            Vector dayspresent=new Vector();
            Vector perdaywages=new Vector();       
            Vector wagespaid=new Vector();
            Vector paiddate=new Vector();
            
            slno.clear();
            fromdate.clear();
            todate.clear();
            employeeid.clear();       
            dayspresent.clear();        
            perdaywages.clear();       
            wagespaid.clear();       
            paiddate.clear();
                    
            String msg="";
            int f=0;
            Connection conn=null;
            PreparedStatement stmt=null;
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
            HttpSession obj=request.getSession(false);
            stmt=conn.prepareStatement("select * from wages");
            ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {   
                    
                    slno.add(rs.getString("slno"));
                    fromdate.add(rs.getString("fromdate"));
                    todate.add(rs.getString("todate"));
                    employeeid.add(rs.getString("employeeid"));
                    dayspresent.add(rs.getString("dayspresent"));
                    perdaywages.add(rs.getString("perdaywages"));
                    wagespaid.add(rs.getString("wagespaid"));
                    paiddate.add(rs.getString("paiddate"));
                    
                   
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
              <h2>List Of Wages</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">View</a><i class="icon-angle-right"></i></li>
              <li class="active">List of Wages</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
       
        <br>
        <div style="margin-left: 40px;margin-top: 55px;margin-right: 275px;">
            <table class="table table-hover">
      
        <%if(f==1)  {%>
        <thead>   
        <tr>
                <th>Slno</th><th>Fromdate</th> <th>Todate</th><th>Employeeid</th>
                <th>Dayspresent</th><th>Perdaywages</th><th>Wagespaid</th><th>Paiddate</th>
            </tr>
        </thead>
            <% for(int i=0;i<employeeid.size();i++){ %>
            <tr>                
                <td><%=slno.get(i)%></td>
                <td><%=fromdate.get(i)%></td>
                <td><%=todate.get(i)%></td>
                <td><%=employeeid.get(i)%></td>
                <td><%=dayspresent.get(i)%></td>
                <td><%=perdaywages.get(i)%></td>
                <td><%=wagespaid.get(i)%></td>
                <td><%=paiddate.get(i)%></td>
              
             </tr>
           
            <%} 
            }
            else{
                %> Sorry <br>
                No wages is available<%
            }
            %> 
          
         <%@include file="footer.jspf" %>
            </body>
              
</html>
