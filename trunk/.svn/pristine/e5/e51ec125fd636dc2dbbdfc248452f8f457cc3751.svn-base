<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/helpers/styleAttributes.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>
<jsp:useBean id="records" class="java.util.HashMap"/>


<c:set var="filmstripPattern" value="${carousel.filmstripPosition == 'left' or carousel.filmstripPosition=='right' ? 'Vertical':'Horizontal'}" />
<c:set var="overlayPattern" value="${carousel.overlayPosition == 'left' or carousel.overlayPosition=='right' ? 'Vertical':'Horizontal'}" />

<c:set var="mainDisplayWidth" value="${carousel.mainDisplayWidth}"/>
<c:set var="mainDisplayHeight" value="${carousel.mainDisplayHeight}"/>

<%-- the width of the navigation arrows (only required for horizontal filmstrip) --%>
<c:set var="navigationArrowWidth" value="${0}"/>
<c:if test="${carousel.showNavigationArrows == 'true' and filmstripPattern == 'Horizontal' }">
  <c:set var="navigationArrowWidth" value="${20}" />
</c:if>

<%-- the height of the navigation arrows (only required for vertical filmstrip) --%>
<c:set var="navigationArrowHeight" value="${0}"/>
<c:if test="${carousel.showNavigationArrows == 'true' and filmstripPattern == 'Vertical' }">
  <c:set var="navigationArrowHeight" value="${20}" />
</c:if>

<c:set var="mainDisplayWidthExceptArrows" value="${mainDisplayWidth - 2 * navigationArrowWidth}"/>
<c:set var="mainDisplayHeightExceptArrows" value="${mainDisplayHeight - 2 * navigationArrowHeight}"/>

<c:choose>
  <c:when test="${filmstripPattern == 'Horizontal'}">
    <!-- keep 20% of total available space for blank spaces beside filmstrip thumbnails -->
    <c:set var="interThumbnailDistance" value="${mainDisplayWidth * 0.20 / (carousel.maxScrollpaneItems + 1) }"/>
  </c:when>
  <c:otherwise>
    <c:set var="interThumbnailDistance" value="${mainDisplayHeight * 0.20 / (carousel.maxScrollpaneItems+1) }"/>
  </c:otherwise>
</c:choose>

<c:set var="noOfThumbnails" value="${carousel.maxScrollpaneItems}"/>
<c:set var="thumbnailBorderWidth" value="${1}"/>
<c:set var="filmstripTotalWidth" value="${0}"/>
<c:set var="filmstripTotalHeight" value="${0}"/>
<c:set var="thumbnailPadding" value="${5}"/>

<c:choose>
  <c:when test="${carousel.showNavigationIndicators == 'false' }">
    <c:set var="navContainerHeight" value="${0}"/>
    <c:set var="navTopPadding" value="${0}"/>
    <c:set var="navBottomPadding" value="${0}"/>
    <c:set var="navLeftPadding" value="${0}"/>
    <c:set var="navRightPadding" value="${0}"/>
  </c:when>
  <c:otherwise>
    <c:if test="${filmstripPattern == 'Horizontal'}">
      <c:set var="navTopPadding" value="${2}"/>
      <c:set var="navBottomPadding" value="${2}"/>
    </c:if>
    <c:if test="${filmstripPattern == 'Vertical'}">
      <c:set var="navTopPadding" value="${2}"/>
      <c:set var="navBottomPadding" value="${2}"/>
    </c:if>
    <c:set var="navContainerHeight" value="${20}"/>

    <c:set var="navLeftPadding" value="${2}"/>
    <c:set var="navRightPadding" value="${2}"/>
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${filmstripPattern=='Horizontal'}">

    <c:set var="thumbnailWidth" value="${(mainDisplayWidthExceptArrows - interThumbnailDistance)/noOfThumbnails - interThumbnailDistance - 2*thumbnailBorderWidth - 2*thumbnailPadding}"/>
    <c:choose>
      <c:when test="${carousel.filmstripTitleStyle == 'beside'}">
        <c:set var="thumbnailImageWidth" value="${thumbnailWidth * 0.4}" />
      </c:when>
      <c:otherwise>
        <c:set var="thumbnailImageWidth" value="${thumbnailWidth}" />
      </c:otherwise>
    </c:choose>

    <%-- find appropriate thumbnail image version and its dimension --%>
    <c:set var="preferredThumbnailImageWidth" value="${thumbnailImageWidth < 100 ? 100 : thumbnailImageWidth}" />
    <wf-core:getImageRepresentation var="tempThumbnailImageVersion" prefferedWidth="${preferredThumbnailImageWidth}"/>
    <c:set target="${carousel}" property="thumbnailImageVersion" value="${tempThumbnailImageVersion}"/>
    <c:remove var="tempThumbnailImageVersion" scope="request"/>

    <wf-core:getImageDimension var="tempThumbnailImageDimension" imageVersion="${carousel.thumbnailImageVersion}" />
    <c:set target="${carousel}" property="thumbnailImageOriginalWidth" value="${requestScope.tempThumbnailImageDimension.width}"/>
    <c:set target="${carousel}" property="thumbnailImageOriginalHeight" value="${requestScope.tempThumbnailImageDimension.height}"/>
    <c:remove var="tempThumbnailImageDimension" scope="request" />

    <c:set var="thumbnailImageHeight" value="${carousel.thumbnailImageOriginalHeight/carousel.thumbnailImageOriginalWidth * thumbnailImageWidth}"/>
    <c:set var="thumbnailHeight" value="${thumbnailImageHeight}"/>
    <c:set var="scrollableHeight" value="${thumbnailImageHeight+2*thumbnailBorderWidth + 2 * thumbnailPadding}"/>
    <c:set var="horizontalContainer" value="${mainDisplayWidthExceptArrows - 2*interThumbnailDistance}"/>

    <c:if test="${carousel.filmstripPosition == 'top'}">
      <c:set var="filmstripTopPadding" value="${10}"/>
      <c:set var="filmstripBottomPadding" value="${30}"/>
    </c:if>

    <c:if test="${carousel.filmstripPosition == 'bottom'}">
      <c:set var="filmstripTopPadding" value="${30}"/>
      <c:set var="filmstripBottomPadding" value="${10}"/>
    </c:if>

    <c:set var="filmstripRightPadding" value="${interThumbnailDistance}"/>
    <c:set var="filmstripLeftPadding" value="${interThumbnailDistance}"/>
    <c:set var="scrollableContainerHeight" value="${scrollableHeight}"/>
    <c:set var="thumbnailImageWrapperWidth" value="${thumbnailImageWidth}"/>
    <c:set var="thumbnailImageWrapperHeight" value="${thumbnailImageHeight}"/>
    <c:set var="filmstripTotalHeight" value="${scrollableContainerHeight + filmstripTopPadding + filmstripBottomPadding + navTopPadding + navBottomPadding + navContainerHeight}"/>
    <c:set var="navigationTotalHeight" value="${navContainerHeight + navTopPadding + navBottomPadding}"/>

  </c:when>
  <c:otherwise>
    <c:set var="navigationTotalHeight" value="${navContainerHeight + navTopPadding + navBottomPadding}"/>
    <c:set var="filmstripTotalHeight" value="${mainDisplayHeightExceptArrows-navigationTotalHeight}"/>

    <c:set var="filmstripTopPadding" value="${interThumbnailDistance}"/>
    <c:set var="filmstripBottomPadding" value="${interThumbnailDistance}"/>
    <c:if test="${carousel.filmstripPosition == 'left'}">
      <c:set var="filmstripRightPadding" value="${30}"/>
      <c:set var="filmstripLeftPadding" value="${10}"/>
    </c:if>

    <c:if test="${carousel.filmstripPosition == 'right'}">
      <c:set var="filmstripRightPadding" value="${10}"/>
      <c:set var="filmstripLeftPadding" value="${30}"/>
    </c:if>

    
    <c:set var="thumbnailHeight" value="${(filmstripTotalHeight- (noOfThumbnails-1)*interThumbnailDistance-filmstripTopPadding-filmstripBottomPadding )/noOfThumbnails-2*thumbnailBorderWidth}"/>


    <c:set var="thumbnailImageHeight" value="${thumbnailHeight - 2 * thumbnailPadding}"/>

    <%-- find appropriate thumbnail image version and its dimension --%>
    <c:set var="preferredThumbnailImageWidth" value="${16.0 / 9 * thumbnailImageHeight}" />
    <c:set var="preferredThumbnailImageWidth" value="${preferredThumbnailImageWidth < 100 ? 100 : preferredThumbnailImageWidth}" />
    <wf-core:getImageRepresentation var="tempThumbnailImageVersion" prefferedWidth="${preferredThumbnailImageWidth}"/>
    <c:set target="${carousel}" property="thumbnailImageVersion" value="${tempThumbnailImageVersion}"/>
    <c:remove var="tempThumbnailImageVersion" scope="request"/>

    <wf-core:getImageDimension var="tempThumbnailImageDimension" imageVersion="${carousel.thumbnailImageVersion}" />
    <c:set target="${carousel}" property="thumbnailImageOriginalWidth" value="${requestScope.tempThumbnailImageDimension.width}"/>
    <c:set target="${carousel}" property="thumbnailImageOriginalHeight" value="${requestScope.tempThumbnailImageDimension.height}"/>
    <c:remove var="tempThumbnailImageDimension" scope="request" />
    

    <c:set var="thumbnailImageWidth" value="${carousel.thumbnailImageOriginalWidth/carousel.thumbnailImageOriginalHeight*thumbnailImageHeight}"/>
    <c:set var="thumbnailWidth" value="${thumbnailImageWidth + 2 * thumbnailPadding}"/>
    <c:set var="thumbnailImageWrapperWidth" value="${thumbnailImageWidth}"/>
    <c:choose>
      <c:when test="${carousel.filmstripTitleStyle == 'beside'}">
        <c:set var="thumbnailImageWrapperHeight" value="${thumbnailHeight * 0.70}"/>
      </c:when>
      <c:otherwise>
        <c:set var="thumbnailImageWrapperHeight" value="${thumbnailImageHeight}"/>
      </c:otherwise>
    </c:choose>

    <c:set var="filmstripWidth" value="${thumbnailWidth + 2 * thumbnailBorderWidth}"/>
    <c:set var="filmstripTotalWidth" value="${filmstripWidth + filmstripLeftPadding + filmstripRightPadding}"/>
    <c:set var="scrollableHeight" value="${mainDisplayHeightExceptArrows - filmstripTopPadding - filmstripBottomPadding}"/>
    <c:set var="scrollableContainerHeight" value="${scrollableHeight - navigationTotalHeight}"/>
  </c:otherwise>

</c:choose>

<%-- play button styles --%>
<c:choose>
  <c:when test="${mainDisplayWidth <= 300}">
    <c:set var="playButtonStyleName" value="small"/>
    <c:set var="playButtonWidth" value="${25}"/>
    <c:set var="playButtonHeight" value="${25}"/>
  </c:when>
  <c:when test="${mainDisplayWidth <= 620}">
    <c:set var="playButtonStyleName" value="medium"/>
    <c:set var="playButtonWidth" value="${50}"/>
    <c:set var="playButtonHeight" value="${50}"/>
  </c:when>
  <c:otherwise>
    <c:set var="playButtonStyleName" value="large"/>
    <c:set var="playButtonWidth" value="${100}"/>
    <c:set var="playButtonHeight" value="${100}"/>
  </c:otherwise>
</c:choose>

<%-- put attributes in map for further use --%>
<c:set target="${records}" property="filmstripPattern" value="${filmstripPattern}"/>
<c:set target="${records}" property="overlayPattern" value="${overlayPattern}"/>
<c:set target="${records}" property="interThumbnailDistance" value="${interThumbnailDistance}"/>
<c:set target="${records}" property="thumbnailBorderWidth" value="${thumbnailBorderWidth}"/>
<c:set target="${records}" property="navContainerHeight" value="${navContainerHeight}"/>
<c:set target="${records}" property="thumbnailWidth" value="${thumbnailWidth}"/>
<c:set target="${records}" property="thumbnailImageWidth" value="${thumbnailImageWidth}"/>
<c:set target="${records}" property="thumbnailImageHeight" value="${thumbnailImageHeight}"/>
<c:set target="${records}" property="thumbnailImageWrapperWidth" value="${thumbnailImageWrapperWidth}"/>
<c:set target="${records}" property="thumbnailImageWrapperHeight" value="${thumbnailImageWrapperHeight}"/>

<c:set target="${records}" property="noOfThumbnails" value="${noOfThumbnails}"/>
<c:set target="${records}" property="filmstripTotalWidth" value="${filmstripTotalWidth}"/>
<c:set target="${records}" property="filmstripTotalHeight" value="${filmstripTotalHeight}"/>
<c:set target="${records}" property="navTopPadding" value="${navTopPadding}"/>
<c:set target="${records}" property="navBottomPadding" value="${navBottomPadding}"/>
<c:set target="${records}" property="navLeftPadding" value="${navLeftPadding}"/>
<c:set target="${records}" property="navRightPadding" value="${navRightPadding}"/>
<c:set target="${records}" property="scrollableHeight" value="${scrollableHeight}"/>
<c:set target="${records}" property="horizontalContainer" value="${horizontalContainer}"/>
<c:set target="${records}" property="filmstripTopPadding" value="${filmstripTopPadding}"/>
<c:set target="${records}" property="filmstripRightPadding" value="${filmstripRightPadding}"/>
<c:set target="${records}" property="filmstripBottomPadding" value="${filmstripBottomPadding}"/>
<c:set target="${records}" property="filmstripLeftPadding" value="${filmstripLeftPadding}"/>
<c:set target="${records}" property="scrollableContainerHeight" value="${scrollableContainerHeight}"/>
<c:set target="${records}" property="navigationTotalHeight" value="${navigationTotalHeight}"/>
<c:set target="${records}" property="thumbnailHeight" value="${thumbnailHeight}"/>
<c:set target="${records}" property="filmstripWidth" value="${filmstripWidth}"/>

<c:set target="${records}" property="thumbnailPadding" value="${thumbnailPadding}"/>
<c:set target="${records}" property="navigationArrowWidth" value="${navigationArrowWidth}"/>
<c:set target="${records}" property="navigationArrowHeight" value="${navigationArrowHeight}"/>

<c:set target="${records}" property="playButtonStyleName" value="${playButtonStyleName}"/>
<c:set target="${records}" property="playButtonWidth" value="${playButtonWidth}"/>
<c:set target="${records}" property="playButtonHeight" value="${playButtonHeight}"/>

<c:set target="${carousel}" property="records" value="${records}"/>
<c:remove var="records"/>