<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobilePopularList/src/main/webapp/template/widgets/mobilePopularList/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This is the general controller of popularList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create the HashMap that will contain relevant field values --%>
<jsp:useBean id="mobilePopularList" class="java.util.HashMap" scope="request"/>

<c:set target="${mobilePopularList}" property="view" value="${fn:trim(widgetContent.fields.view.value)}" />
<c:set target="${mobilePopularList}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}" />
<c:set target="${mobilePopularList}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobilePopularList}" property="wrapperStyleClass">widget mobilePopularList ${mobilePopularList.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobilePopularList.customStyleClass}"> ${mobilePopularList.customStyleClass}</c:if></c:set>