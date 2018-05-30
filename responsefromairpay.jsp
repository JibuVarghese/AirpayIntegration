<%@page import="java.util.Enumeration"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.util.zip.CRC32"%>
<%@page import="java.util.zip.Checksum"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.security.MessageDigest"%>

<%@page contentType="text/html" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>airpay</title>
</head>
<body>
	<%
                String transid = request.getParameter("TRANSACTIONID");
                String apTransactionID = request.getParameter("APTRANSACTIONID");
                String amount = request.getParameter("AMOUNT");
                String transtatus = request.getParameter("TRANSACTIONSTATUS");
                String message = request.getParameter("MESSAGE");
                String securehash = request.getParameter("ap_SecureHash");
                String customvar = request.getParameter("CUSTOMVAR");

                String sErrorMSG="";
                if(transid.isEmpty() ||  apTransactionID.isEmpty() || amount.isEmpty() || transtatus.isEmpty() || securehash.isEmpty())
                {
                    if(transid.isEmpty())
                    {
                        sErrorMSG = "TRANSACTIONID";
                    }
                    if(apTransactionID.isEmpty())
                    {
                        sErrorMSG = "APTRANSACTIONID";
                    }
                    if(amount.isEmpty())
                    {
                        sErrorMSG = "AMOUNT";
                    }
                    if(transtatus.isEmpty())
                    {
                        sErrorMSG = "TRANSACTIONSTATUS";
                    }
                    if(securehash.isEmpty())
                    {
                        sErrorMSG = "ap_SecureHash";
                    }

                    sErrorMSG = "<tr><td>Variable(s) "+sErrorMSG+" is/are empty.</td></tr>";
                }


                String MID = application.getInitParameter("MercId");
                String UserName = application.getInitParameter("UserName");

                String sParam = transid + ":" + apTransactionID+ ":" + amount + ":" + transtatus + ":" + message + ":" + MID +":" + UserName;

                CRC32 crc = new CRC32();
                crc.update(sParam.getBytes());
                String sCRC = ""+crc.getValue();

                


	%>

	<center>
        <table width='600px'>
            <tr width='100%'><td align='left' width='50%'>Transaction Id</td><td align='left' width='50%' style='color:black;'><%=transid%></td></tr>
            <tr width='100%'><td align='left' width='50%'>Airpay Transaction Id</td><td align='left' width='50%' style='color:black;'><%=apTransactionID%></td></tr>
            <tr width='100%'><td align='left' width='50%'>Amount</td><td align='left' width='50%' style='color:black;'><%=amount%></td></tr>
            <tr width='100%'><td align='left' width='50%'>Transaction Status Code</td><td align='left' width='50%' style='color:black;'><%=transtatus%></td></tr>
            <tr width='100%'><td align='left' width='50%'>Message</td><td align='left' width='50%' style='color:black;'><%=message%></td></tr>
            <tr width='100%'><td align='left' width='50%'>Status</td>
        <% if(sCRC.equalsIgnoreCase(securehash)){ %>
					<td align='left' width='50%' style='color:green;'>Success</td>
				<% } else{ %>
					<td align='left' width='50%' style='color:red;'>Failed</td>
				<% } %>

                                <%if(!sErrorMSG.isEmpty())
                                    {out.write(sErrorMSG);
                                    }
                                %></tr>
    <tr width='100%'><td align='left' width='50%'>CUSTOMVAR</td><td align='left' width='50%' style='color:black;'><%=customvar%></td></tr>
    </tr></table>




	</center>
</body>
</html>
