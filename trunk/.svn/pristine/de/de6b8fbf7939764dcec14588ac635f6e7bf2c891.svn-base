<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/controller/custom.jsp#1 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="stories" type="java.util.HashMap" scope="request"/>

<c:set target="${stories}" property="source" value="${fn:trim(widgetContent.fields.sourceCustom.value)}"/>
<c:set target="${stories}" property="showSectionTitle" value="${fn:trim(widgetContent.fields.showSectionTitleCustom.value)}"/>
<c:set target="${stories}" property="selectSectionName"
       value="${fn:trim(widgetContent.fields.selectSectionNameCustom.value)}"/>

<c:remove var="articles" scope="request"/>

<c:set var="imageWidth" value="${fn:trim(widgetContent.fields.imageWidthCustom.value)}"/>
<c:set var="imageWidth" value="${fn:substring(imageWidth, 0,fn:length(imageWidth)-2)}"/>

<wf-core:getImageRepresentation var="correctImageVersion" prefferedWidth="${imageWidth}"/>

<c:set target="${stories}" property="imageVersion" value="${correctImageVersion}"/>
<c:remove var="correctImageVersion" scope="request"/>

<c:if test="${(stories.source eq 'desked') or (stories.source eq 'fallback')}">
  <%-- first fetch the target group --%>
  <c:choose>
    <c:when test="${stories.sectionUniqueName == section.uniqueName}">
      <wf-core:getGroupByName var="myGroup"
                                groupName="${stories.groupName}"
                                areaName="${requestScope.contentAreaName}"/>
    </c:when>
    <c:otherwise>
      <section:use uniqueName="${stories.sectionUniqueName}">
        <wf-core:getPresentationPool var="myPool" section="${section}"/>
      </section:use>

      <wf-core:getGroupByName var="myGroup"
                                groupName="${stories.groupName}"
                                areaName="${requestScope.contentAreaName}"
                                pool="${myPool}"/>
      <c:remove var="myPool" scope="request"/>
    </c:otherwise>
  </c:choose>
  <%--then fetch articles from the target group --%>
  <c:choose>
    <c:when test="${not empty requestScope.myGroup}">
      <wf-core:getArticleSummariesInGroup var="articles" group="${requestScope.myGroup}"
                                            contentType="${stories.contentType}"/>
      <c:set var="areaName" value="${stories.groupName}-area"/>
      <c:set target="${stories}" property="inpageDnDAreaClass" value="${myGroup.areas[areaName].options.inpageClasses}"/>

      <c:if
          test="${(empty requestScope.articles or fn:length(requestScope.articles) == 0) and stories.source eq 'fallback'}">
        <c:set target="${stories}" property="source" value="automatic"/>
      </c:if>
    </c:when>
    <c:otherwise>
      <c:if test="${stories.source eq 'fallback'}">
        <c:set target="${stories}" property="source" value="automatic"/>
      </c:if>
    </c:otherwise>
  </c:choose>

  <c:remove var="myGroup" scope="request"/>
</c:if>

<c:if test="${stories.source eq 'automatic'}">
  <article:list id="articleList"
                sectionUniqueName="${stories.sectionUniqueName}"
                max="20"
                includeSubSections="${stories.includeSubSections}"
                sort="${stories.listSort}"
                includeArticleTypes="${stories.contentType}"
                all="true"
                from="${requestScope.articleListDateString}"/>

  <c:set var="articles" value="${articleList}" scope="request"/>
</c:if>
<c:set var="begin" value="${fn:trim(widgetContent.fields.beginCustom.value)}"/>
<c:if test="${not empty begin and begin > 0}">
  <c:set var="begin" value="${begin-1}"/>
</c:if>
<c:set var="end" value="${fn:trim(widgetContent.fields.endCustom.value)}"/>
<c:if test="${not empty end and end > 0}">
  <c:set var="end" value="${end-1}"/>
</c:if>
<c:if test="${empty begin or begin >= fn:length(articles) or begin > end}">
  <c:set var="begin" value="0"/>
</c:if>
<c:if test="${empty end or end >= fn:length(articles)}">
  <c:set var="end" value="${fn:length(articles)-1}"/>
</c:if>

<c:set target="${stories}" property="articles" value="${requestScope.articles}"/>

<c:remove var="articles" scope="request"/>

<c:set target="${stories}" property="begin" value="${begin}"/>
<c:set target="${stories}" property="end" value="${end lt 0 ? 0 : end}"/>


<c:set target="${stories}" property="maxCharacters" value="${fn:trim(widgetContent.fields.maxCharactersCustom.value)}" />
<c:set target="${stories}" property="headingSize" value="${fn:trim(widgetContent.fields.headingSizeCustom.value)}" />
<c:set target="${stories}" property="readMore" value="${fn:trim(widgetContent.fields.readMoreCustom.value)}" />
<c:set target="${stories}" property="showComments" value="${fn:trim(widgetContent.fields.showCommentsCustom.value)}" />
<c:set target="${stories}" property="showCaption" value="${fn:trim(widgetContent.fields.showCaptionCustom.value)}" />
<c:set target="${stories}" property="showIntro" value="${fn:trim(widgetContent.fields.showIntroCustom.value)}" />
<c:set target="${stories}" property="showImage" value="${fn:trim(widgetContent.fields.showImageCustom.value)}" />
<c:set target="${stories}" property="textWrap" value="${fn:trim(widgetContent.fields.textWrapCustom.value)}" />
<c:set target="${stories}" property="enableSlideshow" value="${fn:trim(widgetContent.fields.enableSlideshowCustom.value)}" />
<c:set target="${stories}" property="showSectionName" value="${fn:trim(widgetContent.fields.showSectionNameCustom.value)}" />
<c:set target="${stories}" property="sectionNameLink" value="${fn:trim(widgetContent.fields.sectionNameLinkCustom.value)}" />
<c:set target="${stories}" property="sectionNamePrefix" value="${fn:trim(widgetContent.fields.sectionNamePrefixCustom.value)}" />
<c:set target="${stories}" property="imagePosition" value="${fn:trim(widgetContent.fields.imagePositionCustom.value)}" />

<c:if test="${stories.enableSlideshow}">
  <c:set target="${stories}" property="imagePosition" value="top" />
</c:if>

<c:if test="${stories.imagePosition == 'top'}">
  <wf-core:getImageRepresentation var="correctImageVersion" prefferedWidth="${requestScope.elementwidth}"/>
  <c:set target="${stories}" property="imageVersion" value="${correctImageVersion}"/>
  <c:remove var="correctImageVersion" scope="request"/>
</c:if>


<c:set var="showRelated" value="${fn:trim(widgetContent.fields.showRelatedCustom.value)}" />
<c:set var="showRelated" value="${fn:replace(showRelated, '[', '')}" />
<c:set var="showRelated" value="${fn:replace(showRelated, ']', '')}" />
<c:set target="${stories}" property="showRelated" value="${showRelated}" />
<c:set target="${stories}" property="relatedContentHeader" value="${fn:trim(widgetContent.fields.relatedContentHeaderCustom.value)}" />