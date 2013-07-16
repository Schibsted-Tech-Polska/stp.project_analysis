<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/controller.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="carousel" class="java.util.HashMap" scope="request"/>

<%-- access the fields that affect all views --%>
<c:set target="${carousel}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>

<c:set target="${carousel}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${carousel}" property="styleClass" value="carousel"/>
<c:set target="${carousel}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${carousel}" property="titleMaxLength" value="${fn:trim(widgetContent.fields.titleMaxLength.value)}"/>
<c:set target="${carousel}" property="leadtextMaxLength" value="${fn:trim(widgetContent.fields.leadtextMaxLength.value)}"/>
<c:set target="${carousel}" property="filmstripPosition" value="${fn:trim(widgetContent.fields.filmstripPosition.value)}"/>
<c:set target="${carousel}" property="navigationPosition" value="${fn:trim(widgetContent.fields.navigationPosition.value)}"/>
<c:set target="${carousel}" property="overlayPosition" value="${fn:trim(widgetContent.fields.overlayPosition.value)}"/>
<c:set target="${carousel}" property="showPrevNextArrows" value="${widgetContent.fields.showPrevNextArrows.value}"/>
<c:set target="${carousel}" property="prevNexArrowPosition" value="${fn:trim(widgetContent.fields.prevNexArrowPosition.value)}"/>
<c:set target="${carousel}" property="maxScrollpaneItems" value="${fn:trim(widgetContent.fields.filmstripPageSize.value)}"/>
<c:set target="${carousel}" property="filmstripTitleStyle" value="${fn:trim(widgetContent.fields.filmstripTitleStyle.value)}"/>
<c:set target="${carousel}" property="maxCharactersFilmstripTitle" value="${fn:trim(widgetContent.fields.maxCharactersFilmstripTitle.value)}"/>
<c:set target="${carousel}" property="maxRelatedItemsCount" value="${fn:trim(widgetContent.fields.maxRelatedItemsCount.value)}"/>
<c:set target="${carousel}" property="autoplayInterval" value="${fn:trim(widgetContent.fields.autoplayInterval.value*1000)}"/>
<c:set target="${carousel}" property="maxArticles" value="${fn:trim(widgetContent.fields.maxItemCount.value)}"/>
<c:set target="${carousel}" property="autoplay" value="${widgetContent.fields.autoplay.value}"/>


<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersion.value)}"/>
<c:if test="${empty imageVersion}">
  <c:set var="areaWidth" value="${requestScope.elementwidth >= 940 ? '940' : requestScope.elementwidth}" />
  <c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}"/>
  <c:set var="imageVersion" value="w${areaWidth}"/>
</c:if>
<c:set target="${carousel}" property="imageVersion" value="${imageVersion}"/>

<wf-core:getImageDimension var="tempMainImageDimension" imageVersion="${carousel.imageVersion}" />
<c:set target="${carousel}" property="mainDisplayWidth" value="${requestScope.tempMainImageDimension.width}"/>
<c:set target="${carousel}" property="mainDisplayHeight" value="${requestScope.tempMainImageDimension.height}"/>
<c:remove var="tempMainImageDimension" scope="request" />

<c:set target="${carousel}" property="defaultImage" value="${requestScope.skinUrl}gfx/carousel/defaultPreview.png"/>
<c:set target="${carousel}" property="defaultThumbnailImage" value="${requestScope.skinUrl}gfx/carousel/defaultPreview.png"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${carousel}" property="wrapperStyleClass">widget carousel ${carousel.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty carousel.customStyleClass}"> ${carousel.customStyleClass}</c:if></c:set>