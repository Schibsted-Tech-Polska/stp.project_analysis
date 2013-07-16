<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/controller/controller.jsp#1 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="stories" class="java.util.HashMap" scope="request"/>

<c:set target="${stories}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${stories}" property="linkBehaviour" value="${fn:trim(widgetContent.fields.linkBehaviour)}"/>
<c:set target="${stories}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${stories}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${stories}" property="listSort" value="${fn:trim(widgetContent.fields.listSort.value)}"/>

<c:set target="${stories}" property="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${stories}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${stories}" property="includeSubSections" value="${fn:trim(widgetContent.fields.includeSubsections.value)}"/>
<c:set target="${stories}" property="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>

<section:use uniqueName="${stories.sectionUniqueName}">
  <c:set target="${stories}" property="sectionId" value="${section.id}"/>
  <c:set target="${stories}" property="sectionName" value="${section.name}"/>
</section:use>

<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersion.value)}"/>

<c:choose>
  <c:when test="${empty imageVersion}">
    <c:set var="imageWidth" value="${requestScope.elementwidth}"/>
  </c:when>
  <c:otherwise>
    <c:set var="imageWidth" value="${fn:substring(imageVersion, 1,fn:length(imageVersion))}"/>
  </c:otherwise>
</c:choose>

<wf-core:getImageRepresentation var="correctImageVersion" prefferedWidth="${imageWidth}"/>

<%--<c:if test="${empty imageVersion}">--%>
  <%--<c:set var="areaWidth" value="${requestScope.elementwidth > 940 ? '940' : requestScope.elementwidth}" />--%>
  <%--<c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}"/>--%>
  <%--<c:set var="imageVersion" value="w${areaWidth}"/>--%>
<%--</c:if>--%>
<c:set target="${stories}" property="imageVersion" value="${correctImageVersion}"/>
<c:remove var="correctImageVersion" scope="request"/>

<c:set target="${stories}" property="softCrop" value="${fn:trim(widgetContent.fields.softCrop)}"/>
<c:set target="${stories}" property="showCaption" value="default"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${stories}" property="wrapperStyleClass">widget stories ${stories.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty stories.customStyleClass}"> ${stories.customStyleClass}</c:if></c:set>