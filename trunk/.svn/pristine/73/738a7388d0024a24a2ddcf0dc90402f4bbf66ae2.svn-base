<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/simple.jsp#1 $
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

<%-- the general controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<%-- access all the view specific fields --%>
<c:set target="${list}" property="contentType" value="${fn:trim(widgetContent.fields.contentTypeSimple.value)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameSimple.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${list}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountSimple.value)}"/>
<c:set target="${list}" property="includeSubsections" value="${widgetContent.fields.includeSubsectionsSimple.value}"/>
<c:set target="${list}" property="groupName" value="${fn:trim(widgetContent.fields.groupNameSimple.value)}"/>
<c:set target="${list}" property="listName" value="${fn:trim(widgetContent.fields.listNameSimple.value)}"/>
<c:set target="${list}" property="articleSource" value="${fn:trim(widgetContent.fields.articleSourceSimple.value)}"/>

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

<%-- form the list that will contain attribute map for each article --%>
<collection:createList id="attributeMapList" type="java.util.ArrayList" toScope="page"/>

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <c:forEach var="articleSummary" items="${requestScope.resultList}">
      <collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>
      <c:set target="${attributeMap}" property="url" value="${articleSummary.content.url}"/>
      <c:set target="${attributeMap}" property="inpageDnDSummaryClass" value="${articleSummary.options.inpageClasses}"/>
      
      <c:choose>
        <c:when test="${articleSummary.content.articleTypeName == 'picture' and not empty fn:trim(articleSummary.fields.caption.value)}">
          <c:set var="pictureTitle" value="${fn:trim(articleSummary.fields.title.value)}" />
          <c:set var="pictureCaption" value="${fn:trim(articleSummary.fields.caption.value)}" />
          <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
          <c:set target="${attributeMap}" property="inpageTitleClass"
                 value="${not empty pictureCaption ? articleSummary.fields.caption.options.inpageClasses : articleSummary.fields.title.options.inpagecss}"/>
          <c:remove var="pictureTitle" scope="page" />
          <c:remove var="pictureCaption" scope="page" />
        </c:when>
        <c:otherwise>
          <c:set target="${attributeMap}" property="title" value="${fn:trim(articleSummary.fields.title.value)}"/>
          <c:set target="${attributeMap}" property="inpageTitleClass" value="${articleSummary.fields.title.options.inpageClasses}"/>
        </c:otherwise>
      </c:choose>
      <collection:add collection="${attributeMapList}" value="${attributeMap}"/>
      <c:remove var="attributeMap" scope="page"/>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <c:forEach var="cArticle" items="${requestScope.resultList}">
      <collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>
      <c:choose>
        <c:when test="${cArticle.articleTypeName == 'picture' and not empty fn:trim(cArticle.fields.caption.value)}">
          <c:set var="pictureTitle" value="${fn:trim(cArticle.fields.title.value)}" />
          <c:set var="pictureCaption" value="${fn:trim(cArticle.fields.caption.value)}" />
          <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
          <c:set target="${attributeMap}" property="inpageTitleClass"
                 value="${not empty pictureCaption ? cArticle.fields.caption.options.inpageClasses : cArticle.fields.title.options.inpagecss}"/>
          <c:remove var="pictureTitle" scope="page" />
          <c:remove var="pictureCaption" scope="page" />

          <c:set target="${attributeMap}" property="url" value="${cArticle.url}"/>
        </c:when>
        <c:when test="${cArticle.articleTypeName=='posting'}">
          <c:set var="postingTitle" value="${fn:trim(cArticle.fields.title.value)}" />
          <c:set var="postingBody" value="${fn:trim(cArticle.fields.body.value)}" />
          <wf-core:getCurtailedText var="curtailedPostingBody" inputText="${postingBody}" maxLength="20" ellipsis="..."/>
          <c:set target="${attributeMap}" property="title" value="${postingTitle}...${curtailedPostingBody}" />
          <c:remove var="curtailedPostingBody" scope="request"/>
          <c:remove var="postingTitle" scope="page" />
          <c:remove var="postingBody" scope="page" />

          <c:set target="${attributeMap}" property="url" value="#"/>
          <c:set var="postingArticleId" value="${fn:trim(cArticle.fields.articleId)}" />
          <c:if test="${not empty postingArticleId}">
            <article:use articleId="${postingArticleId}">
              <c:set target="${attributeMap}" property="url" value="${article.url}#commentsList" />
            </article:use>
          </c:if>
          <c:remove var="postingArticleId" scope="page" />
        </c:when>
        <c:otherwise>
          <c:set target="${attributeMap}" property="title" value="${fn:trim(cArticle.fields.title.value)}"/>
          <c:set target="${attributeMap}" property="inpageTitleClass" value="${cArticle.fields.title.options.inpageClasses}"/>
          <c:set target="${attributeMap}" property="url" value="${cArticle.url}"/>
        </c:otherwise>
      </c:choose>
      <collection:add collection="${attributeMapList}" value="${attributeMap}"/>
      <c:remove var="attributeMap" scope="page"/>
    </c:forEach>
  </c:otherwise>
</c:choose>

<c:set target="${list}" property="attributeMapList" value="${attributeMapList}"/>
<c:remove var="resultList" scope="request"/>
