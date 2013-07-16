<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/complaintSuccessPopup.jsp#1 $
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
  <link rel="stylesheet" type="text/css" href="${param.skinUrl}css/style.css" />
  <style type="text/css">
    div.comment-success {
      width:550px;
      height:auto;
      margin:30px auto;
      padding:0;
    }
    div.comment-success h2 {
      clear:both;
      font:bold 26px/normal Georgia,Arial,Verdana,Helvetica,sans-serif;
      margin:0 0 30px 0;
      padding:0;
      overflow:hidden;
    }
    div.comment-success p {
      clear:both;
      font:14px/normal Arial,Verdana,Helvetica,sans-serif;
      margin:0;
      padding:0;
      overflow:hidden;
    }
  </style>
  <title>Thanks for your feedback...</title>
</head>

<body>

<div class="comment-success">
  <h2>
    Your complaint has just been reported.
    Appropiate action will be taken after the moderator's approval.
  </h2>

  <p>
    Please <a href="javascript:window.close();"><strong>click here</strong></a> to close this window
    and go back to the article page.
  </p>
</div>

</body>

</html>