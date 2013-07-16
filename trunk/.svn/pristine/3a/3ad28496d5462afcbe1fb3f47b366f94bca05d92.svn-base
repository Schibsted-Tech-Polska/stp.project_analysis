<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-logo/src/main/webapp/template/widgets/logo/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%--JSLT related important tags--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- create the map that will contain relevant field values --%>
<jsp:useBean id="logo" class="java.util.HashMap" scope="request"/>
<%--Custom views can be added but may not be required--%>
<c:set target="${logo}" property="view">
  <c:out value="${fn:trim(widgetContent.fields.view)}" default="default"/>
</c:set>

<c:set target="${logo}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${logo}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${logo}" property="wrapperStyleClass">widget logo ${logo.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty logo.customStyleClass}"> ${logo.customStyleClass}</c:if></c:set>
