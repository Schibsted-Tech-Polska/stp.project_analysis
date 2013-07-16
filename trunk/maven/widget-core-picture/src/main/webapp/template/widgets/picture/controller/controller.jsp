<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- This is the general controller of Picture widget--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="picture" class="java.util.HashMap" scope="request" />

<%-- retrieve necessary parameters --%>
<c:set target="${picture}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${picture}" property="softCrop" value="${fn:trim(widgetContent.fields.softCrop)}"/>
<c:set var="imageVersion" value="${fn:trim(widgetContent.fields.imageVersion)}"/>
<c:choose>
  <c:when test="${empty imageVersion}">
    <c:set var="areaWidth" value="${requestScope.elementwidth > 940 ? '940' : requestScope.elementwidth}" />
    <c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}" />
    <c:set target="${picture}" property="imageVersion" value="w${areaWidth}" />
    <c:set target="${picture}" property="areaWidth" value="${areaWidth}" />
  </c:when>
  <c:otherwise>
    <c:set var="areaWidth" value="${fn:substringAfter(imageVersion, 'w')}" />
    <c:set target="${picture}" property="imageVersion" value="${imageVersion}"/>
    <c:set target="${picture}" property="areaWidth" value="${areaWidth}" />
  </c:otherwise>
</c:choose>

<c:set target="${picture}" property="contentType" value="${fn:trim(widgetContent.fields.contentType)}"/>


<c:set target="${picture}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${picture}" property="animation" value="${fn:trim(widgetContent.fields.animation.value)}"/>
<c:set target="${picture}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${picture}" property="wrapperStyleClass">widget picture ${picture.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty picture.customStyleClass}"> ${picture.customStyleClass}</c:if></c:set>