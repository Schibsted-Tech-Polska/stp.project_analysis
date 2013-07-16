<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/controller/custom.jsp#1 $
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty param.pageToolsFontSize}">
  <c:remove var="pageToolsFontSize" scope="session" />
  <c:set var="pageToolsFontSize" value="${param.pageToolsFontSize}" scope="session" />
</c:if>

<jsp:useBean id="pageTools" class="java.util.HashMap" scope="request" />

<c:set var="smallFontSize" scope="page">
  <c:out value="${fn:trim(widgetContent.fields.smallFontSize)}" default="70%"/>
</c:set>
<c:set target="${pageTools}" property="smallFontSize" value="${smallFontSize}" />
<c:remove var="smallFontSize" scope="page"/>

<c:set var="mediumFontSize" scope="page">
  <c:out value="${fn:trim(widgetContent.fields.mediumFontSize)}" default="100%"/>
</c:set>
<c:set target="${pageTools}" property="mediumFontSize" value="${mediumFontSize}" />
<c:remove var="mediumFontSize" scope="page"/>

<c:set var="largeFontSize" scope="page">
  <c:out value="${fn:trim(widgetContent.fields.largeFontSize)}" default="130%"/>
</c:set>
<c:set target="${pageTools}" property="largeFontSize" value="${largeFontSize}" />
<c:remove var="largeFontSize" scope="page"/>

