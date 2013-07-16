<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getYouTubeVideoUrl.tag#1 $
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
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articleId" required="true" rtexprvalue="true" %>
<%@ attribute name="relationTypeName" required="true" rtexprvalue="true" %>
<%@ attribute name="imageVersion" required="false" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<c:set var="previewImageUrl" value="" />

<article:use articleId="${articleId}">
  <c:set var="videoContent" value="${article}" />
</article:use>

<c:set var="relationTypeName" value="${fn:trim(relationTypeName)}" />

<c:if test="${empty imageVersion}">
  <c:set var="areaWidth" value="${requestScope['elementwidth'] > 700 ? '700' : requestScope['elementwidth']}" />
  <c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}" />
  <c:set var="imageVersion" value="w${areaWidth}"/>
</c:if>

<c:if test="${not empty videoContent and not empty videoContent.relatedElements[relationTypeName].items}">
  <c:if test="${videoContent.relatedElements.previewRel.items[0].content.articleTypeName == 'picture'}">
    <c:set var="videoPreviewPicture" value="${videoContent.relatedElements[relationTypeName].items[0]}" />
    <c:set var="previewImageUrl"
           value="${videoPreviewPicture.content.fields.alternates.value[imageVersion].href}" />
  </c:if>
</c:if>

<%
  request.setAttribute(var, jspContext.getAttribute("previewImageUrl"));
%>