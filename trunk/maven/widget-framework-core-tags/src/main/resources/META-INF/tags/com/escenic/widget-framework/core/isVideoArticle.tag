<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/renderFormFields.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
 This tag checks if the article is a video type article
--%>

<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articleSummary" type="neo.xredsys.presentation.PresentationElement" required="false" rtexprvalue="true" %>
<%@ attribute name="articleContent" type="neo.xredsys.presentation.PresentationArticle" required="false" rtexprvalue="true" %>
<%@ attribute name="articleId" required="false" rtexprvalue="true" %>

<c:choose>
  <c:when test="${not empty articleSummary}">
    <c:set var="articleTypeName" value="${articleSummary.content.articleTypeName}"/>
  </c:when>
  <c:when test="${not empty articleContent}">
    <c:set var="articleTypeName" value="${articleContent.articleTypeName}"/>
  </c:when>
  <c:when test="${not empty articleId}">
    <article:use articleId="${articleId}">
      <c:set var="articleTypeName" value="${article.articleTypeName}"/>
    </article:use>
  </c:when>
</c:choose>

<c:set var="isVideo" value="false"/>
<c:if test="${articleTypeName == 'simpleVideo' or articleTypeName == 'youtubeVideo' or articleTypeName=='videoHubVideo'}">
  <c:set var="isVideo" value="true"/>
</c:if>

<%
  request.setAttribute(var, jspContext.getAttribute("isVideo"));
%>