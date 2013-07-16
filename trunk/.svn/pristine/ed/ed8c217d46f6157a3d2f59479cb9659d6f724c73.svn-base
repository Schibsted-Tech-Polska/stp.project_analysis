<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-master/src/main/webapp/template/widgets/master/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for the master widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- create the map named 'master' that will contain relevant field values --%>
<jsp:useBean id="master" class="java.util.HashMap" scope="request"/>

<c:set target="${master}" property="masterSectionUniqueName" value="${fn:trim(widgetContent.fields.masterUniqueName.value)}" />
<c:set target="${master}" property="showWrapperDiv" value="${fn:trim(widgetContent.fields.showDiv.value)}"/>
<c:set target="${master}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}"/>
<c:set target="${master}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${master}" property="view" value="default"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${master}" property="wrapperStyleClass">widget master ${master.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty master.customStyleClass}"> ${master.customStyleClass}</c:if></c:set>