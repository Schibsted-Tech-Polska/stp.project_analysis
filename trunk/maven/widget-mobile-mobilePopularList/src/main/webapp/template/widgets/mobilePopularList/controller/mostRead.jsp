<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobilePopularList/src/main/webapp/template/widgets/mobilePopularList/controller/mostRead.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This is the controller of the mostRead view of mobilePopularList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="eae" uri="http://www.escenic.com/taglib/escenic-eae" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'mobilePopularList' in the requestScope --%>
<jsp:useBean id="mobilePopularList" type="java.util.HashMap" scope="request"/>

<c:set target="${mobilePopularList}" property="headline" value="${fn:trim(element.fields.title.value)}" />
<c:set target="${mobilePopularList}" property="showCount" value="${fn:trim(widgetContent.fields.showCountRead)}" />
<c:set var="articleSource" value="${fn:trim(widgetContent.fields.sourceRead)}" />
<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameRead)}" />

<c:set var="maxArticles" value="${fn:trim(widgetContent.fields.maxArticlesRead)}" />
<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentTypeRead)}" />
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news" />
</c:if>

<c:set var="age" value="${fn:trim(widgetContent.fields.ageRead)}" />
<c:set var="queryServiceUrl" value="${section.parameters['eae.queryservice.url']}" />

<c:choose>
  <c:when test="${not empty sectionUniqueName}">
    <section:use uniqueName="${sectionUniqueName}">
      <c:set var="sectionId" value="${section.id}" />
    </section:use>

    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      sectionId="${sectionId}"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:when>
  <c:when test="${articleSource == 'current'}">
    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      sectionId="${section.id}"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:when>
  <c:otherwise>
    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:otherwise>
</c:choose>

<collection:createList id="popularItems" type="java.util.ArrayList"/>
<c:forEach var="mostReadArticle" items="${mostReadArticles}">
  <article:use articleId="${mostReadArticle.objId}">
    <jsp:useBean id="popularItem" class="java.util.HashMap" />
    <c:set target="${popularItem}" property="url" value="${article.url}" />
    <c:set target="${popularItem}" property="title" value="${fn:trim(article.title)}" />
    <c:set target="${popularItem}" property="count" value="${mostReadArticle.pageviews}" />
    <collection:add collection="${popularItems}" value="${popularItem}" />
    <c:remove var="popularItem" scope="page" />
  </article:use>
</c:forEach>

<c:set target="${mobilePopularList}" property="items" value="${popularItems}" />

