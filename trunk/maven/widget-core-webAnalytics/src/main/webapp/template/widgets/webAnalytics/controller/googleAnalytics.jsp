<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-webAnalytics/src/main/webapp/template/widgets/webAnalytics/controller/googleAnalytics.jsp#1 $
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

<jsp:useBean id="webAnalytics" class="java.util.HashMap" scope="request"/>

<c:set var="accountId" value="${fn:trim(widgetContent.fields.accountIdGoogle)}"/>
<c:if test="${not empty accountId}">
  <c:if test="${not fn:startsWith(accountId,'UA-')}">
    <c:set var="accountId" value="UA-${accountId}"/>
  </c:if>
</c:if>

<c:set target="${webAnalytics}" property="accountId" value="${accountId}"/>
<c:set target="${webAnalytics}" property="domainName" value="${fn:trim(widgetContent.fields.domainNameGoogle)}"/>