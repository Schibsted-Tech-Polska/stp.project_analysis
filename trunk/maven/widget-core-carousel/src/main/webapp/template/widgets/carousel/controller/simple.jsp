<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/simple.jsp#1 $
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

<jsp:useBean id="carousel" class="java.util.HashMap" scope="request"/>

<!--read view specific configurations-->
<c:set target="${carousel}" property="showFilmstrip" value="${widgetContent.fields.showFilmstripSimple.value}"/>
<c:set target="${carousel}" property="showNavigationArrows" value="${widgetContent.fields.showNavigationArrowsSimple.value}"/>
<c:set target="${carousel}" property="showNavigationIndicators" value="${widgetContent.fields.showNavigationIndicatorsSimple.value}"/>
<c:set target="${carousel}" property="showOverlay" value="${widgetContent.fields.showOverlaySimple.value}"/>
<c:set target="${carousel}" property="showLeadText" value="${widgetContent.fields.showLeadTextSimple.value}"/>
<c:set target="${carousel}" property="showCommentCount" value="${widgetContent.fields.showCommentCountSimple.value}"/>
<c:set target="${carousel}" property="showRelatedItems" value="${fn:trim(widgetContent.fields.showRelatedItemsSimple.value)}"/>

<!--style attributes-->
<jsp:include page="helpers/styleAttributes.jsp" />


<%-- access the fields that affect all views --%>
<c:set var="sectionUniqueNameSimple" value="${fn:trim(widgetContent.fields.sectionUniqueNameSimple.value)}"/>
<c:if test="${empty sectionUniqueNameSimple}">
  <c:set var="sectionUniqueNameSimple" value="${section.uniqueName}"/>
</c:if>
<c:set target="${carousel}" property="sectionUniqueNameSimple" value="${sectionUniqueNameSimple}"/>

<c:set target="${carousel}" property="groupNameSimple" value="${fn:trim(widgetContent.fields.groupNameSimple.value)}"/>
<c:set target="${carousel}" property="contentTypesSimple" value="${fn:trim(widgetContent.fields.contentTypesSimple.value)}"/>

<c:set var="sectionUniqueName" value="${carousel.sectionUniqueNameSimple}" scope="request"/>
<c:set var="groupName" value="${carousel.groupNameSimple}" scope="request"/>
<c:set var="contentTypes" value="${carousel.contentTypesSimple}" scope="request"/>
<c:set var="max" value="${carousel.maxArticles}" scope="request"/>
<jsp:include page="helpers/articleAttributes.jsp"/>
<c:remove var="sectionUniqueName" scope="request"/>
<c:remove var="groupName" scope="request"/>
<c:remove var="contentTypes" scope="request"/>
<c:remove var="max" scope="request"/>
