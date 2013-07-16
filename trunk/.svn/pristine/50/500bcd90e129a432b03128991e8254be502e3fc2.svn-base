<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/slideshows.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the simple view list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="list" type="java.util.Map" scope="request"/>

<c:set target="${list}" property="articleSource" value="${fn:trim(widgetContent.fields.articleSourceSlideshows.value)}"/>
<c:set target="${list}" property="groupName" value="${fn:trim(widgetContent.fields.groupNameSlideshows.value)}"/>
<c:set target="${list}" property="listName" value="${fn:trim(widgetContent.fields.listNameSlideshows.value)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameSlideshows.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${list}" property="itemCount" value="${widgetContent.fields.itemCountSlideshows.value}"/>
<c:set target="${list}" property="includeSubsections" value="${widgetContent.fields.includeSubsectionsSlideshows.value}"/>
<c:set target="${list}" property="slideNav" value="${widgetContent.fields.slideNav.value}"/>
<c:set target="${list}" property="showTitle" value="${widgetContent.fields.showTitleSlideshows.value}"/>

<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersionSlideshows.value)}" />
<c:if test="${empty imageVersion}">
  <c:set var="imageVersion" value="w220" />
</c:if>
<c:set target="${list}" property="imageVersion" value="${imageVersion}" />

<c:set target="${list}" property="contentType" value="gallery"/>

<%--<jsp:include page="helpers/latestArticles.jsp"/>--%>
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

<collection:createList id="slideshowList" type="java.util.ArrayList"/>

<c:set var="count" value="0"/>

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <c:forEach var="articleSummary" items="${requestScope.resultList}" varStatus="loopStatus">
      <article:use articleId="${articleSummary.content.id}">
        <c:if test="${not empty article.relatedElements.pictureRel and fn:length(article.relatedElements.pictureRel.items) > 0 and (count + 0) < (list['itemCount'] + 0)}">
          <jsp:useBean id="slideshow1" class="java.util.HashMap"/>
          <c:set var="slideshow" value="${slideshow1}" scope="request" />
          <c:set target="${slideshow}" property="title" value="${fn:trim(articleSummary.fields.title.value)}"/>
          <c:set target="${slideshow}" property="slideshowPictures" value="${article.relatedElements.pictureRel.items}"/>
          <c:set target="${slideshow}" property="slideshowDivId" value="widget${widgetContent.id}-slideshow${article.id}"/>
          <c:set target="${slideshow}" property="imageRepresentation" value="${list.imageVersion}" />
          <c:set target="${slideshow}" property="inpageDnDSummaryClass" value="${articleSummary.options.inpageClasses}"/>

          <jsp:include page="helpers/slideshowAttributes.jsp"/>

          <collection:add collection="${slideshowList}" value="${requestScope.slideshow}"/>
          <c:remove var="slideshow" scope="request"/>
          <c:remove var="slideshow1" />
          <c:set var="count" value="${count + 1}"/>
        </c:if>

      </article:use>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <c:forEach var="slideshowArticle" items="${requestScope.resultList}">
      <c:if test="${not empty slideshowArticle.relatedElements.pictureRel and fn:length(slideshowArticle.relatedElements.pictureRel.items) > 0 and (count + 0) < (list['itemCount'] + 0)}">
        <jsp:useBean id="slideshow2" class="java.util.HashMap"/>
        <c:set var="slideshow" value="${slideshow2}" scope="request" />
        <c:set target="${slideshow}" property="title" value="${fn:trim(slideshowArticle.fields.title.value)}"/>
        <c:set target="${slideshow}" property="slideshowPictures" value="${slideshowArticle.relatedElements.pictureRel.items}"/>
        <c:set target="${slideshow}" property="slideshowDivId" value="widget${widgetContent.id}-slideshow${slideshowArticle.id}"/>
        <c:set target="${slideshow}" property="imageRepresentation" value="${list.imageVersion}" />

        <jsp:include page="helpers/slideshowAttributes.jsp"/>

        <collection:add collection="${slideshowList}" value="${requestScope.slideshow}"/>
        <c:remove var="slideshow" scope="request"/>
        <c:remove var="slideshow2" />
        <c:set var="count" value="${count + 1}"/>

      </c:if>
    </c:forEach>
  </c:otherwise>
</c:choose>


<c:set target="${list}" property="slideshowList" value="${slideshowList}"/>
<c:remove var="slideshowList" scope="request"/>
<c:remove var="resultList" scope="request"/>