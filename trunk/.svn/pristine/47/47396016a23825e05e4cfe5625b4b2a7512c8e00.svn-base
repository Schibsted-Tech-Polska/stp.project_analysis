<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/pictures.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the pictures view of list widget --%>

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

<c:set target="${list}" property="contentType" value="picture"/>
<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNamePictures.value)}"/>

<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>

<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${list}" property="articleSource" value="${fn:trim(widgetContent.fields.articleSourcePictures.value)}"/>
<c:set target="${list}" property="groupName" value="${fn:trim(widgetContent.fields.groupNamePictures.value)}"/>
<c:set target="${list}" property="listName" value="${fn:trim(widgetContent.fields.listNamePictures.value)}"/>
<c:set target="${list}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountPictures.value)}"/>
<c:set target="${list}" property="includeSubsections" value="${fn:trim(widgetContent.fields.includeSubsectionsPictures.value)}"/>
<c:set target="${list}" property="showCaption" value="${fn:trim(widgetContent.fields.showCaptionPictures.value)}"/>
<c:set target="${list}" property="showCredits" value="${fn:trim(widgetContent.fields.showCreditsPictures.value)}"/>
<c:set target="${list}" property="pictureCreditsPrefix" value="${fn:trim(widgetContent.fields.pictureCreditsPrefix.value)}"/>
<c:set target="${list}" property="captionStylePictures" value="${fn:trim(widgetContent.fields.captionStylePictures.value)}"/>

<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersionPictures.value)}" />

<c:if test="${empty imageVersion}">
  <c:set var="imageVersion" value="w220" />
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
<collection:createList id="pictureMapList" type="java.util.ArrayList" toScope="page"/>

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent'}">
    <c:forEach var="articleSummary" items="${requestScope.resultList}" varStatus="loopStatus">
      <article:use articleId="${articleSummary.content.id}">
        <c:set var="contentSummary" value="${articleSummary}" scope="request"/>
        <jsp:include page="helpers/pictureAttributes.jsp"/>

        <c:if test="${not empty requestScope.pictureMap}">
          <collection:add collection="${pictureMapList}" value="${requestScope.pictureMap}"/>
        </c:if>

        <c:remove var="pictureMap" scope="request"/>
      </article:use>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <c:forEach var="cArticle" items="${requestScope.resultList}" varStatus="loopStatus">
      <article:use articleId="${cArticle.id}">
        <jsp:include page="helpers/pictureAttributes.jsp"/>
        <c:if test="${not empty requestScope.pictureMap}">
          <collection:add collection="${pictureMapList}" value="${requestScope.pictureMap}"/>
        </c:if>
        <c:remove var="pictureMap" scope="request"/>
      </article:use>
    </c:forEach>
  </c:otherwise>
</c:choose>

<c:set target="${list}" property="picturesList" value="${pictureMapList}"/>
<c:remove var="resultList" scope="request"/>







