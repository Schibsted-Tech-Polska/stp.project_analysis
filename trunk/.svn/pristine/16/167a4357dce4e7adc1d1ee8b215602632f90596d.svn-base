<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-master/src/main/webapp/template/widgets/master/index.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--this is the entry point of the master widget--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>


<%-- get the master widget nesting limit value from section parameter --%>
<c:set var="masterNestingLimit" value="${section.parameters['master.widget.nesting.limit']}" />
<c:if test="${empty masterNestingLimit}">
  <c:set var="masterNestingLimit" value="2" />
</c:if>

<%-- setting master widget nesting label. for the top label master widget, the label = 1 --%>
<c:choose>
  <c:when test="${empty requestScope.masterNestingLevel}">
    <c:set var="masterNestingLevel" value="1" scope="request" />
  </c:when>
  <c:otherwise>
    <c:set var="masterNestingLevel" value="${requestScope.masterNestingLevel+1}" scope="request" />
  </c:otherwise>
</c:choose>

<%-- we will render master widget only when the master widget nesting limit doesn't exceed --%>
<c:choose>
  <c:when test="${(requestScope.masterNestingLevel+0) <= (masterNestingLimit+0)}">
    <wf-core:view widgetName="master" />
  </c:when>
  <%-- we will display the error message only in preview --%>
  <c:when test="${not empty param.poolId and not empty param.token}">
    <p class="master-widget-nesting-limit-error">
      <fmt:message key="master.widget.nesting.limit.error.message">
        <fmt:param value="${masterNestingLimit}" />
        <fmt:param value="${masterNestingLevel}" />
      </fmt:message>
    </p>
  </c:when>
</c:choose>

<%-- setting master widget nesting label decreased by 1 when the rendering of nested master widget is done --%>
<c:if test="${not empty requestScope.masterNestingLevel}">
  <c:choose>
    <c:when test="${(requestScope.masterNestingLevel+0) > 1}">
      <c:set var="masterNestingLevel" value="${requestScope.masterNestingLevel-1}" scope="request" />
    </c:when>
    <c:otherwise>
      <c:remove var="masterNestingLevel" scope="request" />
    </c:otherwise>
  </c:choose>
</c:if>

<c:remove var="masterNestingLimit" scope="page" />