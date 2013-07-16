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
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="referenceDate" type="java.util.Date" required="false" rtexprvalue="true" %>
<%@ attribute name="hourDiff" type="java.lang.Long" required="true" rtexprvalue="true" %>

<%
  if(referenceDate == null)
  {
    referenceDate = new java.util.Date();
  }
  java.util.Date date = new java.util.Date(referenceDate.getTime()+(3600000*hourDiff));
  request.setAttribute(id, date);
%>
