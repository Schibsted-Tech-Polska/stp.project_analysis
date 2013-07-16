<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsListingPerPage.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  the purpose of this page is to display existing comments of an article on one page 
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="template" uri="http://www.escenic.com/taglib/escenic-template" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<jsp:useBean id="commentsList" type="java.util.List" scope="request" />
<jsp:useBean id="beginCommentIndex" type="java.lang.String" scope="request" />
<jsp:useBean id="endCommentIndex" type="java.lang.String" scope="request" />

<util:profiler path="/template/widgets/comments/view/helpers/commentsListingPerPage.jsp">
  <c:forEach var="comment" items="${commentsList}" begin="${beginCommentIndex}" end="${endCommentIndex}">
    <div class="comment">
      <div id="comment-${comment.id}" class="comment-box">
        <c:if test="${comments.showTitle=='true'}">
          <h5>
            <c:out value="${comment.fields.title}" escapeXml="false"/>
          </h5>
        </c:if>

        <p class="body"><c:out value="${comment.fields.body}" escapeXml="false"/></p>

        <p class="metadata">
          <fmt:message key="comments.listing.comment.metadata.byline.label" />
          <c:set var="byline" value="${fn:trim(comment.fields.byline)}" />
          <c:set var="email" value="${comment.senderEmail}" />
          <a href="mailto:${email}">${not empty byline ? byline : email}</a>

          <fmt:message key="comments.listing.comment.metadata.dateline.label" />
          <article:use articleId="${comment.id}">
            <fmt:formatDate value="${article.publishedDateAsDate}" pattern="MM/dd/yyyy HH:mm"/>
          </article:use>

          <c:if test="${not empty comments.allowReplies and comments.allowReplies and currentThreadDepth<comments.threadDepth}">
            <c:url var="addCommentUrl" value="${article.url}">
              <c:param name="pageNumber" value="${comments.currentPageNumber}" />
              <c:param name="parentId" value="${comment.id}" />
              <c:param name="operation" value="comment" />
            </c:url>
            <a class="commentLink" href="${addCommentUrl}#commentsForm"><fmt:message key="comments.add.reply.linktext" /></a>
          </c:if>

          <c:if test="${comments.allowComplaints}">
            <c:choose>
              <c:when test="${not empty param.complaintParentId and param.complaintParentId == comment.id}">
                <span class="abuseReported"><fmt:message key="comments.add.complain.reported" /></span>
              </c:when>
              <c:otherwise>
                <c:url var="addComplaintUrl" value="${article.url}">
                  <c:param name="pageNumber" value="${comments.currentPageNumber}" />
                  <c:param name="parentId" value="${comment.id}" />
                  <c:param name="operation" value="complaint" />
                </c:url>
                <a class="commentLink" href="${addComplaintUrl}#commentsForm"><fmt:message key="comments.add.complain.linktext" /></a>
              </c:otherwise>
            </c:choose>
          </c:if>
        </p>
      </div>

      <c:if test="${comment.repliesCount > 0 and comments.allowReplies and currentThreadDepth<comments.threadDepth}">
        <c:set var="commentsList" value="${comment.replies}" />
        <template:call file="commentsListingPerPage.jsp">
          <template:parameter key="commentsList" name="commentsList" />
          <template:parameter key="beginCommentIndex" value="0" />
          <template:parameter key="endCommentIndex" value="${comment.repliesCount}"/>
          <template:parameter key="currentThreadDepth" value="${currentThreadDepth+1}"/>
        </template:call>
        <c:remove var="commentsList" scope="page" />
      </c:if>
    </div>
  </c:forEach>
</util:profiler>