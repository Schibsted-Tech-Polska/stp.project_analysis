<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/article/ats.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contentType" value="${article.articleTypeName}"/>

<c:choose>
  <c:when test="${not fn:startsWith(contentType,'widget_')}">
    <jsp:include page="markup/${contentType}.jsp"/>
  </c:when>
  <c:otherwise>
    <c:set var="widgetName" value="${fn:substringAfter(contentType, 'widget_')}" scope="request"/>
    <h2>
      <fmt:message key="widget.preview.error.message">
        <fmt:param value="${widgetName}" />
      </fmt:message>
    </h2>
  </c:otherwise>
</c:choose>
