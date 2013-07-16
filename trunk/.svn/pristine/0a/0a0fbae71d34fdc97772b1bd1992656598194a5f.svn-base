<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="list" class="java.util.HashMap" scope="request"/>

<c:set target="${list}" property="styleClass" value="list"/>

<%-- read the fields that affect all views--%>
<c:set target="${list}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${list}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${list}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<%-- set style class name if tabbing is enabled--%>
<c:if test="${not empty requestScope.tabbingEnabled and requestScope.tabbingEnabled=='true'}">
  <c:set target="${list}" property="tabbingStyleClass" value="tabbedView"/>
</c:if>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${list}" property="wrapperStyleClass">widget list ${list.view} ${list.tabbingStyleClass} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty list.customStyleClass}"> ${list.customStyleClass}</c:if></c:set>