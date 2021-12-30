<%-- 
    Document   : process
    Created on : Mar 13, 2019, 5:27:12 PM
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
    </head>
    <body>

        <form>
            <table>
                <%
                    Vector vordernumber = new Vector();
                    Vector vframeid = new Vector();
                    Vector vquantity = new Vector();
                    Vector vprice = new Vector();
                    Vector vamount = new Vector();

                    vordernumber.clear();
                    vframeid.clear();
                    vquantity.clear();
                    vprice.clear();
                    vamount.clear();

                    String msg = "", frameid = "";
                    int f = 0, ordernumber = 0, i = 0;
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    PreparedStatement stmt1 = null;
                    PreparedStatement stmt2 = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm", "root", null);

                    //fetch orderno from session
                    HttpSession obj = request.getSession(false);
                    ordernumber = Integer.parseInt(obj.getAttribute("session_ordernumber").toString());

                    stmt = conn.prepareStatement("select * from orderdetails where ordernumber=?");
                    stmt.setInt(1, ordernumber);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        vframeid.add(rs.getString("frameid"));
                        vquantity.add(rs.getInt("quantity"));
                        vprice.add(rs.getFloat("price"));
                        vamount.add(rs.getFloat("amount"));
                    }
                    rs.close();
                    stmt.clearParameters();

                    //update stock of frames based on qty of orderdetails
                    int len = vframeid.size();
                    stmt1 = conn.prepareStatement("update frames set stock=stock-? where frameid=?");
                    for (i = 0; i < len; i++) {

                        stmt1.setInt(1, Integer.parseInt(vquantity.get(i).toString()));
                        stmt1.setString(2, vframeid.get(i).toString());
                        stmt1.executeUpdate();
                    }
                    stmt1.clearParameters();
                    stmt1.close();

                    //update status of order
                    stmt2 = conn.prepareStatement("update orders set status='processed' where ordernumber=?");
                    stmt2.setInt(1, ordernumber);
                    stmt2.executeUpdate();
                    stmt2.clearParameters();
                    conn.close();

                    msg = "order number " + ordernumber + " is processed.";
                    request.setAttribute("errormsg", msg);

                    RequestDispatcher rd = request.getRequestDispatcher("viewneworder.jsp");
                    rd.include(request, response);

                %>
            </table>
        </form>

    </body>




