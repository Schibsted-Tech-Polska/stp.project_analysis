<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileBookmark/src/main/webapp/template/widgets/mobileBookmark/view/default.jsp#1 $
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
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<jsp:useBean id="mobileBookmark" type="java.util.HashMap" scope="request"/>

<c:set var="iPhoneUrl" value=""/>
<c:set var="iPadUrl" value=""/>

<c:if test="${mobileBookmark.hasCustomIphone}">
  <c:set var="iPhoneUrl" value="${mobileBookmark.iPhoneImage.content.fields.binary.value.original}"/>
</c:if>

<c:if test="${mobileBookmark.hasCustomIpad}">
  <c:set var="iPadUrl" value="${mobileBookmark.iPadImage.content.fields.binary.value.original}"/>
</c:if>

<dxw:iphonebookmark cookieLife="${mobileBookmark.cookieLife}" imgUrl="${iPhoneUrl}"/>
