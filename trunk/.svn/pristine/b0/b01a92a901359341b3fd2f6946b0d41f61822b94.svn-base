<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userActivity/src/main/webapp/template/widgets/userActivity/controller/default.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection"%>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="stats" uri="http://www.escenic.com/taglib/escenic-stats" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="userActivity" type="java.util.Map" scope="request"/>
<jsp:useBean id="currentDate" class="java.util.Date"/>

<wf-core:getDate id="fromDate" referenceDate="${currentDate}" hourDiff="${-24*userActivity.numberOfDays}"/>

<c:choose>
  <c:when test="${userActivity.userOption=='current'}">
    <profile:present>
      <section:use uniqueName="${sessionScope.user.userName}">
        <community:user id="currentUser" sectionId="${section.id}"/>
        <stats:actionList id="actions"
                          type="${userActivity.actionString}"
                          userId="${currentUser.id}"
                          from="${fromDate}"
                          to="${currentDate}"/>
        <c:remove var="currentUser" scope="page"/>
      </section:use>
    </profile:present>
  </c:when>
  <c:when test="${userActivity.userOption=='blog'}">
    <community:user id="blogUser" sectionId="${section.id}"/>
    <c:if test="${not empty blogUser}">
      <stats:actionList id="actions"
                        type="${userActivity.actionString}"
                        userId="${blogUser.id}"
                        from="${fromDate}"
                        to="${currentDate}"/>
    </c:if>
    <c:remove var="blogUser" scope="page"/>
  </c:when>
  <c:otherwise>
    <stats:actionList id="actions"
                      type="${userActivity.actionString}"
                      from="${fromDate}"
                      to="${currentDate}"/>
  </c:otherwise>
</c:choose>

<c:remove var="fromDate" scope="request" />

<collection:createList id="attributeMapList" type="java.util.ArrayList" toScope="page"/>

<c:forEach var="action"  items="${actions}">
  <c:if test="${(fn:length(attributeMapList)<userActivity.maxActivity) and (not empty action.actionType) and
                (not empty action.articleId) and (not empty action.authorId) }">
    <article:use articleId="${action.articleId}">
      <wf-core:contains id="contains" nameList="${userActivity.contentTypes}" name="${article.articleTypeName}"/>
      <c:if test="${contains}">
        <collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>

        <c:set target="${attributeMap}" property="actionName" value="${fn:toLowerCase(action.actionType.name)}"/>

        <c:set target="${attributeMap}" property="actionText">
          <fmt:message key="userActivity.widget.${attributeMap.actionName}.text"/>
        </c:set>

        <c:if test="${userActivity.showSummary}">
          <wf-core:getFieldValueByKey var="articleSummaryMap" key="leadtext" articleId="${action.articleId}"/>
          <wf-core:getCurtailedText var="curtailedArticleSummary" inputText="${requestScope.articleSummaryMap.fieldValue}" maxLength="${userActivity.maxSummaryChar}" ellipsis="..."/>
          <c:set target="${attributeMap}" property="articleSummary" value="${curtailedArticleSummary}" />
          <c:remove var="articleSummaryMap" scope="request"/>
          <c:remove var="curtailedArticleSummary" scope="request"/>
        </c:if>

        <c:choose>
          <c:when test="${article.articleTypeName == 'posting'}">
            <c:set var="postingArticleIdFieldValue" value="${article.fields.articleId.value}" />
            <%-- first, check whether this posting is an article comment or a forum posting--%>
            <c:choose>
              <c:when test="${not empty postingArticleIdFieldValue}">
                <%-- this posting is an article comment--%>
                <article:use articleId="${article.fields.articleId.value}">
                  <c:set target="${attributeMap}" property="articleUrl" value="${article.url}" />
                  <wf-core:getFieldValueByKey var="articleTitleMap" key="title" articleId="${action.articleId}"/>
                  <c:set var="articleTitle" value="${requestScope.articleTitleMap.fieldValue}"/>
                  <c:remove var="articleTitleMap" scope="request"/>
                </article:use>
              </c:when>
              <c:otherwise>
                <%-- this posting is a forum posting--%>
                <forum:posting id="postingArticle" postingId="${article.id}"/>
                <c:choose>
                  <c:when test="${not empty postingArticle}">
                    <c:set var="postingThread" value="${postingArticle.thread.root}" />
                    <c:set target="${attributeMap}" property="articleUrl" value="${postingThread.url}" />
                    <c:set var="articleTitle" value="${postingThread.title}" />
                  </c:when>
                  <c:otherwise>
                    <c:set target="${attributeMap}" property="articleUrl" value="${article.url}" />
                    <c:set var="articleTitle" value="${article.title}" />
                  </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <c:set target="${attributeMap}" property="articleUrl" value="${article.url}" />
            <wf-core:getFieldValueByKey var="articleTitleMap" key="title" articleId="${action.articleId}"/>
            <c:set var="articleTitle" value="${requestScope.articleTitleMap.fieldValue}"/>
            <c:remove var="articleTitleMap" scope="request"/>
          </c:otherwise>
        </c:choose>

        <c:set target="${attributeMap}" property="articleTitle" value="${articleTitle}" />
        <c:remove var="articleTitle" scope="page"/>

        <community:user id="communityUser" userId="${action.userId}" />

        <c:choose>
          <c:when test="${(empty communityUser.article.fields.firstname.value) and (empty communityUser.article.fields.surname.value)}">
             <c:set target="${attributeMap}" property="username" value="${communityUser.article.fields.blogname.value}" />
          </c:when>
          <c:otherwise>
            <c:set target="${attributeMap}" property="username" value="${communityUser.article.fields.firstname.value} ${communityUser.article.fields.surname.value}"/>
          </c:otherwise>
        </c:choose>

        <c:set target="${attributeMap}" property="blogUrl" value="${communityUser.section.url}" />

        <c:if test="${userActivity.showAvatar}">
          <c:choose>
            <c:when test="${not empty communityUser.article.relatedElements.profilePictures.items and
                          communityUser.article.relatedElements.profilePictures.items[0].content.articleTypeName == 'avatar'}">
              <c:set target="${attributeMap}" property="avatureImageUrl"
                     value="${communityUser.article.relatedElements.profilePictures.items[0].content.fields.alternates.value[userActivity.avatarImageVersion].href}" />
            </c:when>
            <c:otherwise>
              <c:set target="${attributeMap}" property="avatureImageUrl"
                     value="${skinUrl}gfx/userActivity/default-avatar.jpg" />
            </c:otherwise>
          </c:choose>
        </c:if>

        <c:choose>
          <c:when test="${userActivity.showDateDifference}">
            <wf-core:getDateDifference var="tempDateString" from="${action.dateTime}" to="${currentDate}"/>
            <c:set var="dateSting" value="${tempDateString}"/>
            <c:remove var="tempDateString" scope="request"/>
          </c:when>
          <c:otherwise>
            <c:set var="dateSting">
              <fmt:formatDate value="${action.dateTime}" pattern="${userActivity.dateFormat}"/>
            </c:set>
          </c:otherwise>
        </c:choose>
        <c:set target="${attributeMap}" property="dateSting" value="${dateSting}"/>

        <collection:add collection="${attributeMapList}" value="${attributeMap}"/>
        <c:remove var="attributeMap" scope="page"/>
      </c:if>
      <c:remove var="contains" scope="request"/>
    </article:use>
  </c:if>
</c:forEach>

<c:set target="${userActivity}" property="attributeMapList" value="${attributeMapList}"/>\
