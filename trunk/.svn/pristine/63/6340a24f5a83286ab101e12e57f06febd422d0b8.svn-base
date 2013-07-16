<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-logo/src/main/webapp/template/widgets/logo/controller/default.jsp#1 $
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

<jsp:useBean id="logo" type="java.util.HashMap" scope="request"/>

<c:set property="url" target="${logo}" value="${publication.url}"/>

<c:choose>
  <c:when test="${not empty widgetContent.relatedElements.logo.items}">
    <c:set property="renderImage" target="${logo}" value="true"/>
    <c:set property="logoPicture" target="${logo}" value="${widgetContent.relatedElements.logo.items[0]}"/>
    <%--todo: add field to widget for link title--%>
    <c:set property="aTitle" target="${logo}" value="${logo.logoPicture.content.fields.alttext.value}"/>
  </c:when>
  <c:otherwise>
    <c:set property="renderImage" target="${logo}" value="false"/>
    <c:set property="aTitle" target="${logo}" value="${publication.name}"/>
    <c:set property="aText" target="${logo}" value="${publication.name}"/>
  </c:otherwise>
</c:choose>



