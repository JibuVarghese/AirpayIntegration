<%-- 
    Document   : error
    Created on : Dec 16, 2013, 7:47:14 PM
    Author     : Nilesh"s
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <%
                    String sStatus = request.getParameter("status").trim();
                    out.write("<div align = 'center'><a href= 'transaction.html'>Back</a></div>");
                    if (sStatus.equals("ALL"))
                    {
                        out.write("All fields are mendatory.");
                    }
                    if (sStatus.equals("E")) {
                        out.write("Please enter email address.");
                    }
                    if (sStatus.equals("VE")) {
                        out.write("Please enter valid email.");
                    }
                    if (sStatus.equals("BP")) {
                        out.write("Please enter phone number.");
                    }
                    if (sStatus.equals("VBP")) {
                        out.write("Please enter valid phone number.");
                    }
                    if (sStatus.equals("FN")) {
                        out.write("Please enter first name.");
                    }
                    if (sStatus.equals("VFN")) {
                        out.write("Please enter valid first name.");
                    }
                    if (sStatus.equals("LN")) {
                        out.write("Please enter last name.");
                    }
                    if (sStatus.equals("VLN")) {
                        out.write("Please enter valid last name.");
                    }
                    if (sStatus.equals("VADD")) {
                        out.write("Please enter valid address.");
                    }
                    if (sStatus.equals("VCIT")) {
                        out.write("Please enter valid City Name.");
                    }
                    if (sStatus.equals("VSTA")) {
                        out.write("Please enter valid State");
                    }
                    if (sStatus.equals("VCON")) {
                        out.write("Please enter valid Country Name.");
                    }
                    if (sStatus.equals("VADD")) {
                        out.write("Please enter valid address.");
                    }
                    if (sStatus.equals("VPIN")) {
                        out.write("Please enter valid PIN.");
                    }
                    if (sStatus.equals("A")) {
                        out.write("Please enter amount.");
                    }
                    if (sStatus.equals("VA")) {
                        out.write("Please enter valid amount.");
                    }

                    out.flush();
                    out.close();
        %>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
