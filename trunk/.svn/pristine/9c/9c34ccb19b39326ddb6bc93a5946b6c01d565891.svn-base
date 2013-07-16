<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/countArticleComments.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="article" required="false" type="neo.xredsys.presentation.PresentationArticle" %>
<%@ attribute name="articleId" required="false" %>
<%@ attribute name="topLevelOnly" required="false" type="java.lang.Boolean" %>
<%--
  The purpose of this tag is to calculate the number of comments of an article.

  If article / articleId is given, then this tag calculates the number of comments for the given article.
  Else, this tag tries to find an 'article' object in the requestScope and calculates the number of comments for that article.

  If topLevelOnly = true, then this tag only calculates the number of top level comments.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<c:set var="eTopLevelOnly" value="${false}" />
<c:if test="${topLevelOnly==true}">
  <c:set var="eTopLevelOnly" value="${true}" />
</c:if>

<c:choose>
  <c:when test="${not empty article}">
    <c:set var="eArticleId" value="${article.articleId}" />
  </c:when>
  <c:when test="${not empty articleId}">
    <c:set var="eArticleId" value="${articleId}" />
  </c:when>
  <c:when test="${not empty requestScope['article']}">
    <c:set var="eArticleId" value="${requestScope['article'].articleId}" />    
  </c:when>
</c:choose>

<c:set var="numberOfComments" value="0"/>

<article:use articleId="${eArticleId}">
  <article:hasRelation includeArticleTypes="posting">
    <relation:articles id="relatedThread" includeArticleTypes="posting">
      <forum:thread id="thread" threadId="${relatedThread.id}"/>
      <c:choose>
        <c:when test="${eTopLevelOnly}">
          <c:set var="numberOfComments" value="${numberOfComments + thread.root.repliesCount}"/>    
        </c:when>
        <c:otherwise>
          <c:set var="numberOfComments" value="${numberOfComments + thread.postingCount - 1}"/>
        </c:otherwise>
      </c:choose>
    </relation:articles>
  </article:hasRelation>
</article:use>

<%
  request.setAttribute(var, jspContext.getAttribute("numberOfComments"));
%>