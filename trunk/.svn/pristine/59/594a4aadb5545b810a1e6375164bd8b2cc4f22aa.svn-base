<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getDateObject.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ tag import="java.util.Date" %>

<%--
  Returns:
    a java.util.Date object.
  Attribute:
    timeInMillis: the given milliseconds time value.
--%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="timeInMillis" required="true" %>

<%
  timeInMillis = timeInMillis.trim();
  // due to bug of content engine, sometimes [ & ] appear at the beginning and ending of original meta-data value
  // to avaoid this bug, here is the following extra checking
  if(timeInMillis.startsWith("[")){
    timeInMillis = timeInMillis.substring(1, timeInMillis.length()-2);
  }
  Date eDate = new Date(Long.parseLong(timeInMillis));

  request.setAttribute(var, eDate);
%>