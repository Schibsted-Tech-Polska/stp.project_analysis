<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-favoritesList/src/main/webapp/template/widgets/favoritesList/controller/detailed.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the detailed view of favoritesList widget --%>
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

<c:set target="${favoritesList}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountDetailed.value)}"/>
<c:set target="${favoritesList}" property="showThumb" value="${widgetContent.fields.showThumbDetailed.value}"/>
<c:set target="${favoritesList}" property="showIntro" value="${widgetContent.fields.showIntroDetailed.value}"/>
<c:set target="${favoritesList}" property="showCommentCount" value="${widgetContent.fields.showCommentCountDetailed.value}"/>
<c:set target="${favoritesList}" property="showDate" value="${widgetContent.fields.showDateDetailed.value}"/>
<c:set target="${favoritesList}" property="showFavoritesCount" value="${widgetContent.fields.showFavouritesCountDetailed.value}"/>
<c:set target="${favoritesList}" property="maxCharacters" value="${fn:trim(widgetContent.fields.maxCharactersDetailed.value)}"/>

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormatDetailed.value)}"/>
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMMM dd yyyy hh:mm"/>
</c:if>
<c:set target="${favoritesList}" property="dateFormat" value="${dateFormat}"/>

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
  <c:forEach var="favoriteArticle" items="${favoriteArticlesPagerSource.pageItems}" varStatus="loopStatus">
    <c:set var="articleStyleClass" value="${loopStatus.first ? 'first' : ''}" />

    <article:use articleId="${favoriteArticle.articleId}">
      <jsp:useBean id="attributeMap" class="java.util.HashMap" scope="request"/>
      <c:set target="${attributeMap}" property="articleClass" value="${articleStyleClass}"/>

      <jsp:include page="helpers/articleAttributes.jsp"/>

      <collection:add collection="${attributeMapList}" value="${attributeMap}"/>

      <c:remove var="attributeMap" scope="request"/>
    </article:use>
  </c:forEach>
</c:if>

<c:set target="${favoritesList}" property="items" value="${attributeMapList}"/>