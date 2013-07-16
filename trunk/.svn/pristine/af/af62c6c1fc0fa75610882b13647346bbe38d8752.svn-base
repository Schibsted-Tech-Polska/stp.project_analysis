<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-weather/src/main/webapp/template/widgets/weather/controller/controller.jsp#1 $
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
<jsp:useBean id="weather" class="java.util.HashMap" scope="request" />

<c:set target="${weather}" property="title" value="${fn:trim(element.fields.title.value)}" />
<%-- read widget field values --%>
<c:set target="${weather}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${weather}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}" />
<c:set target="${weather}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${weather}" property="wrapperStyleClass">widget weather ${weather.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty weather.customStyleClass}"> ${weather.customStyleClass}</c:if></c:set>