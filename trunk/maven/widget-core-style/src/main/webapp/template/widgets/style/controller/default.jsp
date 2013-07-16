<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-style/src/main/webapp/template/widgets/style/controller/default.jsp#1 $
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

<c:choose>
  <c:when test="${not empty fn:trim(widgetContent.fields.customSkinName.value)}">
    <c:set var="skinName" value="${fn:trim(widgetContent.fields.customSkinName.value)}" scope="request"/>
  </c:when>
  <c:otherwise>
    <c:set var="skinName" value="${fn:trim(widgetContent.fields.skinName.value)}" scope="request"/>
  </c:otherwise>
</c:choose>
<c:set var="skinUrl" value="${publication.url}skins/${skinName}/" scope="request"/>
<c:choose>
  <c:when test="${not empty requestScope.inlineStyle}">
    <c:set var="inlineStyle" value="${requestScope.inlineStyle} ${widgetContent.fields.inlineStyle.value}" scope="request"/>
  </c:when>
  <c:otherwise>
    <c:set var="inlineStyle" value="${widgetContent.fields.inlineStyle.value}" scope="request"/>
  </c:otherwise>
</c:choose>


