<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/controller/twitter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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

<jsp:useBean id="feed" type="java.util.Map" scope="request"/>

<c:set target="${feed}" property="twitterSearchOption" value="${fn:trim(widgetContent.fields.twitterSearchOption.value)}"/>
<c:set target="${feed}" property="twitterMessageCount" value="${widgetContent.fields.twitterMessageCount.value}"/>
<c:set target="${feed}" property="showAvatarImage" value="${widgetContent.fields.showAvatarImage.value}"/>
<c:set target="${feed}" property="avatarImageWidth" value="48"/>
<c:set target="${feed}" property="avatarImageHeight" value="48"/>
<c:set target="${feed}" property="showDateTwitter" value="${widgetContent.fields.showDateTwitter.value}"/>
<c:set target="${feed}" property="twitterUpdateInterval" value="${widgetContent.fields.twitterUpdateInterval.value}"/>

<c:choose>
  <c:when test="${feed.twitterSearchOption == 'searchWithKeywords'}">
    <c:set var="keywordArray" value="${fn:split(widgetContent.fields.twitterSearchKeywords.value, ',')}"/>
    <c:forEach var="keyword" items="${keywordArray}" varStatus="loopStatus">
      <c:if test="${not empty fn:trim(keyword)}">
        <c:choose>
          <c:when test="${loopStatus.first}">
            <c:set var="keywords" value="${keyword}"/>
          </c:when>
          <c:otherwise>
            <c:set var="keywords" value="${keywords} ${keyword}"/>
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:forEach>

    <c:set target="${feed}" property="twitterSearchKeywords" value="${keywords}"/>
  </c:when>
  <c:when test="${feed.twitterSearchOption == 'searchWithUserNames'}">
    <c:set var="twitterUserNames" value="${fn:trim(widgetContent.fields.twitterUserNames.value)}"/>
    <c:set var="userNameArray" value="${fn:split(twitterUserNames, ',')}"/>

    <c:forEach var="userName" items="${userNameArray}" varStatus="loopStatus">
      <c:if test="${not empty fn:trim(userName)}">
        <c:choose>
          <c:when test="${loopStatus.first}">
            <c:set var="userNames" value="\"${userName}\""/>
          </c:when>
          <c:otherwise>
            <c:set var="userNames" value="${userNames}, \"${userName}\""/>
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:forEach>

    <c:set target="${feed}" property="twitterUserNames" value="${userNames}"/>
  </c:when>
  <c:when test="${feed.twitterSearchOption == 'searchWithArticleTags' and requestScope['com.escenic.context'] == 'art'}">

    <c:forEach var="articleTag" items="${article.tags}" varStatus="loopStatus">
      <c:choose>
        <c:when test="${loopStatus.first}">
          <c:set var="keywords" value="${articleTag.name}"/>
        </c:when>
        <c:otherwise>
          <c:set var="keywords" value="${keywords} ${articleTag.name}"/>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:set target="${feed}" property="twitterSearchKeywords" value="${keywords}"/>
  </c:when>
</c:choose>