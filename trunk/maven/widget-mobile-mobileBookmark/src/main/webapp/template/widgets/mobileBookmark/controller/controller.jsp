<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileBookmark/src/main/webapp/template/widgets/mobileBookmark/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%--JSLT related important tags--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- create the map that will contain relevant field values --%>
<jsp:useBean id="mobileBookmark" class="java.util.HashMap" scope="request"/>
<%--Custom views can be added but may not be required--%>

<c:set target="${mobileBookmark}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${mobileBookmark}" property="cookieLife" value="${fn:trim(widgetContent.fields.cookieLife.value)}"/>