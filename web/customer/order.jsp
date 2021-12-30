<%--
    Document   : addproduct
    Created on : Mar 7, 2019, 8:25:57 PM
    Author     : SAQUIB
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@ page import="java.io.*" %>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="link.jspf" %>
    </head>
    <%!
        Connection conn = null;
        PreparedStatement stmtcart = null;
        PreparedStatement stmtorder = null;
        PreparedStatement stmtorderdetails = null;

        String msg = "",address="",city="",pincode="",mobile="";
        int flag = 0, ordernumber = 0;
        float cgst = 0, sgst = 0, totalamount = 0, order_netamount = 0, shippingcharges = 0;

        String orderdate = new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());
        Vector frameid = new Vector();
        Vector quantity = new Vector();
        Vector price = new Vector();
        Vector amount = new Vector();

        int customerid = 0;

        public void connect() {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/jksm","root", null);
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

        public void getFromCart(HttpServletRequest request) {
            try {
                //clear vectors
                frameid.clear();
                quantity.clear();
                price.clear();
                amount.clear();
                address=request.getParameter("address");
                city=request.getParameter("city");
                pincode=request.getParameter("pincode");
                mobile=request.getParameter("mobile");
                //get customercode from session
                HttpSession obj = request.getSession(false);
                customerid = Integer.parseInt(obj.getAttribute("session_customerid").toString());
                stmtcart = conn.prepareStatement("select * from cart where customerid=?");
                stmtcart.setInt(1, customerid);
                ResultSet rs = stmtcart.executeQuery();
                //add to vectors
                while (rs.next()) {
                    flag = 1;
                    quantity.add(rs.getString("quantity"));
                    frameid.add(rs.getString("frameid"));
                    price.add(rs.getFloat("price"));
                    amount.add(rs.getFloat("amount"));

                }
                rs.close();
                stmtcart.clearParameters();
                stmtcart.close();

            } catch (Exception ex) {
                flag = 0;
            }

        }

        public void insert() throws Exception {
            try {

                int len = frameid.size();
                float vamount = 0;
                for (int i = 0; i < len; i++) {
                    vamount = Float.parseFloat(amount.get(i).toString());
                    totalamount = totalamount + vamount;
                }
                cgst = 4.0f / 100 * totalamount;
                sgst = cgst;
                shippingcharges = .05f * totalamount;
                order_netamount = cgst + sgst + totalamount + shippingcharges;

                stmtorder = conn.prepareStatement("insert into orders(customerid, orderdate,totalamount, cgst, sgst, shippingcharges,order_netamount,address,city,pincode,mobile)values(?,?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
                stmtorder.setInt(1, customerid);
                stmtorder.setString(2, orderdate);
                stmtorder.setFloat(3, totalamount);
                stmtorder.setFloat(4, cgst);
                stmtorder.setFloat(5, sgst);
                stmtorder.setFloat(6, shippingcharges);
                stmtorder.setFloat(7, order_netamount);
                stmtorder.setString(8,address);
                stmtorder.setString(9,city );
                stmtorder.setString(10,pincode);
                stmtorder.setString(11,mobile);
                
                stmtorder.executeUpdate();
                ResultSet rs1 = stmtorder.getGeneratedKeys();
                rs1.next();
                ordernumber = rs1.getInt(1);
                stmtorder.clearParameters();
                stmtorder.close();

                stmtorderdetails = conn.prepareStatement("insert into orderdetails (ordernumber,frameid,quantity,price,amount) values(?,?,?,?,?)");
                for (int i = 0; i < len; i++) {
                    stmtorderdetails.setInt(1, ordernumber);
                    stmtorderdetails.setString(2, frameid.get(i).toString());
                    stmtorderdetails.setInt(3, Integer.parseInt(quantity.get(i).toString()));
                    stmtorderdetails.setFloat(4, Float.parseFloat(price.get(i).toString()));
                    stmtorderdetails.setFloat(5, Float.parseFloat(amount.get(i).toString()));
                    stmtorderdetails.executeUpdate();
                    stmtorderdetails.clearParameters();
                   
                }
                stmtorderdetails.close();

                //delete from cart
                stmtcart = conn.prepareStatement("delete  from cart where customerid=?");
                stmtcart.setInt(1, customerid);
                stmtcart.executeUpdate();
                stmtcart.clearParameters();
                stmtcart.close();
                msg = "order placed";

            } catch (Exception ex) {
                msg = ex.getMessage();

            }

        }
    %>


    <body>
       
        <form action="orderresult.jsp">
      
            <h3>
                <%

            connect();
            getFromCart(request);
            if (flag == 1) {
                insert();
            } else {
                msg = "no new items in cart";
            }
            close();
            request.setAttribute("errormsg", msg);

            RequestDispatcher rd = request.getRequestDispatcher("vieworder.jsp");
            rd.include(request, response);


            %>
            </h3>
        </form>
       
    </body>
</html>
