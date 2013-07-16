<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-favoritesList/src/main/webapp/template/widgets/favoritesList/controller/helpers/articleAttributes.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>

<%-- the controller has already set a HashMap named 'favoritesList' in the requestScope --%>
<jsp:useBean id="favoritesList" type="java.util.Map" scope="request" />
<%-- this page expects the following HashMap in the requestScope --%>
<jsp:useBean id="attributeMap" type="java.util.HashMap" scope="request"/>

<c:set target="${attributeMap}" property="publishedDate">
  <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${favoritesList.dateFormat}"/>
</c:set>

<c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
<c:set target="${attributeMap}" property="articleUrl" value="${article.url}"/>

<c:choose>
  <c:when test="${article.articleTypeName == 'picture'}">
    <c:set var="pictureTitle" value="${fn:trim(article.fields.title.value)}" />
    <c:set var="pictureCaption" value="${fn:trim(article.fields.caption.value)}" />

    <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
    <c:set target="${attributeMap}" property="leadtext" value="${fn:trim(article.fields.description.value)}" />

    <c:remove var="pictureTitle" scope="page" />
    <c:remove var="pictureCaption" scope="page" />
  </c:when>
  <c:otherwise>
    <c:set target="${attributeMap}" property="title" value="${fn:trim(article.fields.title.value)}" />
    <c:set target="${attributeMap}" property="leadtext" value="${fn:trim(article.fields.leadtext.value)}" />
  </c:otherwise>
</c:choose>

<c:if test="${not empty attributeMap.leadtext}">
  <wf-core:getCurtailedText var="curtailedLeadtext" inputText="${attributeMap.leadtext}"
                              maxLength="${favoritesList.maxCharacters}" ellipsis="..."/>
  <c:set target="${attributeMap}" property="leadtext" value="${requestScope.curtailedLeadtext}"/>
  <c:remove var="curtailedLeadtext" scope="request"/>
</c:if>


<c:if test="${favoritesList.showCommentCount and not empty attributeMap.articleId}">
  <article:use articleId="${attributeMap.articleId}">
    <wf-core:countArticleComments var="numberOfAllComments" articleId="${attributeMap.articleId}"/>
    <c:set var="commentsLinkUrlSuffix" value="${requestScope.numberOfAllComments==0 ? '#commentsForm' : '#commentsList'}"/>
    <c:set target="${attributeMap}" property="commentsLinkUrl" value="${article.url}${commentsLinkUrlSuffix}"/>

    <c:set target="${attributeMap}" property="commentsLinkText">
      <fmt:message key="favoritesList.comment.count">
        <fmt:param value="${requestScope.numberOfAllComments}" />
      </fmt:message>
    </c:set>

    <c:remove var="numberOfAllComments" scope="request"/>
  </article:use>
</c:if>

<c:if test="${favoritesList.showFavoritesCount and not empty attributeMap.articleId}">
  <qual:count id="favoritesCount" articleId="${attributeMap.articleId}"  type="favorite" />
  <c:set target="${attributeMap}" property="favoritesCount" value="${favoritesCount}" />
</c:if>


<c:if test="${favoritesList.showThumb}">
  <c:choose>
    <c:when test="${article.articleTypeName == 'picture'}">
      <jsp:useBean id="teaserImageMap" class="java.util.HashMap" scope="page"/>
      <c:set target="${teaserImageMap}" property="imageArticle" value="${article}"/>
      <c:set target="${teaserImageMap}" property="title" value="${fn:trim(article.fields.title.value)}"/>
      <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(article.fields.caption.value)}"/>
      <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(article.fields.alttext.value)}"/>
      <c:set target="${attributeMap}" property="teaserImageMap" value="${teaserImageMap}"/>
      <c:remove var="teaserImageMap" scope="page"/>
    </c:when>
    <c:otherwise>
      <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${article.id}" />
      <c:set target="${attributeMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
      <c:remove var="teaserImageMap" scope="request"/>
    </c:otherwise>
  </c:choose>
</c:if>