<%@ tag import="javax.xml.parsers.SAXParserFactory" %>
<%@ tag import="javax.xml.parsers.SAXParser" %>
<%@ tag import="com.escenic.framework.util.HtmlUtil" %>
<%@ tag import="java.io.ByteArrayInputStream" %>
<%@ tag import="java.util.List" %>
<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/pager.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ tag language="java" body-content="empty" isELIgnored="false" %>
<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="value" required="true" rtexprvalue="true" %>

<%
  String imageUrl = null;

  List<String> urlList = HtmlUtil.parseHTML(value);

  if (urlList.size() > 0) {
    imageUrl = urlList.get(0);
  }

  request.setAttribute(id, imageUrl);
%>