<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getDate.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This tag returns a date string specifying a time in the past --%>
<%-- The hourDiff attribute specifies the number of hours to go back in the past--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.text.SimpleDateFormat" %>
<%@ tag import="java.util.Date" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="hourDiff" type="java.lang.String" required="true" rtexprvalue="true" %>

<%
  final int DEFAULT_HOURS = 2880;
  int hours = DEFAULT_HOURS;

  if (!StringUtils.isEmpty(hourDiff)) {
    try {
      hours = Integer.parseInt(hourDiff);
    } catch (Exception ex) {
      hours = DEFAULT_HOURS;
    }
  }

  int months = hours/(24*30);

  Calendar calendar = Calendar.getInstance();
  calendar.set(Calendar.HOUR, 0);
  calendar.set(Calendar.MINUTE, 0);
  calendar.add(Calendar.MONTH, -months);
  
  SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
  String dateString = simpleDateFormat.format(calendar.getTime());
  request.setAttribute(var, dateString);
%>