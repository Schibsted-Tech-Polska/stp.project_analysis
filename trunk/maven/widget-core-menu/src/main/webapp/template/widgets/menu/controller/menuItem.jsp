<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/menuItem.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<c:set target="${menu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepthMenuItem)}"/>
<c:set target="${menu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItemsMenuItem)}"/>

<c:set target="${menu}" property="reference" value="${fn:trim(widgetContent.fields.reference.value)}"/>

<c:set target="${menu}" property="linkText" value="${fn:trim(widgetContent.fields.linkText.value)}"/>
<c:if test="${empty fn:trim(menu.linkText) and menu.reference == 'sectionUniqueName'}">
  <c:set target="${menu}" property="linkText" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
</c:if>

<c:choose>
  <c:when test="${menu.reference == 'sectionUniqueName'}">
    <c:set target="${menu}" property="sectionUniqueName"
           value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
    <section:use uniqueName="${menu.sectionUniqueName}">
      <c:set target="${menu}" property="linkUrl" value="${section.url}"/>
    </section:use>
  </c:when>
  <c:when test="${menu.reference == 'url'}">
    <c:set target="${menu}" property="linkUrl" value="${fn:trim(widgetContent.fields.url.value)}"/>
  </c:when>
  <c:when test="${menu.reference == 'articleId'}">
    <c:set target="${menu}" property="articleId" value="${fn:trim(widgetContent.fields.articleId.value)}"/>
    <article:use articleId="${menu.articleId}">
      <c:set target="${menu}" property="linkUrl" value="${article.url}"/>
    </article:use>
  </c:when>
</c:choose>
