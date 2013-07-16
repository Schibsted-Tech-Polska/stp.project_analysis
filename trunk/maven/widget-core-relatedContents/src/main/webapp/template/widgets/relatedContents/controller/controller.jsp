<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a hashmap that will contain relevant field values --%>
<jsp:useBean id="relatedContents" class="java.util.HashMap" scope="request" />

<%-- get necessary parameters from element's content article fields --%>
<c:set var="view" value="${fn:trim(widgetContent.fields.view)}" />
<c:set var="headline" value="${fn:trim(element.fields.title.value)}"/>

<c:set var="beginIndex" value="${fn:trim(widgetContent.fields.begin)}" />
<c:if test="${not empty beginIndex and beginIndex > 0}">
  <c:set var="beginIndex" value="${beginIndex-1}" />
</c:if>
<c:set var="beginIndex" value="${fn:trim(beginIndex)}" />

<c:set var="endIndex" value="${fn:trim(widgetContent.fields.end)}" />
<c:if test="${not empty endIndex and endIndex > 0}">
  <c:set var="endIndex" value="${endIndex-1}" />
</c:if>
<c:set var="endIndex" value="${fn:trim(endIndex)}" />

<c:set var="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set var="showHeadline" value="${fn:trim(widgetContent.fields.showHeadline)}" />

<c:set target="${relatedContents}" property="view" value="${view}"/>
<c:set target="${relatedContents}" property="headline" value="${headline}"/>
<c:set target="${relatedContents}" property="showHeadline" value="${showHeadline}"/>
<c:set target="${relatedContents}" property="beginIndex" value="${beginIndex}"/>
<c:set target="${relatedContents}" property="endIndex" value="${endIndex}"/>
<c:set target="${relatedContents}" property="styleId" value="${styleId}"/>
<c:set target="${relatedContents}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${relatedContents}" property="wrapperStyleClass">widget relatedContents ${relatedContents.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>