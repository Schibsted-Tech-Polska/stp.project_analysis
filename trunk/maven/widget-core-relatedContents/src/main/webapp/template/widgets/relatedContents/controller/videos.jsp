<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/controller/videos.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the related videos view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="beginIndex" value="${relatedContents.beginIndex}"/>
<c:set var="endIndex" value="${relatedContents.endIndex}"/>
<c:set var="videoDisplayStyle" value="${fn:trim(widgetContent.fields.video)}" />
<c:set var="videoRelItems" value="${article.relatedElements.videoRel.items}" />

<c:if test="${empty beginIndex or beginIndex >= fn:length(videoRelItems) or beginIndex > endIndex}">
  <c:set var="beginIndex" value="0" />
</c:if>

<c:if test="${empty endIndex or endIndex >= fn:length(videoRelItems)}">
  <c:set var="endIndex" value="${fn:length(videoRelItems) > 0 ? fn:length(videoRelItems)-1 : 0}"/>
</c:if>

<collection:createList id="relatedVideosList" type="java.util.ArrayList" />
<c:forEach var="video" items="${videoRelItems}" begin="${beginIndex}" end="${endIndex}">
  <c:if test="${video.content.articleTypeName=='youtubeVideo' or
                video.content.articleTypeName=='simpleVideo'}">
    <collection:add collection="${relatedVideosList}" value="${video}" />
  </c:if>
</c:forEach>

<c:set var="videoWidth" value="${requestScope.elementwidth}"/>
<c:set var="videoHeight" value="${(videoWidth+0) * 0.85}" />
<c:if test="${fn:contains(videoHeight, '.')}">
  <c:set var="videoHeight" value="${fn:substringBefore(videoHeight, '.')}" />
</c:if>

<c:set target="${relatedContents}" property="videos" value="${relatedVideosList}"/>
<c:set target="${relatedContents}" property="displayStyle" value="${videoDisplayStyle}"/>
<c:set target="${relatedContents}" property="videoWidth" value="${videoWidth}"/>
<c:set target="${relatedContents}" property="videoHeight" value="${videoHeight}"/>