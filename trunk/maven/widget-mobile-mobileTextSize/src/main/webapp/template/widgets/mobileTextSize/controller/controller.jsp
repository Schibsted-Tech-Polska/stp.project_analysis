<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileTextSize/src/main/webapp/template/widgets/mobileTextSize/controller/controller.jsp#1 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="mobileTextSize" class="java.util.HashMap" scope="request"/>

<c:set target="${mobileTextSize}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>


<c:set target="${mobileTextSize}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}" />
<c:set target="${mobileTextSize}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileTextSize}" property="wrapperStyleClass">widget mobileTextSize ${mobileTextSize.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileTextSize.customStyleClass}"> ${mobileTextSize.customStyleClass}</c:if></c:set>