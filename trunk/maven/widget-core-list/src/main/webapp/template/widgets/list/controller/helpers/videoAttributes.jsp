<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/videoAttributes.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<%--create the map that will contain various attributes of article --%>
<jsp:useBean id="videoMap" class="java.util.HashMap" scope="request"/>
<c:set var="defaultPreviewImageUrl" value="${requestScope.skinUrl}gfx/list/video-default-thumbnail.png"/>

<wf-core:getImageDimension var="tempImageDimension" imageVersion="${list.imageVersion}" />
<c:set var="defaultPreviewImageWidth" value="${requestScope.tempImageDimension.width}"/>
<c:set var="defaultPreviewImageHeight" value="${requestScope.tempImageDimension.height}"/>
<c:remove var="tempImageDimension" scope="request" />

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent' and not empty requestScope.contentSummary}">
    <c:set var="videoTitle" value="${fn:trim(requestScope.contentSummary.fields.title.value)}"/>
    <c:set var="videoCaption" value="${fn:trim(requestScope.contentSummary.fields.caption.value)}"/>
    <c:set var="inpageTitleClass" value="${requestScope.contentSummary.fields.title.options.inpageClasses}"/>
    <c:set var="inpageCaptionClass" value="${requestScope.contentSummary.fields.caption.options.inpageClasses}"/>
  </c:when>
  <c:otherwise>
    <c:set var="videoTitle" value="${fn:trim(article.fields.title.value)}"/>
    <c:set var="videoCaption" value="${fn:trim(article.fields.caption.value)}"/>
    <c:set var="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
    <c:set var="inpageCaptionClass" value="${article.fields.caption.options.inpageClasses}"/>
  </c:otherwise>
</c:choose>

<c:set target="${videoMap}" property="title" value="${not empty videoCaption ? videoCaption : videoTitle}"/>
<c:set target="${videoMap}" property="inpageTitleClass" value="${not empty videoCaption ? inpageCaptionClass : inpageTitleClass}"/>
<c:set target="${videoMap}" property="inpageDnDSummaryClass" value="${requestScope.contentSummary.options.inpageClasses}"/>
<c:set target="${videoMap}" property="articleId" value="${article.id}"/>
<c:set target="${videoMap}" property="articleUrl" value="${article.url}"/>

<wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${requestScope.contentSummary}" articleId="${article.id}" imageVersion="${list.imageVersion}"/>
<c:choose>
  <c:when test="${not empty requestScope.teaserImageMap}">
    <c:set target="${videoMap}" property="previewImageUrl" value="${requestScope.teaserImageMap.url}"/>
    <c:set target="${videoMap}" property="previewImageWidth" value="${requestScope.teaserImageMap.width}"/>
    <c:set target="${videoMap}" property="previewImageHeight" value="${requestScope.teaserImageMap.height}"/>
  </c:when>
  <c:otherwise>
    <c:set target="${videoMap}" property="previewImageUrl" value="${defaultPreviewImageUrl}"/>
    <c:set target="${videoMap}" property="previewImageWidth" value="${defaultPreviewImageWidth}"/>
    <c:set target="${videoMap}" property="previewImageHeight" value="${defaultPreviewImageHeight}"/>
  </c:otherwise>
</c:choose>
<c:remove var="teaserImageMap" scope="request" />

<c:if test="${list.showDescription == 'true' and not empty requestScope.article}">
  <c:set var="description" value="${article.fields.body.value}" />
  <wf-core:getCurtailedText var="tempCurtailedDescription" inputText="${description}" maxLength="${list.maxDescriptionChar}" ellipsis="..." />
  <c:set target="${videoMap}" property="description" value="${tempCurtailedDescription}"/>
  <c:set target="${videoMap}" property="inpageBodyClass" value="${article.fields.body.options.inpageClasses}"/>
  <c:remove var="tempCurtailedDescription"/>
</c:if>


