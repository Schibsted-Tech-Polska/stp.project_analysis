<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/list.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/10/04 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="java.net.URL" %>

<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="rssUrl" type="java.lang.String" required="true" rtexprvalue="true" %>

<%
  String sourceName = null;

  try {
    URL url = new URL(rssUrl);
    sourceName = url.getHost();
  } catch (Exception ex) {
    System.err.println(ex);
  }

  request.setAttribute(id, sourceName);
%>