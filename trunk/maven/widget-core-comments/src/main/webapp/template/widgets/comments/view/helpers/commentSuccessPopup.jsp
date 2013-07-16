<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentSuccessPopup.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
  the purpose of this page is to display the static popup page after posting a new comment. 
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Thanks for your feedback...</title>
</head>

<body>

<script type="text/javascript">
// <![CDATA[
  function gotoCommentsListingPage() {
    window.close();
    if (window.opener && !window.opener.closed) {
      window.opener.location.replace("${param.redirectionUrl}");
    }
  }
// ]]>
</script>

<div class="comment-success">
  <h2>Thanks for posting a comment.</h2>

  <h4>Your comment is being saved.</h4>

  <p style="margin:5px auto;padding:0;">
    <img src="${param.commentsSkinUrl}gfx/comments/ajax-loader.gif" alt="" width="220" height="19" />
  </p>
  
  <p>
    You will be automatically redirected to the comments listing page within <span id="testCountDownTimer">5.0</span> seconds.
    <br/>
    If the page doesn't load automatically, then please
    <a href="javascript:gotoCommentsListingPage();">click here</a> to see the updated comments listing page.
  </p>

  <script type="text/javascript">
    // <![CDATA[
    var milisec=0;
    var seconds=2;
    function displayCountDownTimer() {
      if (milisec<=0) { milisec=9; seconds-=1; }
      if (seconds<=-1) { milisec=0; seconds+=1; }
      else { milisec-=1; }

      if(seconds==0 && milisec==0) {
        gotoCommentsListingPage();
      }
      else {
        getElementById('testCountDownTimer').innerHTML=seconds+"."+milisec;
        window.setTimeout("displayCountDownTimer()",100);
      }
    }
    displayCountDownTimer();
    // ]]>
  </script>
</div>

</body>

</html>