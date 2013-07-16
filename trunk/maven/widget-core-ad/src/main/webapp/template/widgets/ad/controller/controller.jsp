<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-ad/src/main/webapp/template/widgets/ad/controller/controller.jsp#1 $
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

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="ad" class="java.util.HashMap" scope="request"/>

<c:set target="${ad}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${ad}" property="styleId" value="${widgetContent.fields.styleId.value}"/>
<c:set target="${ad}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${ad}" property="format" value="${fn:trim(widgetContent.fields.format.value)}"/>
<c:set target="${ad}" property="format_newsletter" value="${fn:trim(widgetContent.fields.format_newsletter.value)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${ad}" property="wrapperStyleClass">widget ad ${ad.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty ad.customStyleClass}"> ${ad.customStyleClass}</c:if></c:set>