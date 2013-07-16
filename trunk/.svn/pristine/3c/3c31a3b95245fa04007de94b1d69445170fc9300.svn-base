<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getCurtailedText.tag#3 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%--
  The purpose of this tag is to curtail a given string, if its length exceeds a specified limit.
--%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="inputText" required="true" rtexprvalue="true" %>
<%@ attribute name="maxLength" required="true" rtexprvalue="true" %>
<%@ attribute name="ellipsis" required="false" rtexprvalue="true" %>

<%
  if (StringUtils.isBlank(ellipsis)) {
    ellipsis = "...";
  }

  String resultText = inputText;

  int max;

  if (StringUtils.isBlank(maxLength)) {
    max = Integer.MAX_VALUE;
  } else {
    try {
      max = Integer.parseInt(maxLength);
    } catch (Exception ex) {
      max = Integer.MAX_VALUE;
    }
  }
  
  if (!StringUtils.isBlank(inputText) && inputText.length() > max) {
    resultText = inputText.substring(0, max);
    resultText += ellipsis;
  }

  request.setAttribute(var, resultText);
%>