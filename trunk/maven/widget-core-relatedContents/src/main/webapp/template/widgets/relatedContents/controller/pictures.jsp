<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/controller/pictures.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the related pictures view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="beginIndex" value="${relatedContents.beginIndex}"/>
<c:set var="endIndex" value="${relatedContents.endIndex}"/>

<c:set var="showCaption" value="${fn:trim(widgetContent.fields.showCaption)}" />
<c:set var="captionStyle" value="${fn:trim(widgetContent.fields.captionStyle)}" />
<c:set var="areaWidth" value="${requestScope.elementwidth > 940 ? '940' : requestScope.elementwidth}" />
<c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}" />
<c:set var="imageVersion" value="w${areaWidth}"/>
<c:set var="softCrop" value="${fn:trim(widgetContent.fields.softCrop)}" />
<c:if test="${not empty article.relatedElements.pictureRel}">
  <c:set var="pictureRelItems" value="${article.relatedElements.pictureRel.items}" />
</c:if>


<c:if test="${empty beginIndex or (not empty pictureRelItems and beginIndex >= fn:length(pictureRelItems)) or beginIndex > endIndex}">
  <c:set var="beginIndex" value="0" />
</c:if>

<c:if test="${empty endIndex or (not empty pictureRelItems and endIndex >= fn:length(pictureRelItems))}">
  <c:set var="endIndex" value="${fn:length(pictureRelItems) > 0 ? fn:length(pictureRelItems)-1 : 0}"/>
</c:if>

<c:choose>
  <c:when test="${fn:contains(captionStyle,'overlay')}">
    <c:set var="captionStyleClass" value="overlay"/>
    <c:set var="horizontalPadding" value="4" />
    <c:set var="captionWidth" value="${areaWidth - 2*horizontalPadding}" />
    <c:set var="captionInlineStyle">
      width:${captionWidth}px;padding-left:${horizontalPadding}px;padding-right:${horizontalPadding}px;
    </c:set>
  </c:when>

  <c:otherwise>
    <c:set var="captionStyleClass" value="default"/>
    <c:set var="captionInlineStyle" value="max-height: 22px;" />
  </c:otherwise>
</c:choose>

<collection:createList id="relatedPictures" type="java.util.ArrayList" />

<c:if test="${not empty pictureRelItems}">
  <c:forEach var="pictureRelItem" items="${pictureRelItems}" begin="${beginIndex}" end="${endIndex}">
    <c:if test="${pictureRelItem.content.articleTypeName=='picture'}">
      <collection:add collection="${relatedPictures}" value="${pictureRelItem}"/>
    </c:if>
  </c:forEach>
</c:if>

<c:set target="${relatedContents}" property="pictures" value="${relatedPictures}"/>
<c:set target="${relatedContents}" property="imageVersion" value="${imageVersion}"/>
<c:set target="${relatedContents}" property="softCrop" value="${softCrop}"/>
<c:set target="${relatedContents}" property="showCaption" value="${showCaption}"/>
<c:set target="${relatedContents}" property="captionStyleClass" value="${captionStyleClass}"/>
<c:set target="${relatedContents}" property="captionInlineStyle" value="${captionInlineStyle}"/>