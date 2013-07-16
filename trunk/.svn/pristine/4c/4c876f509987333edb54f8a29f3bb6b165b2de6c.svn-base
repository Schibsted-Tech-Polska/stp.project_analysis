<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/handleLineBreaks.tag#1 $
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" type="java.lang.String" %>
<%@ attribute name="value" required="true" rtexprvalue="true" type="java.lang.String" %>

<c:set var="modifiedValue">
  <c:out value="${value}" escapeXml="true"/>
</c:set>

<%
  String modifiedValue = (String) jspContext.getAttribute("modifiedValue");

  if (StringUtils.isBlank(modifiedValue)) {
    modifiedValue = "";
  }

  modifiedValue = modifiedValue.replaceAll("\n", "<br/>").trim();
  request.setAttribute(var, modifiedValue);
%>