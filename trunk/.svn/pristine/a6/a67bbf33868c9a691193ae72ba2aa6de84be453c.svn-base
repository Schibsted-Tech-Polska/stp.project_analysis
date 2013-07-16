<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-logo/src/main/webapp/template/widgets/logo/view/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
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

<jsp:useBean id="logo" type="java.util.HashMap" scope="request"/>

<div class="${logo.wrapperStyleClass}" <c:if test="${not empty logo.styleId}">id="${logo.styleId}"</c:if>>
  <h1>
    <a href="${logo.url}" title="${logo.aTitle}">
      <c:choose>
        <c:when test="${logo.renderImage eq 'true'}">
          <img src="${logo.logoPicture.content.fields.binary.value.original}"
               alt="${logo.logoPicture.content.fields.alttext.value}"
               title="${logo.logoPicture.content.fields.caption.value}"/>
        </c:when>
        <c:otherwise>
          <span><c:out value="${logo.aText}" escapeXml="true"/> </span>
        </c:otherwise>
      </c:choose>
    </a>
  </h1>
</div>

