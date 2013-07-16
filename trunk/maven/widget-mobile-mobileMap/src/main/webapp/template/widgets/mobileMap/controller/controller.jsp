<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMap/src/main/webapp/template/widgets/mobileMap/controller/controller.jsp#1 $
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

<jsp:useBean id="mobileMap" class="java.util.HashMap" scope="request"/>

<c:set target="${mobileMap}" property="title" value="${fn:trim(element.fields.title.value)}"/>
<c:set target="${mobileMap}" property="view" value="default"/>
<c:set target="${mobileMap}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${mobileMap}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}"/>
<c:set target="${mobileMap}" property="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>
<c:set target="${mobileMap}" property="source" value="${widgetContent.fields.source.value}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${mobileMap}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${mobileMap}" property="showNavigationLinks" value="${fn:trim(widgetContent.fields.showNavigationLinks.value)}"/>
<c:set target="${mobileMap}" property="showZoomLinks" value="${fn:trim(widgetContent.fields.showZoomLinks.value)}"/>
<c:set target="${mobileMap}" property="showMapTypeSwitcher" value="${fn:trim(widgetContent.fields.showMapTypeSwitcher.value)}"/>
<c:set target="${mobileMap}" property="zoomLevel" value="${fn:trim(widgetContent.fields.zoomLevel.value)}"/>
<c:set target="${mobileMap}" property="iconSize" value="${fn:trim(widgetContent.fields.iconSize.value)}"/>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileMap}" property="wrapperStyleClass">widget mobileMap ${mobileMap.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileMap.customStyleClass}"> ${mobileMap.customStyleClass}</c:if></c:set>