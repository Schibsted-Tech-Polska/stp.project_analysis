<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-popularList/src/main/webapp/template/widgets/popularList/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- This is the general controller of popularList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create the HashMap that will contain relevant field values --%>
<jsp:useBean id="popularList" class="java.util.HashMap" scope="request"/>

<c:set target="${popularList}" property="styleClass" value="popularList"/>
<c:set target="${popularList}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${popularList}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${popularList}" property="view" value="${fn:trim(widgetContent.fields.view)}" />
<c:set target="${popularList}" property="showLeadtext" value="${fn:trim(widgetContent.fields.showLeadtext.value)}" />
<c:set target="${popularList}" property="showCommentCount" value="${fn:trim(widgetContent.fields.showCommentCount.value)}" />
<c:set target="${popularList}" property="showRelatedPicture" value="${fn:trim(widgetContent.fields.showRelatedPicture.value)}" />
<c:set target="${popularList}" property="maxLeadtextChar" value="${fn:trim(widgetContent.fields.maxLeadtextChar.value)}" />


<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersion.value)}"/>
<c:if test="${empty imageVersion}">
  <c:set var="imageVersion" value="w140"/>
</c:if>
<c:set target="${popularList}" property="imageVersion" value="${imageVersion}" />

<c:choose>
  <c:when test="${not empty requestScope.tabbingEnabled and requestScope.tabbingEnabled=='true'}">
    <c:set target="${popularList}" property="tabbingEnabled" value="${true}" />
    <c:set target="${popularList}" property="tabbingStyleClass" value="tabbedView" />
  </c:when>

  <c:otherwise>
    <c:set target="${popularList}" property="tabbingEnabled" value="${false}" />
    <c:set target="${popularList}" property="tabbingStyleClass" value="" />
  </c:otherwise>
</c:choose>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${popularList}" property="wrapperStyleClass">widget popularList ${popularList.view} ${popularList.tabbingStyleClass} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty popularList.customStyleClass}"> ${popularList.customStyleClass}</c:if></c:set>