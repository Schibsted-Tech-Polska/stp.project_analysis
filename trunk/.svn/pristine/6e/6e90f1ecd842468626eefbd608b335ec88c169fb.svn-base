<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-poll/src/main/webapp/template/widgets/poll/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for poll widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%--create a hashmap named 'poll' that will contain relevant field values --%>
<jsp:useBean id="poll" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${poll}" property="styleClass" value="poll"/>

<%-- retrieve necessary parameters --%>
<c:set target="${poll}" property="groupName" value="${fn:trim(widgetContent.fields.groupName)}"/>

<c:set target="${poll}" property="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName)}"/>
<c:if test="${empty poll.sectionUniqueName}">
  <c:set target="${poll}" property="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>

<c:set target="${poll}" property="contentType" value="${fn:trim(widgetContent.fields.contentType)}"/>
<c:if test="${empty poll.contentType}">
  <c:set target="${poll}" property="contentType" value="poll"/>
</c:if>

<c:set target="${poll}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${poll}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set target="${poll}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${poll}" property="wrapperStyleClass">widget poll ${poll.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty poll.customStyleClass}"> ${poll.customStyleClass}</c:if></c:set>