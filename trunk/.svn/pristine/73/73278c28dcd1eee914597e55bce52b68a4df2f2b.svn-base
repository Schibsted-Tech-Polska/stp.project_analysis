<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-tickertape/src/main/webapp/template/widgets/tickertape/controller/controller.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- create the map that will contain all relevant field values--%>
<jsp:useBean id="tickertape" class="java.util.HashMap" scope="request"/>

<%--read the field values that affect all views --%>
<c:set target="${tickertape}" property="title" value="${fn:trim(element.fields.title.value)}"/>
<c:set target="${tickertape}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${tickertape}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${tickertape}" property="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>

<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}"/>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news"/>
</c:if>
<c:set target="${tickertape}" property="contentType" value="${contentType}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${tickertape}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${tickertape}" property="view" value="default"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${tickertape}" property="wrapperStyleClass">widget tickertape ${tickertape.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty tickertape.customStyleClass}"> ${tickertape.customStyleClass}</c:if></c:set>