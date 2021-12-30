<%--    
    Document :viewproducts
    Created on : Mar 08, 2019, 2:46:51 PM
    Author     : SAQUIB
--%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
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
    Connection conn = null;
    PreparedStatement stmt = null;
    String msg = "",vcategory="";
        
           Vector woodtype=new Vector();
           Vector frameid=new Vector();
            Vector framename=new Vector();
            Vector framesize=new Vector();
            Vector totalsize=new Vector();
            Vector makingcharges=new Vector();
            Vector amount=new Vector();
            Vector stock=new Vector();
            Vector pic=new Vector();
            Vector quantity=new Vector();
    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void close() {
        try {

            conn.close();
        } catch (Exception ex) {
            msg = ex.getMessage();
        }
    }

    public void getCategory(HttpServletRequest request){
        vcategory=request.getParameter("y");
    }
     
    public void getProducts() {
        try {
            //clear all vector
            woodtype.clear();
            frameid.clear();
            framename.clear();
            framesize.clear();
            totalsize.clear();
            makingcharges.clear();
            amount.clear();
            stock.clear();
            pic.clear();
            stmt = conn.prepareStatement ("select frames.category,woodtype,frameid,framename,framesize,"
                    + "totalsize,makingcharges,netamount,stock,pic from frames  where frames.category=? order by netamount");
            stmt.setString(1, vcategory);
           
                  ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
               woodtype.add(rs.getString("woodtype"));                                                                                                                                
               frameid.add(rs.getString("frameid"));
                framename.add(rs.getString("framename"));
                framesize.add(rs.getString("framesize"));
                totalsize.add(rs.getInt("totalsize"));
                makingcharges.add(rs.getString("makingcharges"));
                amount.add(rs.getFloat("netamount"));
                stock.add(rs.getString("stock"));
                pic.add("..//upload//" + rs.getString("pic"));
            }
        } catch (Exception ex) {
            msg = ex.getMessage();
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
            getCategory(request);
             getProducts();
            close();
        %>
        <form method="post" >
            <section id="inner-headline">
      <div class="container">
        <div class="row">
          <div class="span4">
            <div class="inner-heading">
              <h2>Frames</h2>
            </div>
          </div>
          <div class="span8">
            <ul class="breadcrumb">
              <li><a href="home.jsp"><i class="icon-home"></i></a><i class="icon-angle-right"></i></li>
              <li><a href="#">Category</a><i class="icon-angle-right"></i></li>
              <li class="active">Choose Category </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
        
         <div style="margin-left: 40px;margin-top: 55px;margin-right: 500px;">
            <table class="table table-hover">
            <%
             
                int z,size; 
                String x,y;
               size=frameid.size();
                for (int i = 0; i < size; ) {
            %>
            
            <tr>
                <%for(int j=0;j<3 && i<size;i++,j++){%>
             <th> 
             
                <%y=frameid.get(i).toString();%>
                   <%
                        String xe = "..//upload/" + pic.get(i).toString();
                    %>
                   <img src="<%=xe%>" height="100" width="100"/><br>
            
              WOODTYPE=<%=woodtype.get(i).toString()%><br>     
              FRAMEID=<%=frameid.get(i).toString()%><br>
              FRAMENAME=<%=framename.get(i).toString()%><br>
              FRAMESIZE=<%=framesize.get(i).toString()%><br>
              MAKINGCHARGES=<%=makingcharges.get(i).toString()%><br>
              NETAMOUNT=<%=amount.get(i).toString()%><br>     
              STOCK=<%=stock.get(i).toString()%><br>
             </th>
              <%}%>
            </tr>
            <%  }%>
           
        </table>
         </div>
        </form>
            <%@include file="footer.jspf" %>
    </body>
</html>
