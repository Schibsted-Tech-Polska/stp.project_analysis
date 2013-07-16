<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/comments.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the comments view list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<c:set target="${list}" property="contentType" value="posting"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameComments.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${list}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${list}" property="itemCount" value="${fn:trim(widgetContent.fields.itemCountComments.value)}"/>
<c:set target="${list}" property="maxCharacters" value="${fn:trim(widgetContent.fields.maxCharactersComments)}"/>
<c:set target="${list}" property="includeSubsections" value="${fn:trim(widgetContent.fields.includeSubsectionsComments.value)}"/>
<c:set target="${list}" property="showBody" value="${fn:trim(widgetContent.fields.showBodyComments.value)}"/>
<c:set target="${list}" property="showCommentCount" value="${fn:trim(widgetContent.fields.showCommentCountComments.value)}"/>
<c:set target="${list}" property="showDate" value="${fn:trim(widgetContent.fields.showDateComments.value)}"/>
<c:set target="${list}" property="showAuthor" value="${fn:trim(widgetContent.fields.showAuthorComments.value)}" />
<c:set target="${list}" property="commentDatePrefix" value="${fn:trim(widgetContent.fields.commentDatePrefix.value)}"/>
<c:set target="${list}" property="commentAuthorPrefix" value="${fn:trim(widgetContent.fields.commentAuthorPrefix.value)}"/>

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormatComments.value)}"/>
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMMM dd yyyy hh:mm"/>
</c:if>
<c:set target="${list}" property="dateFormat" value="${dateFormat}"/>

<%-- filtering thread postings from comment postings --%>
<section:use uniqueName="${list.sectionUniqueName}">
  <article:list id="postingsList"
                sectionUniqueName="${list.sectionUniqueName}"
                includeSubSections="${list.includeSubsections}"
                includeArticleTypes="${list.contentType}"
                max="${list.itemCount*2}"
                sort="-publishDate"
                from="${requestScope.articleListDateString}"/>
</section:use>

<collection:createList id="commentsList" type="java.util.ArrayList" />
<c:set var="count" value="0"/>
<c:forEach var="item" items="${postingsList}">
  <forum:posting id="posting" postingId="${item.id}"/>
  <c:if test="${not empty posting.parent and count < list.itemCount}">
    <collection:add collection="${commentsList}" value="${posting}" />
    <c:set var="count" value="${count+1}"/>
  </c:if>
</c:forEach>

<%-- create a list that will contain commentMap for each comment --%>
<collection:createList id="commentMapList" type="java.util.ArrayList" />

<c:if test="${not empty commentsList}">
  <c:forEach var="cArticle" items="${commentsList}" varStatus="loopStatus">
    <c:set var="articleClass" value="${loopStatus.first ? 'first' : ''}"/>

    <article:use articleId="${cArticle.id}">
      <jsp:useBean id="commentMap" class="java.util.HashMap" scope="page"/>

      <c:set target="${commentMap}" property="articleClass" value="${articleClass}"/>
      <c:set target="${commentMap}" property="publishedDate">
        <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${list.dateFormat}"/>
      </c:set>

      <c:set target="${commentMap}" property="title" value="${fn:trim(article.fields.title.value)}" />
      <c:set target="${commentMap}" property="body" value="${fn:trim(article.fields.body.value)}" />

      <c:if test="${not empty commentMap.body}">
        <wf-core:getCurtailedText var="curtailedBody" inputText="${commentMap.body}"
                                    maxLength="${list.maxCharacters}" ellipsis="....."/>
        <c:set target="${commentMap}" property="body" value="${requestScope.curtailedBody}"/>
        <c:remove var="curtailedBody" scope="request"/>
      </c:if>

      <c:set var="postingArticleId" value="${fn:trim(article.fields.articleId)}" />

      <c:set var="authorName" value="${fn:trim(article.fields.byline)}" />

      <c:set var="authorEmail" value="${cArticle.senderEmail}"/>
      <c:set var="authorUrl" value="mailto:${authorEmail}" />
      <c:set var="authorName" value="${authorEmail}" />
      <c:set target="${commentMap}" property="authorName" value="${authorName}" />
      <c:set target="${commentMap}" property="authorUrl" value="${authorUrl}"/>

      <c:if test="${not empty postingArticleId}">
        <article:use articleId="${postingArticleId}">
          <c:set target="${commentMap}" property="articleUrl" value="${article.url}#commentsList" />
          <c:set target="${commentMap}" property="articleId" value="${article.id}"/>

          <c:if test="${list.showCommentCount}">
            <wf-core:countArticleComments var="numberOfAllComments" articleId="${article.id}"/>
            <c:set target="${commentMap}" property="commentsLinkUrl" value="${article.url}#commentsList"/>

            <c:set target="${commentMap}" property="commentsLinkText">
              <fmt:message key="list.comment.count">
                <fmt:param value="${requestScope.numberOfAllComments}" />
              </fmt:message>
            </c:set>

            <c:remove var="numberOfAllComments" scope="request"/>
          </c:if>          
        </article:use>
      </c:if>

      <c:remove var="postingArticleId" scope="page" />

      <collection:add collection="${commentMapList}" value="${commentMap}"/>
      <c:remove var="commentMap" scope="page" />
    </article:use>
  </c:forEach>
</c:if>

<c:set target="${list}" property="commentsList" value="${commentMapList}"/>

