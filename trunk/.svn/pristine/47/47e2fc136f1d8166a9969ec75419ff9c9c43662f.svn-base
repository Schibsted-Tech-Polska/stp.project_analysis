<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/controller/newsletter.jsp#1 $
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

<c:set target="${stories}" property="source" value="${fn:trim(widgetContent.fields.sourceNewsletter.value)}"/>
<c:set target="${stories}" property="showSectionTitle" value="${fn:trim(widgetContent.fields.showSectionTitleNewsletter.value)}"/>
<c:set target="${stories}" property="selectSectionName"
       value="${fn:trim(widgetContent.fields.selectSectionNameNewsletter.value)}"/>

<c:remove var="articles" scope="request"/>

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
<c:set var="begin" value="${fn:trim(widgetContent.fields.beginNewsletter.value)}"/>
<c:if test="${not empty begin and begin > 0}">
  <c:set var="begin" value="${begin-1}"/>
</c:if>
<c:set var="end" value="${fn:trim(widgetContent.fields.endNewsletter.value)}"/>
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


<c:set target="${stories}" property="maxCharacters"
       value="${fn:trim(widgetContent.fields.maxCharactersNewsletter.value)}"/>
<c:set target="${stories}" property="headingSize" value="${fn:trim(widgetContent.fields.headingSizeNewsletter.value)}"/>
<c:set target="${stories}" property="readMore" value="${fn:trim(widgetContent.fields.readMoreNewsletter.value)}"/>
<c:set target="${stories}" property="showComments"
       value="${fn:trim(widgetContent.fields.showCommentsNewsletter.value)}"/>

<c:set target="${stories}" property="imagePosition"
       value="${fn:trim(widgetContent.fields.imagePositionNewsletter.value)}"/>
<%--<c:set var="imageWidth" value="${fn:trim(widgetContent.fields.imageWidthNewsletter.value)}" scope="page"/>--%>

<%--<c:choose>--%>
  <%--<c:when test="${imageWidth=='80px'}">--%>
    <%--<c:set target="${stories}" property="imageVersion" value="w80"/>--%>
  <%--</c:when>--%>
  <%--<c:when test="${imageWidth=='140px'}">--%>
    <%--<c:set target="${stories}" property="imageVersion" value="${elementwidth < 140 ? 'w80' : 'w140'}"/>--%>
  <%--</c:when>--%>
  <%--<c:when test="${imageWidth=='220px'}">--%>
    <%--<c:set target="${stories}" property="imageVersion" value="${elementwidth < 220 ? 'w80' : 'w220'}"/>--%>
  <%--</c:when>--%>
  <%--<c:when test="${imageWidth=='300px'}">--%>
    <%--<c:set target="${stories}" property="imageVersion" value="${elementwidth < 300 ? 'w140' : 'w300'}"/>--%>
  <%--</c:when>--%>
  <%--<c:otherwise>--%>
    <%--<c:set target="${stories}" property="imageVersion" value="${elementwidth >= 300 ? 'w140' : 'w80'}"/>--%>
  <%--</c:otherwise>--%>
<%--</c:choose>--%>
