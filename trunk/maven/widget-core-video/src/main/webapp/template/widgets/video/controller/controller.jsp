<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the general controller for the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="video" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${video}" property="styleClass" value="video"/>

<%-- retrive necessary parameters --%>
<c:set target="${video}" property="groupName" value="${fn:trim(widgetContent.fields.groupName)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${video}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set var="contentTypes" value="${fn:trim(widgetContent.fields.contentTypes)}"/>
<c:if test="${empty contentTypes}">
  <c:set var="contentTypes" value="simpleVideo, youtubeVideo"/>
</c:if>
<c:set target="${video}" property="contentTypes" value="${contentTypes}"/>

<c:set target="${video}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${video}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:if test="${not empty video.customStyleClass}">
  <c:set target="${video}" property="styleClass" value="${video.styleClass} ${video.customStyleClass}"/>  
</c:if>

<c:set target="${video}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${video}" property="source" value="${fn:trim(widgetContent.fields.source)}"/>

<c:set var="beginIndex" value="${fn:trim(widgetContent.fields.begin)}" />
<c:if test="${not empty beginIndex and beginIndex > 0}">
  <c:set var="beginIndex" value="${beginIndex-1}" />
</c:if>
<c:set target="${video}" property="beginIndex" value="${fn:trim(beginIndex)}"/>

<c:set var="endIndex" value="${fn:trim(widgetContent.fields.end)}" />
<c:if test="${not empty endIndex and endIndex > 0}">
  <c:set var="endIndex" value="${endIndex-1}" />
</c:if>
<c:set target="${video}" property="endIndex" value="${fn:trim(endIndex)}"/>

<c:set target="${video}" property="maxLatestVideos" value="${fn:trim(widgetContent.fields.maxLatestVideos)}" />
<c:set target="${video}" property="includeSubsections" value="${fn:trim(widgetContent.fields.includeSubsections)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${video}" property="wrapperStyleClass">widget video ${video.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty video.customStyleClass}"> ${video.customStyleClass}</c:if></c:set>