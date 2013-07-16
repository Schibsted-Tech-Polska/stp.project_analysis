<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/videos.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the controller for the videos view of list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<c:set target="${list}" property="contentType" value="simpleVideo,youtubeVideo,videoHubVideo"/>
<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameVideos.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:choose>
    <c:when test="${not empty section}">
      <c:set var="sectionUniqueName" value="${requestScope.section.uniqueName}"/>
    </c:when>
    <c:otherwise>
      <c:set var="sectionUniqueName" value="ece_frontpage"/>
    </c:otherwise>
  </c:choose>
</c:if>
<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${list}" property="articleSource" value="${fn:trim(widgetContent.fields.articleSourceVideos.value)}"/>
<c:set target="${list}" property="groupName" value="${fn:trim(widgetContent.fields.groupNameVideos.value)}"/>
<c:set target="${list}" property="listName" value="${fn:trim(widgetContent.fields.listNameVideos.value)}"/>
<c:set target="${list}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountVideos.value)}"/>
<c:set target="${list}" property="includeSubsections" value="${fn:trim(widgetContent.fields.includeSubsectionsVideos.value)}"/>
<c:set target="${list}" property="showPreviewImage" value="${fn:trim(widgetContent.fields.showPreviewImageVideos.value)}"/>
<c:set target="${list}" property="showCaption" value="${fn:trim(widgetContent.fields.showCaptionVideos.value)}"/>
<c:set target="${list}" property="captionStyle" value="${fn:trim(widgetContent.fields.captionStyleVideos.value)}"/>
<c:set target="${list}" property="showDescription" value="${fn:trim(widgetContent.fields.showDescriptionVideos.value)}"/>
<c:set target="${list}" property="maxDescriptionChar" value="${fn:trim(widgetContent.fields.maxDescriptionCharVideos.value)}"/>

<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersionVideos.value)}" />
<c:if test="${empty imageVersion}">
  <c:set var="imageVersion" value="220" />
</c:if>
<c:set target="${list}" property="imageVersion" value="${imageVersion}" />

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <jsp:include page="helpers/groupedContent.jsp" />
  </c:when>

  <c:when test="${list.articleSource eq 'list'}">
    <jsp:include page="helpers/list.jsp" />
  </c:when>

  <c:otherwise>
    <jsp:include page="helpers/latestArticles.jsp" />
  </c:otherwise>
</c:choose>

<%-- create a list that will contain attribute map for each article--%>
<collection:createList id="videoMapList" type="java.util.ArrayList" toScope="page"/>
<c:set target="${list}" property="previewImageWidth" value="${0}" />

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <c:forEach var="articleSummary" items="${requestScope.resultList}" varStatus="loopStatus">
      <article:use articleId="${articleSummary.content.id}">

        <c:set var="contentSummary" value="${articleSummary}" scope="request"/>
        <jsp:include page="helpers/videoAttributes.jsp"/>
        <c:remove var="contentSummary" scope="request"/>
        <c:if test="${not empty requestScope.videoMap}">
          <collection:add collection="${videoMapList}" value="${requestScope.videoMap}"/>
          <c:if test="${list.previewImageWidth == 0 and not empty requestScope.videoMap.previewImageWidth}">
            <c:set target="${list}" property="previewImageWidth" value="${requestScope.videoMap.previewImageWidth}"/>
            <c:set target="${list}" property="previewImageHeight" value="${requestScope.videoMap.previewImageHeight}"/>
          </c:if>
        </c:if>
        <c:remove var="videoMap" scope="request"/>

      </article:use>
    </c:forEach>
  </c:when>

  <c:otherwise>
    <c:forEach var="cArticle" items="${requestScope.resultList}" varStatus="loopStatus">
      <article:use articleId="${cArticle.id}">

        <jsp:include page="helpers/videoAttributes.jsp"/>
        <c:if test="${not empty requestScope.videoMap}">
          <collection:add collection="${videoMapList}" value="${requestScope.videoMap}"/>
          <c:if test="${list.previewImageWidth == 0 and not empty requestScope.videoMap.previewImageWidth}">
            <c:set target="${list}" property="previewImageWidth" value="${requestScope.videoMap.previewImageWidth}"/>
            <c:set target="${list}" property="previewImageHeight" value="${requestScope.videoMap.previewImageHeight}"/>
          </c:if>
        </c:if>
        <c:remove var="videoMap" scope="request"/>
      </article:use>
    </c:forEach>
  </c:otherwise>

</c:choose>

<c:set target="${list}" property="videoMapList" value="${videoMapList}"/>

<c:if test="${list.previewImageWidth == 0}">
  <wf-core:getImageDimension var="tempImageDimension" imageVersion="${list.imageVersion}" />
  <c:set target="${list}" property="previewImageWidth" value="${requestScope.tempImageDimension.width}"/>
  <c:set target="${list}" property="previewImageHeight" value="${requestScope.tempImageDimension.height}"/>
  <c:remove var="tempImageDimension" scope="request" />
</c:if>

<%-- video play button style --%>
<c:choose>
  <c:when test="${list.previewImageWidth <= 140}">
    <c:set var="playButtonStyleName" value="small"/>
  </c:when>
  <c:when test="${list.previewImageWidth <= 380}">
    <c:set var="playButtonStyleName" value="medium"/>
  </c:when>
  <c:otherwise>
    <c:set var="playButtonStyleName" value="large"/>
  </c:otherwise>
</c:choose>
<c:set target="${list}" property="playButtonStyleName" value="${playButtonStyleName}"/>

<c:remove var="resultList" scope="request"/>
