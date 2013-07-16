<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/controller/column.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%-- declare the map that will contain necessary field values--%>
<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>

<%--read the field values specific to this view --%>
<c:set target="${trailers}" property="maxTrailers" value="${fn:trim(widgetContent.fields.maxTrailersColumn.value)}"/>
<c:set target="${trailers}" property="showSectionName" value="${widgetContent.fields.showSectionNameColumn.value}"/>
<c:set target="${trailers}" property="showComments" value="${fn:trim(widgetContent.fields.showCommentCountColumn.value)}" />
<c:set target="${trailers}" property="trailerWidthColumn" value="${fn:trim(widgetContent.fields.trailerWidthColumn.value)}"/>
<c:set target="${trailers}" property="showTitleColumn" value="${widgetContent.fields.showTitleColumn.value}"/>
<c:set target="${trailers}" property="showIntroColumn" value="${widgetContent.fields.showIntroColumn.value}"/>
<c:set target="${trailers}" property="showImageColumn" value="${widgetContent.fields.showImageColumn.value}"/>
<c:set target="${trailers}" property="maxItems" value="${fn:trim(widgetContent.fields.maxItems.value)}"/>
<c:set target="${trailers}" property="imagePositionColumn" value="${fn:trim(widgetContent.fields.imagePositionColumn.value)}"/>
<c:set target="${trailers}" property="maxCharactersColumn" value="${fn:trim(widgetContent.fields.maxCharactersColumn)}"/>

<!--get the articles from the specified group -->
<c:choose>
  <c:when test="${trailers.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="myGroup"
                              groupName="${trailers.groupName}"
                              areaName="${requestScope.contentAreaName}" />
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${trailers.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>
    <wf-core:getGroupByName var="myGroup"
                              groupName="${trailers.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="groupArticleSummaries" group="${requestScope.myGroup}" contentType="${trailers.contentType}"/>
<c:set var="areaName" value="${trailers.groupName}-area"/>
<c:set target="${trailers}" property="inpageDnDAreaClass" value="${requestScope.myGroup.areas[areaName].options.inpageClasses}"/>

<c:remove var="myGroup" scope="request"/>
<c:set var="articleListSize" value="${fn:length(groupArticleSummaries)}" />

<c:choose>
  <c:when test="${trailers.maxTrailers > articleListSize}">
    <c:set target="${trailers}" property="trailerColumnCount" value="${articleListSize}" />
  </c:when>
  <c:otherwise>
    <c:set target="${trailers}" property="trailerColumnCount" value="${trailers.maxTrailers}" />
  </c:otherwise>
</c:choose>

<collection:createList id="articleMapList" type="java.util.ArrayList" toScope="page"/>

<c:forEach var="articleSummary" items="${requestScope.groupArticleSummaries}" varStatus="outerLoopStatus">
  <c:if test="${outerLoopStatus.count <= trailers.trailerColumnCount}">
    <collection:createMap id="articleMap" type="java.util.HashMap" toScope="page"/>

    <c:choose>
      <c:when test="${outerLoopStatus.first}">
        <c:set target="${articleMap}" property="trailerStyleClass" value="first"/>
      </c:when>
      <c:when test="${outerLoopStatus.count eq trailers.trailerColumnCount}">
        <c:set target="${articleMap}" property="trailerStyleClass" value="last"/>
      </c:when>
    </c:choose>

    <c:set target="${articleMap}" property="articleStyleClass" value="first"/>

    <%--store the teaser image related properties in map--%>
    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"/>
    <c:set target="${articleMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
    <c:remove var="teaserImageMap" scope="request"/>

    <c:set var="articleAttributeMap" value="${articleMap}" scope="request"/>
    <jsp:include page="helpers/imageVersionInColumnView.jsp"/>
    <c:remove var="articleAttributeMap" scope="request"/>

    <c:set target="${articleMap}" property="articleId" value="${articleSummary.content.id}"/>
    <c:set target="${articleMap}" property="url" value="${articleSummary.content.url}"/>
    <c:set target="${articleMap}" property="homeSectionName" value="${articleSummary.content.homeSection.name}"/>
    <c:set target="${articleMap}" property="inpageDnDSummaryClass" value="${articleSummary.options.inpageClasses}"/>

    <wf-core:handleLineBreaks var="title" value="${fn:trim(articleSummary.fields.title.value)}"/>
    <c:set target="${articleMap}" property="title" value="${requestScope.title}"/>
    <c:remove var="title" scope="request"/>
    <c:set target="${articleMap}" property="inpageTitleClass" value="${articleSummary.fields.title.options.inpageClasses}"/>

    <wf-core:getCurtailedText var="intro" inputText="${fn:trim(articleSummary.fields.leadtext.value)}"
                                maxLength="${trailers.maxCharactersColumn}"/>
    <c:set target="${articleMap}" property="intro" value="${requestScope.intro}"/>
    <c:set target="${articleMap}" property="inpageLeadtextClass" value="${articleSummary.fields.leadtext.options.inpageClasses}"/>
    <c:remove var="intro" scope="request"/>

    <c:if test="${trailers.showComments}">
      <wf-core:countArticleComments var="numOfComments" articleId="${articleSummary.content.id}" />
      <c:set target="${articleMap}" property="numOfComments" value="${numOfComments}"/>
      <c:remove var="numOfComments" scope="request" />
    </c:if>

    <c:if test="${trailers.view eq 'column' and trailers.maxItems > 1}">
      <article:list id="articleList"
                    sectionId="${articleSummary.content.homeSection.id}"
                    max="${trailers.maxItems}"
                    includeArticleTypes="${trailers.contentType}"
                    includeSubSections="true"
                    sort="-publishDate"
                    from="${requestScope.articleListDateString}"/>

      <wf-core:filterArticleList var="filteredArticleList" articles="${articleList}"
                                   articleId="${articleSummary.content.id}" maxSize="${trailers.maxItems}"/>

      <collection:createList id="fetchedArticleMapList" type="java.util.ArrayList" toScope="page"/>

      <c:forEach var="cArticle" items="${requestScope.filteredArticleList}" varStatus="innerLoopStatus">
        <collection:createMap id="fetchedArticleMap" type="java.util.HashMap" toScope="page"/>

        <c:if test="${innerLoopStatus.last}">
          <c:set target="${fetchedArticleMap}" property="articleStyleClass" value="last"/>
        </c:if>

        <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${cArticle.id}"/>
        <c:set target="${fetchedArticleMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
        <c:remove var="teaserImageMap" scope="request"/>

        <c:set var="articleAttributeMap" value="${fetchedArticleMap}" scope="request"/>
        <jsp:include page="helpers/imageVersionInColumnView.jsp"/>
        <c:remove var="articleAttributeMap" scope="request"/>

        <c:set target="${fetchedArticleMap}" property="articleId" value="${cArticle.id}"/>
        <c:set target="${fetchedArticleMap}" property="url" value="${cArticle.url}"/>
        <c:set target="${fetchedArticleMap}" property="title" value="${fn:trim(cArticle.fields.title.value)}"/>
        <c:set target="${fetchedArticleMap}" property="inpageTitleClass" value="${cArticle.fields.title.options.inpageClasses}"/>

        <wf-core:getCurtailedText var="intro" inputText="${fn:trim(cArticle.fields.leadtext.value)}"
                                    maxLength="${trailers.maxCharactersColumn}"/>
        <c:set target="${fetchedArticleMap}" property="intro" value="${requestScope.intro}"/>
        <c:remove var="intro" scope="request"/>
        <c:set target="${fetchedArticleMap}" property="inpageLeadtextClass" value="${cArticle.fields.leadtext.options.inpageClasses}"/>

        <collection:add collection="${fetchedArticleMapList}" value="${fetchedArticleMap}"/>
        <c:remove var="fetchedArticleMap" scope="page"/>
      </c:forEach>

      <c:set target="${articleMap}" property="fetchedArticleMapList" value="${fetchedArticleMapList}"/>
      <c:remove var="fetchedArticleMapList" scope="page"/>
      <c:remove var="filteredArticleList" scope="request"/>
    </c:if>

    <collection:add collection="${articleMapList}" value="${articleMap}"/>
    <c:remove var="articleMap" scope="page"/>
  </c:if>
</c:forEach>

<c:set target="${trailers}" property="articleMapList" value="${articleMapList}"/>
<c:remove var="groupArticleSummaries" scope="request"/>
