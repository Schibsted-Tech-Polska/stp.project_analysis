<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsListing.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
  the purpose of this page is to display existing comments of an article in comments widget
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<article:hasNoRelation includeArticleTypes="posting">
  <%-- the following condition becomes true only after posting the first comment of an article --%>
  <c:if test="${not empty param.postingId}">
    <c:set var="newPostingId" value="${fn:trim(param.postingId)}" scope="request" />
    <jsp:include page="commentSuccess.jsp" />
    <c:remove var="newPostingId" scope="request" />
  </c:if>
</article:hasNoRelation>

<article:hasRelation includeArticleTypes="posting">
  <div id="commentsList">
    <%-- create an array list of all top level comments --%>
    <collection:createList id="topLevelCommentsList" type="java.util.ArrayList"/>
    <relation:articles id="relatedThread" includeArticleTypes="posting">
      <forum:thread id="thread" threadId="${relatedThread.id}"/>
      <c:forEach var="comment" items="${thread.root.replies}">
        <c:if test="${not empty comment.parent}">
          <collection:add collection="${topLevelCommentsList}" value="${comment}" />
        </c:if>
      </c:forEach>
    </relation:articles>

    <c:choose>
      <%-- param.postingId is not empty when a comment has just been posted --%>
      <c:when test="${not empty param.postingId}">
        <c:set var="newPostingId" value="${fn:trim(param.postingId)}" scope="request" />
        <c:set var="topLevelCommentsList" value="${topLevelCommentsList}" scope="request" />
        <jsp:include page="commentSuccess.jsp" />
        <c:remove var="topLevelCommentsList" scope="request" />
        <c:remove var="newPostingId" scope="request" />
      </c:when>
      <c:otherwise>
        <%-- display comment listing module header --%>
        <h4>
          <fmt:message key="comments.listing.headline">
            <fmt:param value="${comments.numberOfAllComments}" />
          </fmt:message>
        </h4>

        <%-- calculate beginPostingIndex and endPostingIndex to display paginated comments listing --%>
        <c:set var="beginCommentIndex" value="${(comments.currentPageNumber-1)*comments.numberOfCommentsPerPage}"/>
        <c:set var="endCommentIndex" value="${beginCommentIndex+comments.numberOfCommentsPerPage-1}"/>

        <%--
          call commentsListingPresentation.jsp to display the list of comments
          within the range of (beginCommentIndex,endCommentIndex)
        --%>
        <c:set var="commentsList" value="${topLevelCommentsList}" scope="request"/>
        <c:set var="beginCommentIndex" value="${fn:trim(beginCommentIndex)}" scope="request"/>
        <c:set var="endCommentIndex" value="${fn:trim(endCommentIndex)}" scope="request"/>
        <c:set var="currentThreadDepth" value="0" scope="request"/>

        <jsp:include page="commentsListingPerPage.jsp" />

        <c:remove var="commentsList" scope="request"/>
        <c:remove var="beginCommentIndex" scope="request"/>
        <c:remove var="endCommentIndex" scope="request"/>
        <c:remove var="currentThreadDepth" scope="request"/>

        <%-- render pagination at bottom --%>
        <c:set var="paginationStyleClass" value="bottom-pagination" scope="request" />
        <jsp:include page="commentsPagination.jsp" />
        <c:remove var="paginationStyleClass" scope="request" />
      </c:otherwise>
    </c:choose>
  </div>
</article:hasRelation>