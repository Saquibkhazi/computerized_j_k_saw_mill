<%-- 
    Document   : form
    Created on : 3 Apr, 2019, 5:37:06 AM
    Author     : SAQUIB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <style type="text/css">
      label {
          display: block;
          margin: 5px 0px;
          color: #AAA;
       }
       input {
          display: block;
       }
       input[type=submit] {
          margin-top: 20px;
       }
    </style>
    </head>
    <body>
        <h1>
    Payment Pages: Sample Perl Payment Form with SHA-1
  </h1>

  <form action="https://checkout.globalgatewaye4.firstdata.com/payment" method="POST">
END_HEADER


      my $x_amount = "595.99";
      my $x_login = "WSP-#####-##";  # Take from Payment Page ID in Payment Pages interface
      my $transaction_key = "###############"; # Take from Payment Pages configuration interface
      my $x_currency_code = "USD"; # Needs to agree with the currency of the payment page
      my $x_fp_sequence = int(rand 5000) + 1000;
      my $x_fp_timestamp = time; #  needs to be in UTC. Make sure webserver produces UTC

      #  The values that contribute to x_fp_hash 
      my $hmac_data = $x_login . "^" . $x_fp_sequence . "^" . $x_fp_timestamp . "^" . $x_amount . "^" . $x_currency_code;

      my $x_fp_hash = hmac_sha1_hex($hmac_data, $transaction_key);

      print('<label>x_login</label> <input name="x_login" value="' . $x_login . '">' );
      print('<label>x_amount</label> <input name="x_amount" value="' . $x_amount . '">' );
      print('<label>x_fp_sequence</label> <input name="x_fp_sequence" value="' . $x_fp_sequence . '">' );
      print('<label>x_fp_timestamp</label> <input name="x_fp_timestamp" value="' . $x_fp_timestamp . '">' );
      print('<label>x_fp_hash (with SHA-1)</label> <input name="x_fp_hash" value="' . $x_fp_hash . '" size="50">' );
      print('<label>x_currency_code</label> <input type="hidden" name="x_currency_code" value="' . $x_currency_code . '">');

     print
      <input type="hidden" name="x_show_form" value="PAYMENT_FORM">
      <input type="submit" value="Pay with Payment Pages">
    </form>

    </body>
</html>
END_HEADER;
