<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/controller/postings.jsp#1 $
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
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>


<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:set target="${forum}" property="postingsSource" value="${widgetContent.fields.postingsSource.value}"/>
<c:set target="${forum}" property="showRating" value="${widgetContent.fields.showRatingPostings.value}"/>
<c:set target="${forum}" property="showReplyLink" value="${widgetContent.fields.showReplyLinkPostings.value}"/>
<c:set target="${forum}" property="showAbuseReportLink" value="${widgetContent.fields.showAbuseReportLinkPostings.value}"/>
<c:set target="${forum}" property="negativeRatingThreshold" value="${widgetContent.fields.negativeRatingThresholdPostings.value}"/>
<c:set target="${forum}" property="maxBodyLength" value="${widgetContent.fields.maxBodyLengthPostings.value}"/>
<c:set target="${forum}" property="maxDepth" value="${widgetContent.fields.maxDepthPostings.value}"/>

<c:set target="${forum}" property="avatarImageVersion" value="${fn:trim(widgetContent.fields.avatarImageVersionPostings.value)}"/>
<c:set target="${forum}" property="avatarSize" value="${fn:substringAfter(forum.avatarImageVersion, 'w')}" />

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="forum" />
</c:if>
<c:set target="${forum}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:choose>
  <c:when test="${ forum.postingsSource == 'thread' and requestScope['com.escenic.context'] == 'art' and article.articleTypeName == 'posting'}">
    <jsp:useBean id="article" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>
    <forum:thread id="thread" threadId="${article.id}" />

    <c:if test="${not empty thread}">
      <%-- title --%>
      <c:set target="${forum}" property="threadTitle" value="${thread.title}" />
      <%-- forum info --%>
      <c:set target="${forum}" property="forumUrl" value="${thread.forum.url}" />
      <c:set target="${forum}" property="forumName" value="${thread.forum.fields.name}" />
    </c:if>
  </c:when>

  <c:when test="${forum.postingsSource == 'latest'}">
    <article:list id="latestPostingArticles"
                  includeArticleTypes="posting"
                  sectionUniqueName="${forum.sectionUniqueName}"
                  max="${forum.maxItems}"
                  from="${requestScope.articleListDateString}"/>

    <jsp:useBean id="forumPostingList" class="java.util.ArrayList" />

    <c:forEach var="posting" items="${latestPostingArticles}">
      <forum:posting id="forumPosting" postingId="${posting.id}" />
      <collection:add collection="${forumPostingList}" value="${forumPosting}" />
    </c:forEach>

    <c:set target="${forum}" property="latestPostings" value="${forumPostingList}" />
    <c:remove var="forumPostingList" />
  </c:when>
</c:choose>