<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/controller/advancedForm.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This is the controller for the default view of search widget. --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>


<%-- the general controller has already set a HashMap named 'search' in the requestScope --%>
<jsp:useBean id="search" type="java.util.HashMap" scope="request"/>

<c:set var="articleTypes" value="${fn:trim(widgetContent.fields.articleTypesAdvanced)}" />
<c:if test="${empty articleTypes}">
  <c:set var="articleTypes" value="news" />
</c:if>
<c:set target="${search}" property="articleTypes" value="${articleTypes}"/>
<c:set target="${search}" property="pageLength" value="${fn:trim(widgetContent.fields.pageLengthAdvanced)}" />

<c:set var="searchEngineName" value="${fn:trim(widgetContent.fields.searchEngineName)}" />
<c:if test="${empty searchEngineName}">
  <c:set var="searchEngineName" value="LucySearchEngine" />
</c:if>
<c:set target="${search}" property="searchEngineName" value="${searchEngineName}"/>

<c:choose>
  <c:when test="${not empty param.searchString}">
    <c:set var="searchString" value="${param.searchString}" />
  </c:when>
  <c:otherwise>
    <c:set var="searchString" value="" />
  </c:otherwise>
</c:choose>

<c:set target="${search}" property="searchString" value="${searchString}" />
<c:set target="${search}" property="from" value="${param.from}"/>
<c:set target="${search}" property="to" value="${param.to}"/>

<c:set var="resultPage" value="${requestScope['com.escenic.search.ResultPage']}"/>
<c:if test="${not empty resultPage}">
  <jsp:useBean id="resultPage" type="com.escenic.search.ResultPage" scope="page"/>
  <c:set target="${search}" property="resultPage" value="${resultPage}"/>
</c:if>

<c:choose>
  <c:when test="${not empty param.includeSectionId}">
    <c:set var="selectedSectionId" value="${param.includeSectionId}"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="ece_frontpage">
      <c:set var="selectedSectionId" value="${section.id}"/>
    </section:use>
  </c:otherwise>
</c:choose>

<c:set target="${search}" property="includeSectionId" value="${selectedSectionId}" />

<c:choose>
  <c:when test="${not empty param.includeSubSections}">
    <c:set var="includeSubSectionsVal" value="${param.includeSubSections}"/>
  </c:when>
  <c:otherwise>
    <c:set var="includeSubSectionsVal" value="true"/>
  </c:otherwise>
</c:choose>
<c:set target="${search}" property="includeSubSections" value="${includeSubSectionsVal}" />

<c:set var="searchSectionUniqueName" value="search"/>
<section:use uniqueName="${searchSectionUniqueName}">
  <c:set target="${search}" property="successUrl" value="${section.url}"/>
  <c:set target="${search}" property="errorUrl" value="${section.url}"/>
</section:use>

<c:set target="${search}" property="publicationId" value="${publication.id}"/>
<c:set target="${search}" property="sortString" value="score"/>

<section:recursiveView id="topLevelSearchSections" depth="1" includeRoot="true" uniqueName="ece_frontpage"/>
<c:set target="${search}" property="topLevelSearchSections" value="${topLevelSearchSections}"/>