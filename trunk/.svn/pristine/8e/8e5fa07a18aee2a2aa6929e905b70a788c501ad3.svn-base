<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/showPosting.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:set var="tempPosting" value="${requestScope.posting}" />

<c:set var="tempShowReplies" value="${param.showReplies}" />
<c:set var="tempShowReplyForm" value="${param.showReplyForm}" />
<c:set var="tempShowThreadLink" value="${param.showThreadLink}" />
<c:set var="tempCurrentThreadDepth" value="${param.currentThreadDepth}" />
<c:set var="tempCustomStyleClass" value="${param.customStyleClass}" />
<c:set var="tempReplyLinkAnchor" value="${param.replyLinkAnchor}" />

<div class="posting<c:if test="${not empty tempCustomStyleClass}"> ${tempCustomStyleClass}</c:if>">

  <%-- check whether the posting is posted by the currently logged in user or nor --%>
  <article:use articleId="${tempPosting.id}">
    <c:set var="postingAuthorId" value="${article.author.id}" />
  </article:use>

  <c:choose>
    <c:when test="${not empty postingAuthorId and not empty sessionScope.user and postingAuthorId == sessionScope.user.id}">
      <c:set var="currentUserPosting" value="${true}" scope="request"/>
    </c:when>
    <c:otherwise>
      <c:set var="currentUserPosting" value="${false}" scope="request"/>
    </c:otherwise>
  </c:choose>

   <c:remove var="postingAuthorId" scope="page" />

  <div class="postingBox" id="posting-${tempPosting.id}">

    <!-- show avatar of the author of the posting -->
    <jsp:include page="avatarPicture.jsp" />

    <!-- show the rating of the current posting conditionally -->
    <c:if test="${forum.showRating == 'true'}">
      <!-- call showRating.jsp with parameter ratingPostingId, showRating.jsp displays rating of a comment and
        also sets the current rating value of a posting in the requestScoped variable named 'postingCurrentRating' -->
      <jsp:include page="showRating.jsp">
        <jsp:param name="ratingPostingId" value="${tempPosting.id}" />
      </jsp:include>
    </c:if>
    
    <div class="postingContent">
      <%-- display user name and date--%>
      <div class="metadata">
        <!-- display byline -->
        <span class="byline">
          <jsp:include page="authorName.jsp">
            <jsp:param name="articleId" value="${tempPosting.id}" />
          </jsp:include>
        </span>

        <!-- display dateline -->
        <article:use articleId="${tempPosting.id}">
          <c:set var="creationDate" value="${article.publishedDateAsDate}" />
        </article:use>
        <jsp:useBean id="currentDate" class="java.util.Date" scope="page"/>
        <wf-core:getDateDifference var="tempCreationTimeText" from="${creationDate}" to="${currentDate}"/>
        <span class="dateline"><c:out value="${tempCreationTimeText}" /></span>
        <c:remove var="tempCreationTimeText" scope="request"/>
        <c:remove var="currentDate" scope="page" />
      </div>

      <!-- display thread link -->
      <c:if test="${tempShowThreadLink == 'true'}">
        <c:set var="threadTitle" value="${tempPosting.thread.title}" />
        <c:set var="threadUrl" value="${tempPosting.thread.root.url}" />

        <div class="threadLink">
          <fmt:message key="forum.widget.postings.in.prefix" /> <a href="${threadUrl}"><c:out value="${threadTitle}"/></a>
        </div>
      </c:if>

      <!-- hide posting depending on rating -->
      <c:set var="hidePosting" value="${false}" />
      <c:if test="${not empty requestScope.postingCurrentRating and not empty forum.negativeRatingThreshold and (requestScope.postingCurrentRating+0) <= (forum.negativeRatingThreshold+0)}">
        <c:set var="hidePosting" value="${true}" />

        <p class="showHiddenPosting">
          <a href="#comment-${tempPosting.id}" onclick="showHiddenPosting('${tempPosting.id}'); return false;">
            <fmt:message key="forum.widget.posting.show.linkText" />
          </a>
        </p>

      </c:if>
      <c:remove var="postingCurrentRating" scope="request" />

      <!-- show body -->
      <p class="body" <c:if test="${hidePosting}">style="display:none;"</c:if> >
        <c:out value="${tempPosting.fields.body}"/>
      </p>

      <!-- if replyLinkAnchor is given, then reply link is added even if the form is not shown.-->
      <c:set var="addReplyLink" value="${forum.showReplyLink == 'true' and (tempShowReplyForm == 'true' or not empty tempReplyLinkAnchor) and tempCurrentThreadDepth < forum.maxDepth}" />
      <c:set var="addReplyForm" value="${forum.showReplyLink == 'true' and tempShowReplyForm == 'true' and tempCurrentThreadDepth < forum.maxDepth}" />
      <c:set var="addReportLink" value="${forum.showAbuseReportLink == 'true'}" />

      <%-- display comment links--%>
      <profile:present>
        <community:user id="communityUser" userId="${sessionScope.user.id}"/>

        <c:if test="${addReplyLink == 'true' or addReportLink == 'true'}">
          <div class="postingActionLinks" <c:if test="${hidePosting}">style="display:none;"</c:if> >
            <c:set var="replyDivId" value="insertPosting${tempPosting.id}"/>
            <c:set var="reportDivId" value="insertCompaint${tempPosting.id}"/>

            <ul>
              <c:if test="${addReplyLink == 'true'}">
                <li>
                  <a href="#${tempReplyLinkAnchor}" <c:if test="${addReplyForm == 'true'}">onclick="$('#${reportDivId}').slideUp('slow'); $('#${replyDivId}').slideToggle('slow'); return false;"</c:if> ><%--
                    --%><fmt:message key="forum.widget.postings.form.reply.post.linktext"/><%--
                  --%></a>
                </li>
              </c:if>

              <c:if test="${addReportLink == 'true' and currentUserPosting==false}">
                <li>
                  <a onclick="$('#${replyDivId}').slideUp('slow'); $('#${reportDivId}').slideToggle('slow'); return false;" href="#"><%--
                    --%><fmt:message key="forum.widget.postings.form.report.post.linktext"/><%--
                  --%></a>
                </li>
              </c:if>
            </ul>
          </div>
        </c:if>

        <c:set var="currentUrl" value="${requestScope['com.escenic.context']=='art' ? article.url : section.url}" />

        <c:if test="${addReplyLink == 'true'}">
          <jsp:include page="replyForm.jsp">
            <jsp:param name="divId" value="${replyDivId}" />
            <jsp:param name="customStyleClass" value="" />
            <jsp:param name="typeName" value="posting" />
            <jsp:param name="forumId" value="${tempPosting.forum.id}" />
            <jsp:param name="email" value="${communityUser.article.fields.email}" />
            <jsp:param name="parentId" value="${tempPosting.id}" />
            <jsp:param name="targetUrl" value="${currentUrl}" />
            <jsp:param name="errorUrl" value="${currentUrl}" />
            <jsp:param name="cancelUrl" value="${currentUrl}" />
            <jsp:param name="title" value="${tempPosting.fields.title}" />
            <jsp:param name="formHeadline" value="" />
            <jsp:param name="keepHidden" value="true" />
          </jsp:include>
        </c:if>

        <c:if test="${addReportLink == 'true' and currentUserPosting==false}">
          <jsp:include page="reportAbuseForm.jsp">
            <jsp:param name="divId" value="${reportDivId}" />
            <jsp:param name="typeName" value="posting" />
            <jsp:param name="forumId" value="${tempPosting.forum.id}" />
            <jsp:param name="email" value="${communityUser.article.fields.email}" />
            <jsp:param name="parentId" value="${tempPosting.id}" />
            <jsp:param name="targetUrl" value="${currentUrl}" />
            <jsp:param name="errorUrl" value="${currentUrl}" />
            <jsp:param name="cancelUrl" value="${currentUrl}" />
            <jsp:param name="title" value="${tempPosting.fields.title}" />
            <jsp:param name="keepHidden" value="true" />
          </jsp:include>
        </c:if>

      </profile:present>
    </div>
  </div>

  <c:remove var="currentUserPosting" scope="request" />

  <c:if test="${tempShowReplies == 'true'  and tempCurrentThreadDepth < forum.maxDepth}">
    <c:forEach var="posting" items="${tempPosting.replies}">
      <c:set var="posting" scope="request" value="${posting}"/>
      <jsp:include page="showPosting.jsp">
        <jsp:param name="showReplies" value="${tempShowReplies}" />
        <jsp:param name="showReplyForm" value="${tempShowReplyForm}" />
        <jsp:param name="showThreadLink" value="${tempShowThreadLink}" />
        <jsp:param name="currentThreadDepth" value="${tempCurrentThreadDepth + 1}" />
      </jsp:include>
    </c:forEach>
  </c:if>
</div>