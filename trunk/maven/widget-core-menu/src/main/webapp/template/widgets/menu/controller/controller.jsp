<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%--create a hash map that will contain necessary configurations --%>
<jsp:useBean id="menu" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${menu}" property="styleClass" value="menu"/>
<c:set target="${menu}" property="subMenuStyleClass" value="submenu"/>
<c:set target="${menu}" property="activeMenuStyleClass" value="active"/>

<%-- get neccesary parameters from widget fields --%>
<c:set target="${menu}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${menu}" property="treeName" value="${fn:trim(widgetContent.fields.menuName)}"/>
<c:set target="${menu}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${menu}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${menu}" property="menuTitle" value="${fn:trim(widgetContent.fields.menuTitle)}"/>
<c:set target="${menu}" property="updateInterval" value="${fn:trim(widgetContent.fields.updateInterval.value)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${menu}" property="wrapperStyleClass">widget menu ${menu.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty menu.customStyleClass}"> ${menu.customStyleClass}</c:if></c:set>