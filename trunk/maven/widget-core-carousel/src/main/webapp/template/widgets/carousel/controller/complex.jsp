<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/complex.jsp#1 $
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
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<jsp:useBean id="carousel" class="java.util.HashMap" scope="request"/>

<!--read view specific configurations-->
<c:set target="${carousel}" property="showFilmstrip" value="${widgetContent.fields.showFilmstripComplex.value}"/>
<c:set target="${carousel}" property="showNavigationArrows" value="${widgetContent.fields.showNavigationArrowsComplex.value}"/>
<c:set target="${carousel}" property="showNavigationIndicators" value="${widgetContent.fields.showNavigationIndicatorsComplex.value}"/>
<c:set target="${carousel}" property="showOverlay" value="${widgetContent.fields.showOverlayComplex.value}"/>
<c:set target="${carousel}" property="showLeadText" value="${widgetContent.fields.showLeadTextComplex.value}"/>
<c:set target="${carousel}" property="showCommentCount" value="${widgetContent.fields.showCommentCountComplex.value}"/>
<c:set target="${carousel}" property="showRelatedItems" value="${fn:trim(widgetContent.fields.showRelatedItemsComplex.value)}"/>

<!--style attributes-->
<jsp:include page="helpers/styleAttributes.jsp" />

<collection:createList id="tabList" type="java.util.ArrayList" toScope="page"/>

<c:set var="max" value="${carousel.maxArticles}" scope="request"/>
<c:forEach var="tab" items="${widgetContent.fields.tabs.value}">
  <c:set var="sectionUniqueNameComplex" value="${fn:trim(tab.sectionUniqueNameComplex)}"/>
  <c:if test="${empty sectionUniqueNameComplex}">
    <c:set var="sectionUniqueNameComplex" value="${section.uniqueName}"/>
  </c:if>
  <c:set var="sectionUniqueNameComplex" value="${sectionUniqueNameComplex}"/>
  <c:set var="groupNameComplex" value="${fn:trim(tab.groupNameComplex)}"/>
  <c:set var="contentTypesComplex" value="${fn:trim(tab.contentTypesComplex)}"/>
  <c:set var="tabTitleComplex" value="${fn:trim(tab.tabTitleComplex)}"/>
  <c:set var="sectionUniqueName" value="${sectionUniqueNameComplex}" scope="request"/>
  <c:set var="groupName" value="${groupNameComplex}" scope="request"/>
  <c:set var="contentTypes" value="${contentTypesComplex}" scope="request"/>
  <jsp:include page="helpers/articleAttributes.jsp"/>
  <c:remove var="sectionUniqueName" scope="request"/>
  <c:remove var="groupName" scope="request"/>
  <c:remove var="contentTypes" scope="request"/>

  <c:if test="${not empty carousel.attributeMapList}">
    <collection:createMap id="tabMap" type="java.util.HashMap" toScope="page"/>
    <c:set target="${tabMap}" property="attributeMapList" value="${carousel.attributeMapList}"/>
    <c:set target="${carousel}" property="attributeMapList" value=""/>
    <c:set target="${tabMap}" property="sectionUniqueName" value="${sectionUniqueNameComplex}"/>
    <c:set target="${tabMap}" property="groupName" value="${groupNameComplex}"/>
    <c:set target="${tabMap}" property="contentTypes" value="${contentTypesComplex}"/>
    <c:set target="${tabMap}" property="tabTitle" value="${tabTitleComplex}"/>
    <collection:add collection="${tabList}"  value="${tabMap}"/>
    <c:remove var="tabMap" scope="page"/>
  </c:if>
</c:forEach>
<c:remove var="max" scope="request"/>

<c:set target="${carousel}" property="tabList" value="${tabList}"/>
<c:remove var="tabList" scope="page"/>
