<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/controller/controller.jsp#1 $
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

<%--create the map that will contain the necessary field values/collections --%>
<jsp:useBean id="feed" class="java.util.HashMap" scope="request"/>

<%--read the fields that affect all views --%>
<c:set target="${feed}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${feed}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${feed}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${feed}" property="wrapperStyleClass">widget feed ${feed.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty feed.customStyleClass}"> ${feed.customStyleClass}</c:if></c:set>