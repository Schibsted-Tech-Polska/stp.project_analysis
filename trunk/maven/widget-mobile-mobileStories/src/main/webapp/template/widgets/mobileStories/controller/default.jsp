<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStories/src/main/webapp/template/widgets/mobileStories/controller/default.jsp#1 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="mobileStories" type="java.util.HashMap" scope="request"/>

<c:set target="${mobileStories}" property="imagePosition" value="${fn:trim(widgetContent.fields.imagePositionDefault.value)}" />
<c:set target="${mobileStories}" property="imageWidth" value="${fn:trim(widgetContent.fields.imageWidthDefault.value)}" />
