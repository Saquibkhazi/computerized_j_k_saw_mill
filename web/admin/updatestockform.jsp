<%-- 
    Document   : updatestockform
    Created on : Mar 19, 2019, 5:07:21 PM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession;" %>
<%@page import="java.util.Vector"%>
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
<%!   
       Connection conn=null;
        PreparedStatement stmt=null;
        String msg="";
       
       int stock;
      Vector frameid=new Vector();
     Vector framename=new Vector();
       public void connect()
        {
            try{
             Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null) ;
            }
            catch(Exception ex)
            {
                msg=ex.getMessage();
            }
        }

        public void close()
        {
             try
            {
                stmt.clearParameters();
                conn.close();
            }
            catch(Exception ex){
                msg=ex.getMessage();
        }
    }
    public void getFrames(HttpServletRequest request)
{
    //select * from frames;
     
         {
            try{
//fetch rows from category table to display in dropdownlist
                stmt=conn.prepareStatement("select * from frames");
                ResultSet rs=stmt.executeQuery();
                
//clear vector data
                frameid.clear();
                framename.clear();
                while(rs.next())
                {
           //add rows to vectors
                    frameid.add(rs.getString("frameid"));
                    framename.add(rs.getString("framename"));
                }
                rs.close();
                stmt.close();      
            }
            catch(Exception ex){
                msg=ex.getMessage();
            }
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
            getFrames(request);
            close();
            
        %>
         <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Update Stock</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Update</a><i class="icon-angle-right"></i></li>
              <li class="active">Stock</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
         <br>
        <form method="POST" action="updatestock.jsp">
            <table>
                
               <tr>
                    <td>Select Framename</td>
                    <td><select name="ddlframename">
                            <%
                                 int len=frameid.size();
                                 for(int i=0;i<len;i++){
                                     %>
                                     <option value="<%=frameid.get(i).toString()%>"><%=frameid.get(i).toString()%></option>
                                 <%}%>
                           
                        </select>
                    </td>
                </tr>
             <tr>
                    <td>
                        New Stock
                    </td>
                    <td>
                        <input type="text" name="txtstock" value="<%=stock%>"/>
                    </td>
             </tr>
                            
                    <tr>
                   <td>
                        <input class="btn btn-large btn-theme btn-rounded" type="submit"  name="btn" value="UPDATE"/>
                    </td>
               </tr>
                
            </table>
        </form>
                         <%@include file="footer.jspf" %>
     </body>
</html>