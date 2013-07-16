<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  This page is the entry point for trailer widget functionality. It stores the necessary values in request scope and
  then transfers control to another JSP responsible for generating the view.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- create the map that will contain relevant field values / collections--%>
<jsp:useBean id="trailers" class="java.util.HashMap" scope="request"/>

<!--read the fields that affect all views-->
<c:set target="${trailers}" property="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>
<c:set target="${trailers}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${trailers}" property="styleId" value="${widgetContent.fields.styleId.value}"/>
<c:set target="${trailers}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${trailers}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}"/>
<%-- we could keep this until VF-927 is delivered --%>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news"/>
</c:if>

<c:set target="${trailers}" property="contentType" value="${contentType}"/>
<c:set target="${trailers}" property="imageVersion" value="${fn:trim(widgetContent.fields.imageVersion.value)}"/>
<c:set target="${trailers}" property="softCrop" value="${widgetContent.fields.softCrop.value}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${trailers}" property="wrapperStyleClass">widget trailers ${trailers.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty trailers.customStyleClass}"> ${trailers.customStyleClass}</c:if></c:set>