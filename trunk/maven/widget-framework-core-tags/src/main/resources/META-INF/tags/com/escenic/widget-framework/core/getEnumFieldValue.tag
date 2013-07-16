<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getEnumFieldValue.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="value" required="true" rtexprvalue="true" %>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="resultValue" value="${fn:trim(value)}" />
<c:if test="${fn:startsWith(resultValue, '<ecs_selection>')}">
  <c:set var="resultValue" value="${fn:substringAfter(resultValue, '<ecs_selection>')}" />
  <c:set var="resultValue" value="${fn:substringBefore(resultValue, '</ecs_selection>')}" />
  <c:set var="resultValue" value="${fn:trim(resultValue)}" />
</c:if>

<%
  request.setAttribute(var, jspContext.getAttribute("resultValue"));
%>