<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMenu/src/main/webapp/template/widgets/mobileMenu/controller/controller.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%--create a hash map that will contain necessary configurations --%>
<jsp:useBean id="mobileMenu" class="java.util.HashMap" scope="request" />
<jsp:useBean id="mobileSubMenu" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${mobileMenu}" property="styleClass" value="menu"/>
<c:set target="${mobileMenu}" property="subMenuStyleClass" value="submenu"/>
<c:set target="${mobileMenu}" property="activeMenuStyleClass" value="active"/>

<%-- get neccesary parameters from widget fields --%>
<c:set target="${mobileMenu}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${mobileMenu}" property="treeName" value="${fn:trim(widgetContent.fields.menuName)}"/>
<c:set target="${mobileMenu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepth)}"/>
<c:set target="${mobileMenu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItems)}"/>
<c:set target="${mobileMenu}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${mobileMenu}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set target="${mobileSubMenu}" property="subMenuName" value="${fn:trim(widgetContent.fields.subMenuName)}"/>
<c:set target="${mobileSubMenu}" property="moreText">
    <fmt:message key="mobileMenu.widget.moreText.label"/>
</c:set>
<c:set target="${mobileSubMenu}" property="lessText">
    <fmt:message key="mobileMenu.widget.lessText.label"/>
</c:set>

<c:set target="${mobileSubMenu}" property="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName)}"/>
<c:set target="${mobileSubMenu}" property="updateInterval" value="${fn:trim(widgetContent.fields.updateInterval.value)}" />

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileMenu}" property="wrapperStyleClass">widget mobileMenu ${mobileMenu.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileMenu.customStyleClass}"> ${mobileMenu.customStyleClass}</c:if></c:set>
