<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStories/src/main/webapp/template/widgets/mobileStories/controller/controller.jsp#1 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="mobileStories" class="java.util.HashMap" scope="request"/>

<c:set target="${mobileStories}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${mobileStories}" property="source" value="${fn:trim(widgetContent.fields.source.value)}"/>
<c:set target="${mobileStories}" property="listSort" value="${fn:trim(widgetContent.fields.listSort.value)}"/>
<c:set target="${mobileStories}" property="imageVersion" value="w460"/>

<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}" scope="request"/>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news" scope="request"/>
</c:if>
<c:set target="${mobileStories}" property="contentType" value="${contentType}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${mobileStories}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set var="includeSubSections" value="${fn:trim(widgetContent.fields.includeSubsections.value)}"/>
<c:set var="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>

<section:use uniqueName="${mobileStories.sectionUniqueName}">
  <c:set target="${mobileStories}" property="sectionId" value="${section.id}"/>
  <c:set target="${mobileStories}" property="sectionName" value="${section.name}"/>
</section:use>

<c:if test="${(mobileStories.source eq 'desked') or (mobileStories.source eq 'fallback')}">
  <%-- first fetch the target group --%>
  <c:choose>
    <c:when test="${mobileStories.sectionUniqueName == section.uniqueName}">
      <wf-core:getGroupByName var="myGroup"
                              groupName="${groupName}"
                              areaName="${requestScope.contentAreaName}"/>
    </c:when>
    <c:otherwise>
      <section:use uniqueName="${mobileStories.sectionUniqueName}">
        <wf-core:getPresentationPool var="myPool" section="${section}"/>
      </section:use>
      <wf-core:getGroupByName var="myGroup"
                              groupName="${groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${myPool}"/>
      <c:remove var="myPool" scope="request"/>
    </c:otherwise>
  </c:choose>
  <%--then fetch articles from the target group --%>
  <c:choose>
    <c:when test="${not empty requestScope.myGroup}">
      <wf-core:getArticleSummariesInGroup var="articles" group="${requestScope.myGroup}"
                                          contentType="${mobileStories.contentType}"/>

      <c:if test="${(empty requestScope.articles or fn:length(requestScope.articles) == 0) and mobileStories.source eq 'fallback'}">
        <c:set target="${mobileStories}" property="source" value="automatic"/>
      </c:if>
    </c:when>
    <c:otherwise>
      <c:if test="${mobileStories.source eq 'fallback'}">
        <c:set target="${mobileStories}" property="source" value="automatic"/>
      </c:if>
    </c:otherwise>
  </c:choose>

  <c:remove var="myGroup" scope="request"/>
</c:if>

<c:if test="${mobileStories.source eq 'automatic'}">
  <article:list id="articleList"
                sectionUniqueName="${mobileStories.sectionUniqueName}"
                max="20"
                includeSubSections="${includeSubSections}"
                sort="${mobileStories.listSort}"
                includeArticleTypes="${mobileStories.contentType}"
                all="true"
                from="${requestScope.articleListDateString}"/>

  <c:set var="articles" value="${articleList}" scope="request"/>
</c:if>

<c:set var="begin" value="${fn:trim(widgetContent.fields.begin.value)}"/>
<c:if test="${not empty begin and begin > 0}">
  <c:set var="begin" value="${begin-1}"/>
</c:if>
<c:set var="end" value="${fn:trim(widgetContent.fields.end.value)}"/>
<c:if test="${not empty end and end > 0}">
  <c:set var="end" value="${end-1}"/>
</c:if>
<c:if test="${empty begin or begin >= fn:length(requestScope.articles) or begin > end}">
  <c:set var="begin" value="0"/>
</c:if>
<c:if test="${empty end or end >= fn:length(requestScope.articles)}">
  <c:set var="end" value="${fn:length(requestScope.articles)-1}"/>
</c:if>

<c:set target="${mobileStories}" property="begin" value="${begin}"/>
<c:set target="${mobileStories}" property="end" value="${end lt 0 ? 0 : end}"/>
<c:set target="${mobileStories}" property="articles" value="${requestScope.articles}"/>
<c:remove var="articles" scope="request"/>

<c:set target="${mobileStories}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}" />
<c:set target="${mobileStories}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileStories}" property="wrapperStyleClass">widget mobileStories ${mobileStories.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileStories.customStyleClass}"> ${mobileStories.customStyleClass}</c:if></c:set>