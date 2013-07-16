<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-favoritesList/src/main/webapp/template/widgets/favoritesList/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for favoritesList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="favoritesList" class="java.util.HashMap" scope="request"/>

<%--<c:set target="${favoritesList}" property="styleClass" value="favoritesList"/>--%>

<%-- read the fields that affect all views--%>
<c:set target="${favoritesList}" property="title" value="${fn:trim(element.fields.title.value)}"/>
<c:set target="${favoritesList}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${favoritesList}" property="type" value="${fn:trim(widgetContent.fields.type.value)}"/>

<c:set target="${favoritesList}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${favoritesList}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<%-- set style class name if tabbing is enabled--%>
<c:if test="${not empty requestScope.tabbingEnabled and requestScope.tabbingEnabled=='true'}">
  <c:set target="${favoritesList}" property="tabbingStyleClass" value="tabbedView"/>
  <%--<c:set target="${favoritesList}" property="styleClass" value="${favoritesList.styleClass} ${favoritesList.tabbingStyleClass}"/>--%>
</c:if>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${favoritesList}" property="wrapperStyleClass">widget favoritesList ${favoritesList.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty favoritesList.tabbingStyleClass}"> ${favoritesList.tabbingStyleClass}</c:if><c:if test="${not empty favoritesList.customStyleClass}"> ${favoritesList.customStyleClass}</c:if></c:set>