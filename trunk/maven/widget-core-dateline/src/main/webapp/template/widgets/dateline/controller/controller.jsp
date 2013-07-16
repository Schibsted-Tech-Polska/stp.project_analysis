<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the general controller of the Dateline widget. --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="dateline" class="java.util.HashMap" scope="request" />

<c:set target="${dateline}" property="styleClass" value="dateline"/>
<c:set target="${dateline}" property="view" value="${fn:trim(widgetContent.fields.view)}" />
<c:set target="${dateline}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${dateline}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${dateline}" property="wrapperStyleClass">widget dateline ${dateline.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty dateline.customStyleClass}"> ${dateline.customStyleClass}</c:if></c:set>