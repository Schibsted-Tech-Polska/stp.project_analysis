<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/avatarPicture.jsp#1 $
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
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<%-- this page expects the current posting in the requestScope --%>
<c:set var="tempPosting" value="${requestScope.posting}" />

<c:set var="authorId" value="${tempPosting.authors[0].id}" />
<c:if test="${not empty authorId}">
  <community:user id="communityUser" userId="${authorId}" />
</c:if>

<c:set var="avatarImageVersion" value="${forum.avatarImageVersion}" />
<c:choose>
  <c:when test="${empty communityUser}">
    <c:set var="avatureImageUrl" value="${skinUrl}gfx/forum/default-avatar.jpg" />
    <c:set var="avatureImageLink" value="mailto:${tempPosting.senderEmail}" />
    <c:set var="avatureImageTitle" value="${tempPosting.authors[0].name}" />
  </c:when>
  <c:when test="${not empty communityUser.article.relatedElements.profilePictures.items and
                  communityUser.article.relatedElements.profilePictures.items[0].content.articleTypeName == 'avatar'}">
    <c:set var="avatureImageUrl" value="${communityUser.article.relatedElements.profilePictures.items[0].content.fields.alternates.value[avatarImageVersion].href}" />
    <c:set var="avatureImageLink" value="${communityUser.section.url}" />
    <c:set var="avatureImageTitle" value="${communityUser.article.fields.firstname} ${communityUser.article.fields.surname}" />
  </c:when>
  <c:otherwise>
    <c:set var="avatureImageUrl" value="${skinUrl}gfx/forum/default-avatar.jpg" />
    <c:set var="avatureImageLink" value="${communityUser.section.url}" />
    <c:set var="avatureImageTitle" value="${communityUser.article.fields.firstname} ${communityUser.article.fields.surname}" />
  </c:otherwise>
</c:choose>

<div class="avatar">
  <a href="${avatureImageLink}">
    <img src="${avatureImageUrl}"
         alt="${avatureImageTitle}" title="${avatureImageTitle}"
         width="${forum.avatarSize}" height="${forum.avatarSize}" />
  </a>
</div>