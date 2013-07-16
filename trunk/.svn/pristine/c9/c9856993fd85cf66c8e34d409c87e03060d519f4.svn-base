<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileWeather/src/main/webapp/template/widgets/mobileWeather/controller/controller.jsp#1 $
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
<jsp:useBean id="mobileWeather" class="java.util.HashMap" scope="request" />

<c:set target="${mobileWeather}" property="title" value="${fn:trim(element.fields.title.value)}" />
<%-- read widget field values --%>
<c:set target="${mobileWeather}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${mobileWeather}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}" />
<c:set target="${mobileWeather}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileWeather}" property="wrapperStyleClass">widget mobileWeather ${mobileWeather.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileWeather.customStyleClass}"> ${mobileWeather.customStyleClass}</c:if></c:set>