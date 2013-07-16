
<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/controller/deleteContent.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the changePassword view of the contentActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the general controller has already set a HashMap named 'contentActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<c:set target="${contentActions}" property="action" value="/community/deleteContent" />

<c:url var="successUrl" value="${section.url}">
  <c:param name="articleId" value="${param.articleId}" />
  <c:param name="contentActions" value="success" />
</c:url>

<c:url var="errorUrl" value="${section.url}">
  <c:param name="articleId" value="${param.articleId}" />
</c:url>

<c:set target="${contentActions}" property="successUrl" value="${successUrl}"/>
<c:set target="${contentActions}" property="errorUrl" value="${errorUrl}" />