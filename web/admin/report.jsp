<%-- 
    Document   : report
    Created on : Mar 16, 2019, 4:53:26 PM
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
                   Vector vorderdate=new Vector();
                   Vector delivery=new Vector();
                   Vector customerid=new Vector();
                   Vector totalamount=new Vector();
                   Vector cgst=new Vector();
                   Vector sgst=new Vector(); 
                   Vector shippingcharges=new Vector();
                   Vector order_netamount=new Vector(); 
                   Vector status=new Vector();
                   String msg="",fromdate="",todate="";
                   int f=0, orderdate=0;
                   float orderamount=0;
                   Connection conn=null;
                    //clearing
                   ordernumber=new Vector();
                   vorderdate.clear();
                   delivery.clear();
                   customerid.clear();
                   totalamount.clear();
                   cgst .clear(); 
                   sgst.clear();
                   shippingcharges.clear();
                  order_netamount.clear();
                   status.clear();
                   PreparedStatement stmt=null;
            
                   fromdate=request.getParameter("fromdate");
                   todate=request.getParameter("todate");  
                   Class.forName("com.mysql.jdbc.Driver");
                   conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null);
                   //HttpSession obj=request.getSession(false);  
                   //orderdate=Integer.parseInt(obj.getAttribute("session_orderdate").toString());
                   stmt=conn.prepareStatement("select* from orders where orderdate between ? and ?");
                   stmt.setString(1,fromdate);
                   stmt.setString(2, todate);
                   ResultSet rs=stmt.executeQuery();
                       while(rs.next())
                       {   
                           ordernumber.add(rs.getString("ordernumber"));
                           vorderdate.add(rs.getString("orderdate"));
                          
                           customerid.add(rs.getString("customerid"));
                           totalamount.add(rs.getString("totalamount"));
                           cgst.add(rs.getString("cgst"));
                           sgst.add(rs.getString("sgst"));
                           shippingcharges .add(rs.getString("shippingcharges"));
                          order_netamount.add(rs.getString("order_netamount"));
                           status.add(rs.getString("status"));
                   
                              f=1;
                    
                       }

                       rs.close();
                       stmt.clearParameters();
                       stmt.close();
                       conn.close();

                
          
        %>
        From date:<%=fromdate%> <br>
        To date:<%=todate%><br>
        
       <div style="margin-left: 50px;margin-top: 55px;margin-right: 400px;">
            <table class="table table-hover">
            <%if(f==1)
            {%>
             <thead>
            <tr>
                <th>ordernumber</th> <th>orderdate</th><th>totalamount</th>
                <th>cgst</th><th>sgst</th><th>shippingcharges</th>
                <th>netamount</th><th>status</th>
            </tr>
             </thead>
            <% for(int i=0;i<ordernumber.size();i++){ 
                orderamount=orderamount+Float.parseFloat(order_netamount.get(i).toString());
            %>
             <tbody>
            <tr>  

                <td><%=ordernumber.get(i)%></td>
                <td><%=vorderdate.get(i)%></td>
                <td><%=totalamount.get(i)%></td>
                <td><%=cgst.get(i)%></td>
                <td><%=sgst.get(i)%></td>
                <td><%=shippingcharges.get(i)%></td>
                <td><%=order_netamount.get(i)%></td>
                <td><%=status.get(i)%></td>

            </tr>
            <%
            }            }
            %>
             </tbody>
        </table>
            <br>
            Total orders=<%=ordernumber.size()%>
            <br>
            Total amount earned=<%=orderamount%>
              </div>
    <%@include file="footer.jspf" %>
  </body>
</html>
