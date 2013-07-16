<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-favoritesList/src/main/webapp/template/widgets/favoritesList/view/detailed.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this page renders the detailed view of favoritesList widget--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the controllers has already set a HashMap named 'favoritesList' in the requestScope --%>
<jsp:useBean id="favoritesList" type="java.util.Map" scope="request" />

<c:if test="${not empty favoritesList.items}">
  <div class="${favoritesList.wrapperStyleClass}" <c:if test="${not empty favoritesList.styleId}">id="${favoritesList.styleId}"</c:if> >

   <%-- show the header conditionally --%>
    <c:if test="${requestScope.tabbingEnabled!='true'}">
      <div class="header">
        <h5><c:out value="${favoritesList.title}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <div class="content">
      <c:forEach var="favoriteItem" items="${favoritesList.items}">
        <div class="article ${favoriteItem.articleClass}">
          <c:set var="teaserImageMap" value="${favoriteItem.teaserImageMap}"/>
          <c:if test="${favoritesList.showThumb and not empty teaserImageMap.imageArticle}">
            <c:set var="imageArticle" value="${teaserImageMap.imageArticle}"/>
            <c:set var="imageVersion" value="w80"/>
            <img src="${imageArticle.fields.alternates.value[imageVersion].href}"
                 alt="${teaserImageMap.alttext}"
                 title="${teaserImageMap.caption}"
                 width="${imageArticle.fields.alternates.value[imageVersion].width}"
                 height="${imageArticle.fields.alternates.value[imageVersion].height}"/>
          </c:if>

          <h4>
            <a href="${favoriteItem.articleUrl}"><c:out value="${favoriteItem.title}" escapeXml="true"/></a>
          </h4>

          <c:if test="${favoritesList.showIntro}">
            <p><c:out value="${favoriteItem.leadtext}" escapeXml="true"/></p>
          </c:if>

          <c:if test="${favoritesList.showDate}">
            <p class="dateline"><c:out value="${favoriteItem.publishedDate}" escapeXml="true"/></p>
          </c:if>

          <c:if test="${favoritesList.showCommentCount and not empty favoriteItem.commentsLinkUrl}">
            <p class="comments">
              <a href="${favoriteItem.commentsLinkUrl}"><c:out value="${favoriteItem.commentsLinkText}" escapeXml="true"/></a>
            </p>
          </c:if>

          <c:if test="${favoritesList.showFavoritesCount}">
            <p class="favoritesCount">
              <fmt:message key="favoritesList.favorites.count">
                <fmt:param value="${favoriteItem.favoritesCount}" />
              </fmt:message>
            </p>
          </c:if>          
        </div>
      </c:forEach>
    </div>
  </div>
</c:if>

<c:remove var="favoritesList" scope="request"/>









