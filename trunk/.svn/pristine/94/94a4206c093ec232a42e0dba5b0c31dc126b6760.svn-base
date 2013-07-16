<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/slideshowAttributes.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="slideshow" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${fn:length(slideshow.slideshowPictures) == 1}">
    <c:set var="picture" value="${slideshow.slideshowPictures[0]}"/>
    <c:set target="${slideshow}" property="pictureId" value="widget${widgetContent.id}-picture${picture.content.id}"/>
    <c:set target="${slideshow}" property="pictureCaption" value="${fn:trim(picture.fields.caption)}"/>
    <c:set target="${slideshow}" property="pictureCredits" value="${fn:trim(picture.fields.photographer)}"/>
  </c:when>
  <c:otherwise>
    <c:set var="imageRepresentation" value="${slideshow.imageRepresentation}"/>
    <c:set var="imageGallery" value=""/>

    <c:forEach var="item" items="${slideshow.slideshowPictures}" varStatus="loopStatus">
      <c:set var="image" value="${item.content.fields.alternates.value[imageRepresentation]}"/>
      <c:set var="imageLink" value="${image.href}"/>

      <c:set var="imageCaption" value="${fn:trim(item.fields.caption)}"/>
      <c:set var="imageCredits" value="${fn:trim(item.fields.photographer)}"/>

      <c:choose>
        <c:when test="${not empty imageCredits}">
          <c:set var="imageInfo" value="${imageCaption}<br/>${imageCredits}"/>
        </c:when>
        <c:otherwise>
          <c:set var="imageInfo" value="${imageCaption}"/>
        </c:otherwise>
      </c:choose>

      <c:if test="${loopStatus.first}">
        <c:set target="${slideshow}" property="width" value="${image.width}"/>
        <c:set target="${slideshow}" property="height" value="${image.height}"/>
        <c:set target="${slideshow}" property="prevButtonTitle">
          <fmt:message key="slideshow.widget.previous.button.title"/>
        </c:set>
        <c:set target="${slideshow}" property="nextButtonTitle">
          <fmt:message key="slideshow.widget.next.button.title"/>
        </c:set>

        <c:choose>
          <c:when test="${image.width > 350}">
            <c:set target="${slideshow}" property="infoStyleClass" value="info"/>
            <c:set target="${slideshow}" property="prevButtonUrl" value="${skinUrl}gfx/list/left.png"/>
            <c:set target="${slideshow}" property="nextButtonUrl" value="${skinUrl}gfx/list/right.png"/>
            <c:set target="${slideshow}" property="navStatusText">
              <fmt:message key="slideshow.widget.navigation.status.text"/>
            </c:set>
          </c:when>
          <c:otherwise>
            <c:set target="${slideshow}" property="infoStyleClass" value="info miniInfo"/>
            <c:set target="${slideshow}" property="prevButtonUrl" value="${skinUrl}gfx/list/left-small.png"/>
            <c:set target="${slideshow}" property="nextButtonUrl" value="${skinUrl}gfx/list/right-small.png"/>
            <c:set target="${slideshow}" property="navStatusText">
              <fmt:message key="slideshow.widget.navigation.mini.status.text"/>
            </c:set>
          </c:otherwise>
        </c:choose>
      </c:if>

      <c:choose>
        <c:when test="${empty imageGallery}">
          <c:set var="imageGallery"
                 value="['${imageLink}', '${imageLink}', '_blank', '${imageInfo}']"/>
        </c:when>
        <c:otherwise>
          <c:set var="imageGallery"
                 value="${imageGallery},['${imageLink}', '${imageLink}', '_blank', '${imageInfo}']"/>
        </c:otherwise>
      </c:choose>

      <c:remove var="image" scope="page"/>
      <c:remove var="imageLink" scope="page"/>
      <c:remove var="imageCaption" scope="page"/>
      <c:remove var="imageCredits" scope="page"/>
      <c:remove var="imageInfo" scope="page"/>
    </c:forEach>

    <c:set target="${slideshow}" property="imageGallery" value="${imageGallery}"/>
  </c:otherwise>
</c:choose>