<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileBookmark/src/main/webapp/template/widgets/mobileBookmark/controller/default.jsp#1 $
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="mobileBookmark" type="java.util.HashMap" scope="request"/>

<c:set property="hasCustomIphone" target="${mobileBookmark}" value="false"/>
<c:set property="hasCustomIpad" target="${mobileBookmark}" value="false"/>

<c:if test="${not empty widgetContent.relatedElements.iPhoneBookmark.items}">
  <c:set property="iPhoneImage" target="${mobileBookmark}"
         value="${widgetContent.relatedElements.iPhoneBookmark.items[0]}"/>
  <c:set property="hasCustomIphone" target="${mobileBookmark}" value="true"/>
</c:if>

<c:if test="${not empty widgetContent.relatedElements.iPadBookmark.items}">
  <c:set property="iPadImage" target="${mobileBookmark}"
         value="${widgetContent.relatedElements.iPadBookmark.items[0]}"/>
  <c:set property="hasCustomIpad" target="${mobileBookmark}" value="true"/>
</c:if>