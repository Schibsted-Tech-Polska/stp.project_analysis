<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/filterArticleList.tag#1 $
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
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="nameList" type="java.lang.String" required="true" rtexprvalue="true" %>
<%@ attribute name="name" type="java.lang.String" required="true" rtexprvalue="true" %>

<%
  if (StringUtils.isEmpty(nameList) || StringUtils.isEmpty(name)) {
    request.setAttribute(id, Boolean.FALSE);
  }

  String[] names = nameList.split(",");
  Boolean result = Boolean.FALSE;

  for (String s : names) {
    if (name.equalsIgnoreCase(s)) {
      result = Boolean.TRUE;
      break;
    }
  }

  request.setAttribute(id, result);
%>
