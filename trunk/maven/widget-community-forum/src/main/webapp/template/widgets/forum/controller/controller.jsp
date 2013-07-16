<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for the forum widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- create the map named 'forum' that will contain relevant field values --%>
<jsp:useBean id="forum" class="java.util.HashMap" scope="request"/>

<%-- required attributes in the requestScope --%>
<jsp:useBean id="widgetContent" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>

<c:set target="${forum}" property="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}" />
<c:if test="${empty forum.sectionUniqueName}">
  <c:set target="${forum}" property="sectionUniqueName" value="${section.uniqueName}" />
</c:if>

<c:set target="${forum}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}"/>
<c:set target="${forum}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${forum}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>

<c:set target="${forum}" property="usernameClickable" value="${widgetContent.fields.usernameClickable.value}"/>
<c:set target="${forum}" property="enablePagination" value="${widgetContent.fields.enablePagination.value}"/>
<c:set target="${forum}" property="pageSize" value="${widgetContent.fields.pageSize.value}"/>
<c:set target="${forum}" property="maxItems" value="${widgetContent.fields.maxItems.value}"/>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${forum}" property="wrapperStyleClass">widget forum ${forum.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty forum.customStyleClass}"> ${forum.customStyleClass}</c:if></c:set>