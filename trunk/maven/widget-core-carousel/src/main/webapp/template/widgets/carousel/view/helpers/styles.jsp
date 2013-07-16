<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/view/helpers/styles.jsp#1 $
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

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>
<c:set var="uniqueId" value="${widgetContent.id}"/>

<c:set var="filmstripPattern" value="${carousel.records.filmstripPattern}" />
<c:set var="overlayPattern" value="${carousel.records.overlayPattern}" />
<c:set var="interThumbnailDistance" value="${carousel.records.interThumbnailDistance}" />
<c:set var="thumbnailBorderWidth" value="${carousel.records.thumbnailBorderWidth}" />
<c:set var="navContainerHeight" value="${carousel.records.navContainerHeight}" />
<c:set var="thumbnailWidth" value="${carousel.records.thumbnailWidth}" />
<c:set var="thumbnailImageWidth" value="${carousel.records.thumbnailImageWidth}" />
<c:set var="thumbnailImageHeight" value="${carousel.records.thumbnailImageHeight}" />
<c:set var="thumbnailImageWrapperWidth" value="${carousel.records.thumbnailImageWrapperWidth}" />
<c:set var="thumbnailImageWrapperHeight" value="${carousel.records.thumbnailImageWrapperHeight}" />

<c:set var="noOfThumbnails" value="${carousel.records.noOfThumbnails}" />
<c:set var="filmstripTotalWidth" value="${carousel.records.filmstripTotalWidth}" />
<c:set var="filmstripTotalHeight" value="${carousel.records.filmstripTotalHeight}" />
<c:set var="navTopPadding" value="${carousel.records.navTopPadding}" />
<c:set var="navBottomPadding" value="${carousel.records.navBottomPadding}" />
<c:set var="navLeftPadding" value="${carousel.records.navLeftPadding}" />
<c:set var="navRightPadding" value="${carousel.records.navRightPadding}" />
<c:set var="scrollableHeight" value="${carousel.records.scrollableHeight}" />
<c:set var="horizontalContainer" value="${carousel.records.horizontalContainer}" />
<c:set var="filmstripTopPadding" value="${carousel.records.filmstripTopPadding}" />
<c:set var="filmstripRightPadding" value="${carousel.records.filmstripRightPadding}" />
<c:set var="filmstripBottomPadding" value="${carousel.records.filmstripBottomPadding}" />
<c:set var="filmstripLeftPadding" value="${carousel.records.filmstripLeftPadding}" />
<c:set var="scrollableContainerHeight" value="${carousel.records.scrollableContainerHeight}" />
<c:set var="navigationTotalHeight" value="${carousel.records.navigationTotalHeight}" />
<c:set var="thumbnailHeight" value="${carousel.records.thumbnailHeight}" />
<c:set var="filmstripWidth" value="${carousel.records.filmstripWidth}" />

<c:set var="thumbnailPadding" value="${carousel.records.thumbnailPadding}" />
<c:set var="navigationArrowWidth" value="${carousel.records.navigationArrowWidth}" />
<c:set var="navigationArrowHeight" value="${carousel.records.navigationArrowHeight}" />

<c:set var="playButtonStyleName" value="${carousel.records.playButtonStyleName}" />
<c:set var="playButtonWidth" value="${carousel.records.playButtonWidth}" />
<c:set var="playButtonHeight" value="${carousel.records.playButtonHeight}" />

<style type="text/css">

  div.carousel div.mainDisplayContainer${uniqueId} {
    width:${carousel.mainDisplayWidth}px;
    height:${carousel.mainDisplayHeight}px;
  }

  div.carousel .scrollable${uniqueId} {
    height: ${scrollableContainerHeight}px;
  }

  div.carousel div.filmstrip${uniqueId} {
    <c:choose>
      <c:when test="${filmstripPattern == 'Horizontal'}">
        padding:${filmstripTopPadding}px ${filmstripRightPadding}px ${filmstripBottomPadding}px ${filmstripLeftPadding}px;
        width:${horizontalContainer}px;
        height: ${scrollableHeight + navContainerHeight + navTopPadding + navBottomPadding}px;
        left:${navigationArrowWidth}px;
      </c:when>

      <%--<c:when test="${carousel.filmstripPosition == 'top'}">
        padding:${filmstripTopPadding}px ${filmstripRightPadding}px ${filmstripBottomPadding}px ${filmstripLeftPadding}px;
        width:${horizontalContainer}px;
        height: ${scrollableHeight + navContainerHeight + navTopPadding + navBottomPadding}px;
        left:${navigationArrowWidth}px;
      </c:when>--%>

      <c:when test="${filmstripPattern == 'Vertical'}">
        padding: ${filmstripTopPadding}px ${filmstripRightPadding}px ${filmstripBottomPadding}px ${filmstripLeftPadding}px;
        width: ${filmstripWidth}px;
        height:${scrollableHeight}px;
        top:${navigationArrowHeight}px;
      </c:when>
  
      <%--<c:when test="${carousel.filmstripPosition == 'right'}">
        padding: ${filmstripTopPadding}px ${filmstripRightPadding}px ${filmstripBottomPadding}px ${filmstripLeftPadding}px;
        width: ${filmstripWidth}px;
        height:${scrollableHeight}px;
        top:${navigationArrowHeight}px;
      </c:when>--%>
    </c:choose>
  }

  div.carousel .scrollable .items div.item${uniqueId} {
    height:${thumbnailImageHeight}px;
    <c:choose>
      <c:when test="${filmstripPattern == 'Horizontal'}">
        width:${thumbnailWidth}px;
        margin: 0 ${interThumbnailDistance}px 0 0;
      </c:when>
      <c:otherwise>
        width:${thumbnailImageWidth}px;
        margin: 0 0 ${interThumbnailDistance}px 0;
      </c:otherwise>
    </c:choose>
  }

  div.carousel .scrollable .items div div.titleSide${uniqueId}{
    <c:if test="${filmstripPattern == 'Horizontal'}">
      <c:set var="sideTextPadding" value="${10}"/>
      padding:${sideTextPadding}px;
      left: ${thumbnailImageWrapperWidth + thumbnailPadding}px;
      width:${thumbnailWidth - thumbnailImageWrapperWidth - 2 * sideTextPadding - 2*thumbnailBorderWidth}px;
      height: ${thumbnailHeight - 2 * thumbnailBorderWidth - 2*sideTextPadding}px;
    </c:if>
    <c:if test="${filmstripPattern == 'Vertical'}">
      <c:set var="sideTextPadding" value="${5}"/>
      padding:${sideTextPadding}px;
      left:${thumbnailPadding}px;
      width:${thumbnailImageWrapperWidth - 2 * thumbnailPadding}px;
      height: ${thumbnailHeight - thumbnailImageWrapperHeight - 2 * thumbnailBorderWidth - 2*sideTextPadding}px;
      top:${thumbnailImageWrapperHeight - 2 * thumbnailBorderWidth }px;
      background-color:#000000;
    </c:if>
  }

  div.carousel div.nav${uniqueId} {
    height: ${navContainerHeight}px;
    padding: ${navTopPadding}px ${navRightPadding}px ${navBottomPadding}px ${navLeftPadding}px;
    position: relative;
    <c:if test="${filmstripPattern == 'Vertical'}">
      top: ${navigationArrowHeight + filmstripBottomPadding}px;
    </c:if>
  }

  <c:if test="${carousel.showFilmstrip == 'true'}">
    div.carousel div.mainDisplayContainer div.bottomOverlay${uniqueId},
    div.carousel div.mainDisplayContainer div.topOverlay${uniqueId}{
        max-width: ${carousel.filmstripPosition == 'top' or carousel.filmstripPosition == 'bottom'? carousel.mainDisplayWidth : carousel.mainDisplayWidth - filmstripTotalWidth}px;
    }

    div.carousel div.mainDisplayContainer div.leftOverlay${uniqueId},
    div.carousel div.mainDisplayContainer div.rightOverlay${uniqueId}{
        max-height: ${carousel.filmstripPosition == 'left' or carousel.filmstripPosition == 'right'? carousel.mainDisplayHeight : carousel.mainDisplayHeight - filmstripTotalHeight}px;
    }

    /* if filmstrip is at left, set left position after the filmstrip, otherwise 0 is set from css */
    <c:if test="${carousel.filmstripPosition == 'left'}">
      div.carousel div.mainDisplayContainer div.leftOverlay${uniqueId}{
        left:${filmstripTotalWidth}px;
      }

      div.carousel div.mainDisplayContainer div.topOverlay${uniqueId}{
        left:${filmstripTotalWidth}px;
      }

      div.carousel div.mainDisplayContainer div.bottomOverlay${uniqueId} {
        left:${filmstripTotalWidth}px;
      }
    </c:if>

    /* if filmstrip is at top, set top position below the filmstrip, otherwise 0 is set from css */
    <c:if test="${carousel.filmstripPosition == 'top'}">
      div.carousel div.mainDisplayContainer div.leftOverlay${uniqueId}{
        top:${filmstripTotalHeight}px;
      }

      div.carousel div.mainDisplayContainer div.rightOverlay${uniqueId}{
        top:${filmstripTotalHeight}px;
      }

      div.carousel div.mainDisplayContainer div.topOverlay${uniqueId}{
        top:${filmstripTotalHeight}px;
      }
    </c:if>
  
    /* if filmstrip is at right, set right position before the filmstrip, otherwise 0 is set from css */
    <c:if test="${carousel.filmstripPosition == 'right'}">
      div.carousel div.mainDisplayContainer div.rightOverlay${uniqueId}{
        right:${filmstripTotalWidth}px;
      }
    </c:if>

    /* if filmstrip is at bottom, set bottom position over the filmstrip, otherwise 0 is set from css */
    <c:if test="${carousel.filmstripPosition == 'bottom'}">
      div.carousel div.mainDisplayContainer div.bottomOverlay${uniqueId} {
        bottom:${filmstripTotalHeight}px; /* height of filmStripInBottom */
      }
    </c:if>

  </c:if>

  <c:if test="${carousel.showNavigationArrows == 'true'}">
    div.carousel a.browseFilmstrip${uniqueId} {
      <c:if test="${filmstripPattern=='Horizontal'}">
        <c:if test="${carousel.filmstripPosition == 'bottom'}">
          top:${(scrollableContainerHeight-20)/2 + filmstripTopPadding}px; /* 20 is the width of the link */
        </c:if>
        <c:if test="${carousel.filmstripPosition == 'top'}">
          top:${ navigationTotalHeight +  (scrollableContainerHeight-20)/2 + filmstripTopPadding}px; /* navigation indicators are over filmstrip */
        </c:if>
      </c:if>
      <c:if test="${filmstripPattern=='Vertical'}">
        left:${(filmstripWidth-20)/2 + filmstripLeftPadding}px; /* 20 is the width of the link */
      </c:if>
    }

  </c:if>


</style>
