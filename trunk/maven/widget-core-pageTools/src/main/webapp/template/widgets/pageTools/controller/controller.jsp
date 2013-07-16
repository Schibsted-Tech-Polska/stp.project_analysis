<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/controller/controller.jsp#1 $
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- create the map that will contain relevant field values --%>
<jsp:useBean id="pageTools" class="java.util.HashMap" scope="request"/>

<%-- access the fields that affect all views--%>
<c:set target="${pageTools}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${pageTools}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set target="${pageTools}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${pageTools}" property="controller" value="default"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${pageTools}" property="wrapperStyleClass">widget pageTools ${pageTools.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty pageTools.customStyleClass}"> ${pageTools.customStyleClass}</c:if></c:set>

