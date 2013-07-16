<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/controller/controller.jsp#1 $
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

<%-- create the map that will contain relevant field values --%>
<jsp:useBean id="storyContent" class="java.util.HashMap" scope="request"/>

<c:set target="${storyContent}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${storyContent}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormat.value)}"/>
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMMM dd yyyy hh:mm"/>
</c:if>

<c:set target="${storyContent}" property="dateFormat" value="${dateFormat}"/>
<c:set target="${storyContent}" property="view" value="${fn:trim(widgetContent.fields.view)}" />

<c:set var="useFontSelector" value="${fn:trim(widgetContent.fields.useFontSelector.value)}" scope="page" />

<c:if test="${not empty useFontSelector and useFontSelector eq 'true'}">
  <c:set var="useFontSelectorPageTools" scope="session" value="storyContent" />
</c:if>

<c:remove var="useFontSelector" scope="page" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${storyContent}" property="wrapperStyleClass">widget storyContent ${storyContent.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty storyContent.customStyleClass}"> ${storyContent.customStyleClass}</c:if></c:set>