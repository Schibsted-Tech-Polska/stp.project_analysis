<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileVideo/src/main/webapp/template/widgets/mobileVideo/controller/controller.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<!-- video widget controller start -->

<%-- this is the general controller for the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="mobileVideo" class="java.util.HashMap" scope="request" />

<%-- retrive necessary parameters --%>
<c:set target="${mobileVideo}" property="groupName" value="${fn:trim(widgetContent.fields.groupName)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${mobileVideo}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set var="contentTypes" value="${fn:trim(widgetContent.fields.contentTypes)}"/>
<c:if test="${empty contentTypes}">
  <c:set var="contentTypes" value="youtubeVideo"/>
</c:if>
<c:set target="${mobileVideo}" property="contentTypes" value="${contentTypes}"/>

<c:set target="${mobileVideo}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${mobileVideo}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${mobileVideo}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${mobileVideo}" property="source" value="${fn:trim(widgetContent.fields.source)}"/>
<c:set target="${mobileVideo}" property="maxVideos" value="${fn:trim(widgetContent.fields.maxVideos)}" />
<c:if test="${empty mobileVideo.maxVideos}">
  <c:set target="${mobileVideo}" property="maxVideos" value="5"/>
</c:if>
<c:set target="${mobileVideo}" property="includeSubsections" value="${fn:trim(widgetContent.fields.includeSubsections)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileVideo}" property="wrapperStyleClass">widget mobileVideo ${mobileVideo.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileVideo.customStyleClass}"> ${mobileVideo.customStyleClass}</c:if></c:set>

