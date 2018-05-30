
<%@page import="org.apache.catalina.connector.Response"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Set"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.util.zip.CRC32"%>
<%@page import="java.util.zip.Checksum"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.security.MessageDigest"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Airpay</title>
<%
    	String sUserName = application.getInitParameter("UserName");
    	String sPassword = application.getInitParameter("Password");
    	String sSecret = application.getInitParameter("Secret") ;
        String sMerId = application.getInitParameter("MercId") ;
        String sHiddenMode = application.getInitParameter("HiddenMode") ;

        String sEmail = request.getParameter("buyerEmail").trim();
        String sPhone = request.getParameter("buyerPhone").trim();
        String sFName = request.getParameter("buyerFirstName").trim();
        String sLName = request.getParameter("buyerLastName").trim();
        String sAddress = request.getParameter("buyerAddress").trim();
        String sAmount = request.getParameter("amount").trim();
        String sCity = request.getParameter("buyerCity").trim();
        String sState = request.getParameter("buyerState").trim();
        String sPincode = request.getParameter("buyerPinCode").trim();
        String sCountry = request.getParameter("buyerCountry").trim();
		String customvar = request.getParameter("customvar").trim();
        String txnsubtype = request.getParameter("txnsubtype").trim();
	    String sOrderId = request.getParameter("orderid").trim();

        if(sEmail.isEmpty() && sPhone.isEmpty() && sFName.isEmpty() && sLName.isEmpty() && sAmount.isEmpty())
        {
            createsendBack("ALL","error.jsp", response);
        }
        if(sEmail.isEmpty())
        {
            createsendBack("E","error.jsp", response);
        }
        else
        {
            String regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[_A-Za-z0-9-]+)";
            if(!sEmail.matches(regex) || sEmail.length() > 50 )
            {
                createsendBack("VE","error.jsp", response);
            }
        }
        if(sPhone.isEmpty())
        {
            createsendBack("BP","error.jsp", response);
        }
        else
        {
            String regex = "\\d{8,15}";
            if(!sPhone.matches(regex))
            {
                createsendBack("VBP","error.jsp", response);
            }
            
        }
        if(sFName.isEmpty())
        {
            createsendBack("FN","error.jsp", response);
        }
        else
        {
            String regex = "[a-zA-Z]+[a-zA-Z-_]{1,50}";
            if(!sFName.matches(regex))
            {
                createsendBack("VFN","error.jsp", response);
            }

        }
        if(sLName.isEmpty())
        {
            createsendBack("LN","error.jsp", response);
        }
        else
        {
            String regex = "[a-zA-Z]+[ a-zA-Z-_]{1,50}";
            if(!sLName.matches(regex))
            {
                createsendBack("VLN","error.jsp", response);
            }

        }
        if(!sAddress.isEmpty())
        {
            String regex = "[a-zA-Z0-9,/\\;.#$( )-_]{4,255}";
            if(!sAddress.matches(regex))
            {
                createsendBack("VADD","error.jsp", response);
            }
            
        }
        if(!sCity.isEmpty())
        {
            String regex = "[a-zA-Z0-9]{2,50}";
            if(!sCity.matches(regex))
            {
                createsendBack("VCIT","error.jsp", response);
            }

        }
        if(!sState.isEmpty())
        {
            String regex = "[a-zA-Z0-9]{2,50}";
            if(!sState.matches(regex))
            {
                createsendBack("VSTA","error.jsp", response);
            }

        }
        if(!sCountry.isEmpty())
        {
            String regex = "[a-zA-Z0-9]{2,50}";
            if(!sCountry.matches(regex))
            {
                createsendBack("VCON","error.jsp", response);
            }

        }
        if(!sPincode.isEmpty())
        {
            String regex = "[a-zA-Z0-9]{4,8}";
            if(!sPincode.matches(regex))
            {
                createsendBack("VPIN","error.jsp", response);
            }
        }
        if(sAmount.isEmpty())
        {
            createsendBack("A","error.jsp", response);
        }
        else
        {
            String regex = "\\d{1,6}\\.\\d{2}";
            if(!sAmount.matches(regex))
            {
                createsendBack("VA","error.jsp", response);
            }
        }
        
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	String sCurDate = df.format(new Date());
	String sAllData = sEmail+sFName+sLName+sAddress+sCity+sState+sCountry+sAmount+sOrderId+sCurDate;

	String sTemp = sSecret+"@"+sUserName+":|:"+sPassword;
	MessageDigest md1 = MessageDigest.getInstance("SHA-256");
	md1.update(sTemp.getBytes());
	byte byteData[] = md1.digest();
	StringBuffer sb1 = new StringBuffer();
	for (int i = 0; i < byteData.length; i++)
	{
		sb1.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	}
	String sPrivateKey = sb1.toString();


	sAllData = sAllData + sPrivateKey;
	String sChecksum = "";
   try
   {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] array = md.digest(sAllData.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < array.length; ++i)
        {
          sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
       }
        sChecksum = sb.toString();
    } catch (Exception e){}





%>
<%! 
   public void createsendBack(String err,String action,HttpServletResponse response)
   {
       
       try
       {
        PrintWriter out = response.getWriter();

        out.print("<!DOCTYPE HTML>");
    	out.print("<html lang=\"en\"");
    	out.print("<head>");
    	out.print("<meta charset=\"utf-8\" />");
    	out.print("</head>");
    	out.print("<script type=\"text/javascript\">");
    	out.print("function submitForm()");
    	out.print("{");
    	out.print("var form = document.forms[0];");
    	out.print("form.submit();");
    	out.print("}");
    	out.print("</script>");
        out.print("<body onLoad=javascript:submitForm()>");
    	out.print("<form name='errorform' id='errorform' method='post' action='error.jsp'>");
    	out.print("<input type='hidden' id='status' name='status' value='"+err+"'>");
    	out.print("</form>");
    	out.print("</body>");
    	out.print("</html>");
        out.flush();
        out.close();

        }
        catch(Exception e)
        {

        }
   } 
%>
<script type="text/javascript">
function submitForm()
                {
			var form = document.forms[0];
			form.submit();
		}
</script>
</head>
<body onload="javascript:submitForm()">
<center>
<table width="500px;">
	<tr>

		<td align="center" valign="middle">Do Not Refresh or Press Back <br/> Redirecting to airpay</td>
	</tr>
	<tr>
		<td align="center" valign="middle">
                    <form action="https://payments.airpay.co.in/pay/index.php" method="post">
                    <input type="hidden" name="currency" value="356">
                    <input type="hidden" name="isocurrency" value="INR">
                    <input type="hidden" name="orderid" value="<%=sOrderId%>">
                    <input type="hidden" name="privatekey" value="<%=sPrivateKey%>">
                    <input type="hidden" name="checksum" value="<%=sChecksum%>">
                    <input type="hidden" name="mercid" value="<%=sMerId%>">
                    <input type="hidden" name="buyerEmail" value="<%=sEmail%>">
                    <input type="hidden" name="buyerPhone" value="<%=sPhone%>">
                    <input type="hidden" name="buyerFirstName" value="<%=sFName%>">
                    <input type="hidden" name="buyerLastName" value="<%=sLName%>">
                    <input type="hidden" name="buyerAddress" value="<%=sAddress%>">
                    <input type="hidden" name="buyerCity" value="<%=sCity%>">
                    <input type="hidden" name="buyerState" value="<%=sState%>">
                    <input type="hidden" name="buyerCountry" value="<%=sCountry%>">
                    <input type="hidden" name="buyerPinCode" value="<%=sPincode%>">
                    <input type="hidden" name="amount" value="<%=sAmount%>">
                    <input type="hidden" name="chmod" value="<%=sHiddenMode%>">
					<input type="hidden" name="customvar" value="<%=customvar%>">
                    <input type="hidden" name="txnsubtype" value="<%=txnsubtype%>">
                </form>
		</td>

	</tr>

</table>

</center>

</body>

</html>
