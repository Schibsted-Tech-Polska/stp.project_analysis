<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-favoritesList/src/main/webapp/template/widgets/favoritesList/controller/simple.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the simple view of favoritesList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>

<%-- the general controller has already set a HashMap named 'favoritesList' in the requestScope --%>
<jsp:useBean id="favoritesList" type="java.util.Map" scope="request"/>

<c:set target="${favoritesList}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountSimple.value)}"/>
<c:set target="${favoritesList}" property="showFavoritesCount" value="${widgetContent.fields.showFavouritesCountSimple.value}"/>

<c:set var="favoriteArticlesPagerSource" value="" />
<c:choose>
  <c:when test="${favoritesList.type == 'userFavorites'}">
    <%-- first try to load community user from the current section if we are in user home section--%>
    <community:user id="communityUser" sectionId="${section.id}"/>
    <%-- if we are NOT in user home section, then try to load currently logged in community user --%>
    <c:if test="${empty communityUser}">
      <profile:present>
        <section:use uniqueName="${user.userName}">
          <community:user id="tempCommunityUser" sectionId="${section.id}"/>
	        <c:set var="communityUser" value="${tempCommunityUser}" scope="request"/>
          <c:remove var="tempCommunityUser" scope="request"/>
        </section:use>
      </profile:present>
    </c:if>

    <c:if test="${not empty communityUser}">
      <qual:count id ="userFavoritesCount" name="communityUser" type="favorite" />

      <qual:favoritePagerSource id="userFavoritesPagerSource"
                                name="communityUser"
                                max="${favoritesList.itemCount}"
                                pageSize="${favoritesList.itemCount}"
                                maxActionItems="${favoritesList.itemCount}"/>

      <c:set var="favoriteArticlesPagerSource" value="${userFavoritesPagerSource}" />
    </c:if>
  </c:when>
  <c:when test="${favoritesList.type == 'mostFavorites'}">
    <qual:mostFavoritePagerSource id="mostFavoritesPagerSource"
                                  max="${favoritesList.itemCount}"
                                  pageSize="${favoritesList.itemCount}"
                                  maxActionItems="${favoritesList.itemCount}"/>

    <c:set var="favoriteArticlesPagerSource" value="${mostFavoritesPagerSource}" />
  </c:when>
</c:choose>

<collection:createList id="attributeMapList" type="java.util.ArrayList"/>

<c:if test="${not empty favoriteArticlesPagerSource and not empty favoriteArticlesPagerSource.pageItems}">
  <c:forEach var="favoriteArticle" items="${favoriteArticlesPagerSource.pageItems}">

    <article:use articleId="${favoriteArticle.articleId}">
      <jsp:useBean id="attributeMap" class="java.util.HashMap"/>

      <c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
      <c:set target="${attributeMap}" property="articleUrl" value="${article.url}"/>

      <c:choose>
        <c:when test="${article.articleTypeName == 'picture'}">
          <c:set var="pictureTitle" value="${fn:trim(article.fields.title.value)}" />
          <c:set var="pictureCaption" value="${fn:trim(article.fields.caption.value)}" />
          <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
          <c:remove var="pictureTitle" scope="page" />
          <c:remove var="pictureCaption" scope="page" />
        </c:when>
        <c:otherwise>
          <c:set target="${attributeMap}" property="title" value="${fn:trim(article.fields.title.value)}" />
        </c:otherwise>
      </c:choose>

      <c:if test="${favoritesList.showFavoritesCount}">
        <qual:count id="favoritesCount" articleId="${article.id}"  type="favorite" />
        <c:set target="${attributeMap}" property="favoritesCount" value="${favoritesCount}" />
      </c:if>

      <collection:add collection="${attributeMapList}" value="${attributeMap}"/>
      <c:remove var="attributeMap" scope="page"/>
    </article:use>
  </c:forEach>
</c:if>

<c:set target="${favoritesList}" property="items" value="${attributeMapList}"/>