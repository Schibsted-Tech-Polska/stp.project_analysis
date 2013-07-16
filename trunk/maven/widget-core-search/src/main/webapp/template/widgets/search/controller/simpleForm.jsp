<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/controller/simpleForm.jsp#1 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the general controller has already set a HashMap named 'search' in the requestScope --%>
<jsp:useBean id="search" type="java.util.HashMap" scope="request"/>

<c:set var="articleTypes" value="${fn:trim(widgetContent.fields.articleTypes)}" />
<c:if test="${empty articleTypes}">
  <c:set var="articleTypes" value="news" />
</c:if>
<c:set target="${search}" property="articleTypes" value="${articleTypes}"/>

<c:set target="${search}" property="searchAllSections" value="${fn:trim(widgetContent.fields.searchAllSections)}" />
<c:set target="${search}" property="includeSubSections" value="${fn:trim(widgetContent.fields.includeSubSections)}" />
<c:set target="${search}" property="pageLength" value="${fn:trim(widgetContent.fields.pageLength)}" />

<c:set var="searchEngineName" value="${fn:trim(widgetContent.fields.searchEngineName)}" />
<c:if test="${empty searchEngineName}">
  <c:set var="searchEngineName" value="LucySearchEngine" />
</c:if>
<c:set target="${search}" property="searchEngineName" value="${searchEngineName}"/>


<c:choose>
  <c:when test="${search.searchAllSections=='true'}">
    <section:use uniqueName="ece_frontpage">
      <c:set target="${search}" property="includeSectionId" value="${section.id}" />
    </section:use>
    <c:set target="${search}" property="includeSubSections" value="true" />
  </c:when>
  <c:otherwise>
    <c:set target="${search}" property="includeSectionId" value="${section.id}"/>
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${not empty param.searchString}">
    <c:set var="searchString" value="${param.searchString}" />
  </c:when>
  <c:otherwise>
    <c:set var="searchString" value="" />
  </c:otherwise>
</c:choose>

<c:set target="${search}" property="searchString" value="${searchString}" />

<c:set var="searchSectionUniqueName" value="search"/>
<section:use uniqueName="${searchSectionUniqueName}">
  <c:set target="${search}" property="successUrl" value="${section.url}"/>
</section:use>
<c:set target="${search}" property="errorUrl" value="/template/common.jsp"/>
<c:set target="${search}" property="publicationId" value="${publication.id}"/>
<c:set target="${search}" property="sortString" value="score"/>