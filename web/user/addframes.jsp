<%-- 
    Document   : addframes
    Created on : feb 27, 2019, 4:25:57 PM
    Author     : SAQUIB
--%>

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
    </head>
    <body>
<%
        String UPLOAD_DIRECTORY = getServletContext().getRealPath("/upload");
        int ind=UPLOAD_DIRECTORY.indexOf("build");
        UPLOAD_DIRECTORY=UPLOAD_DIRECTORY.substring(0,ind)+"web\\upload";
        String msg="";
        String woodtype="",category="" , frameid="",framename="",framesize="",pic="",filename="";
        int makingcharges=0,price=0,stock=0,totalsize=0;
        float netamount=0;
        Connection conn=null;
        PreparedStatement stmt=null;

     
    try {
       List<FileItem> multiparts = new ServletFileUpload(
            new DiskFileItemFactory()).parseRequest(request);

        for(FileItem item : multiparts){
            if(!item.isFormField()){
                  filename = new File(item.getName()).getName();
                  item.write( new File(UPLOAD_DIRECTORY + File.separator + filename));
            }
        else
        {
          String name = item.getFieldName();
          String value = item.getString();
          if(name.equals("txtwoodtype"))
              woodtype=value;
          else if(name.equals("ddlcategory"))
               category=value;
          else if(name.equals("txtframeid"))
               frameid=value;
          else if(name.equals("txtframename"))
              framename=value;
          else if(name.equals("txtframesize"))
              framesize=value;
          else if(name.equals("txttotalsize"))
              totalsize=Integer.parseInt(value);
          else if(name.equals("txtmakingcharges"))
              makingcharges=Integer.parseInt(value);
           else if(name.equals("txtstock"))
              stock=Integer.parseInt(value);
           else if(name.equals("txtprice"))
              price=Integer.parseInt(value);
          
        }
     }
//insert row into product table    
     Class.forName("com.mysql.jdbc.Driver");
    conn=DriverManager.getConnection("jdbc:mysql://localhost/jksm","root",null) ; 
    netamount=((totalsize/144.0f)*price)+(makingcharges);
   stmt=conn.prepareStatement("insert into frames (woodtype,frameid,framename,framesize,totalsize,makingcharges,netamount,stock,pic,category) values (?,?,?,?,?,?,?,?,?,?)");
        stmt.setString(1,woodtype);
        stmt.setString(2,frameid);
        stmt.setString(3,framename);
        stmt.setString(4,framesize);
        stmt.setInt(5,totalsize);
        stmt.setInt(6,makingcharges);
        stmt.setFloat(7,netamount);
        stmt.setInt(8,stock);
        stmt.setString(9,filename);
        stmt.setString(10,category);
                
        int x=stmt.executeUpdate();
        if(x==1)
            msg="product added";
        else
            msg="product add failed";

        }
        catch(Exception ex){
          msg=ex.getMessage();
        }   
         
 %>
 
<%=msg%>
        </body>
    </html>
