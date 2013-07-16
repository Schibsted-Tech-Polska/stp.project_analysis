<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/view/twitter.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="${requestScope.resourceUrl}js/jquery.tweet.js"></script>

<jsp:useBean id="feed" type="java.util.Map" scope="request"/>
<c:set var="twitterDivClassName" value="twitter-${widgetContent.id}"/>

<div class="${feed.wrapperStyleClass} ${twitterDivClassName}" <c:if test="${not empty feed.styleId}">id="${feed.styleId}"</c:if>>
  <c:if test="${requestScope.tabbingEnabled!='true'}">
    <div class="header">
      <h5><c:out value="${fn:trim(element.fields.title.value)}" escapeXml="true"/></h5>
    </div>
  </c:if>

  <c:set var="tweetLoadingMessage">
    <fmt:message key="feed.twitter.loading.message"/>
  </c:set>

  <c:choose>
    <c:when test="${feed.twitterSearchOption == 'searchWithKeywords'}">
      <c:set var="keywords" value="${feed.twitterSearchKeywords}"/>
    </c:when>
    <c:when test="${feed.twitterSearchOption == 'searchWithUserNames'}">
      <c:set var="userNames" value="${feed.twitterUserNames}"/>
    </c:when>
    <c:when test="${feed.twitterSearchOption == 'searchWithArticleTags' and requestScope['com.escenic.context'] == 'art'}">
      <c:set var="keywords" value="${feed.twitterSearchKeywords}"/>
    </c:when>
  </c:choose>

  <script type='text/javascript'>
    $(document).ready(function($) {
      $(".${twitterDivClassName}").tweet({
        <c:if test="${not empty userNames}">username: [${userNames}],</c:if>
        <c:if test="${not empty keywords}">query:"${keywords}",</c:if>        
        showAvatar:${feed.showAvatarImage},
        showDate:${feed.showDateTwitter},
        avatar_width: ${feed.avatarImageWidth},
        avatar_height:${feed.avatarImageHeight},
        count: ${feed.twitterMessageCount},
        loading_text: "${tweetLoadingMessage}"
      });
    });
  </script>
</div>

<c:remove var="feed" scope="request"/>