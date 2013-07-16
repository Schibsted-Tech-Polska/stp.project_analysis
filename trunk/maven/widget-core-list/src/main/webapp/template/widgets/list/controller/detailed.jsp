<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/detailed.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the detailed view list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%-- the general controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<c:set target="${list}" property="contentType" value="${fn:trim(widgetContent.fields.contentTypeDetailed.value)}"/>
<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameDetailed.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>
<c:set target="${list}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountDetailed.value)}"/>
<c:set target="${list}" property="maxCharacters" value="${fn:trim(widgetContent.fields.maxCharactersDetailed)}"/>
<c:set target="${list}" property="includeSubsections" value="${widgetContent.fields.includeSubsectionsDetailed.value}"/>
<c:set target="${list}" property="showThumb" value="${widgetContent.fields.showThumbDetailed.value}"/>
<c:set target="${list}" property="showIntro" value="${widgetContent.fields.showIntroDetailed.value}"/>
<c:set target="${list}" property="showCommentCount" value="${widgetContent.fields.showCommentCountDetailed.value}"/>
<c:set target="${list}" property="showDate" value="${widgetContent.fields.showDateDetailed.value}"/>
<c:set target="${list}" property="groupName" value="${fn:trim(widgetContent.fields.groupNameDetailed.value)}"/>
<c:set target="${list}" property="listName" value="${fn:trim(widgetContent.fields.listNameDetailed.value)}"/>
<c:set target="${list}" property="articleSource" value="${fn:trim(widgetContent.fields.articleSourceDetailed.value)}"/>
<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersionDetailed.value)}"/>
<c:if test="${empty imageVersion}">
  <c:set var="imageVersion" value="w80"/>
</c:if>
<c:set target="${list}" property="imageVersion" value="${imageVersion}"/>

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormatDetailed.value)}"/>
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMMM dd yyyy hh:mm"/>
</c:if>
<c:set target="${list}" property="dateFormat" value="${dateFormat}"/>
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
<collection:createList id="attributeMapList" type="java.util.ArrayList" toScope="page"/>
<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <c:forEach var="articleSummary" items="${requestScope.resultList}" varStatus="loopStatus">
      <c:set var="articleClass" value="${loopStatus.first ? 'first' : ''}" scope="request"/>
      <article:use articleId="${articleSummary.content.id}">
        <c:set var="contentSummary" value="${articleSummary}" scope="request"/>
        <jsp:include page="helpers/articleAttributes.jsp"/>
        <collection:add collection="${attributeMapList}" value="${requestScope.attributeMap}"/>
        <c:remove var="attributeMap" scope="request"/>
        <c:remove var="contentSummary" scope="request"/>
      </article:use>
      <c:remove var="articleClass" scope="request"/>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <c:forEach var="cArticle" items="${requestScope.resultList}" varStatus="loopStatus">
      <c:set var="articleClass" value="${loopStatus.first ? 'first' : ''}" scope="request"/>
      <article:use articleId="${cArticle.id}">
        <jsp:include page="helpers/articleAttributes.jsp"/>
        <collection:add collection="${attributeMapList}" value="${requestScope.attributeMap}"/>
        <c:remove var="attributeMap" scope="request"/>
      </article:use>
      <c:remove var="articleClass" scope="request"/>
    </c:forEach>
  </c:otherwise>
</c:choose>
<c:set target="${list}" property="attributeMapList" value="${attributeMapList}"/>
<c:remove var="resultList" scope="request"/>

