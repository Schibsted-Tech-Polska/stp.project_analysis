<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/threaded.jsp#1 $
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
  the purpose of this page is to render the default view of the comments widget
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%-- the controller has already set a HashMap named 'comments' in the requestScope --%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<div class="${comments.wrapperStyleClass}" <c:if test="${not empty comments.styleId}">id="${comments.styleId}"</c:if>>
  <%-- call helpers/commentsCounter.jsp and get numberOfAllComments and numberOfTopLevelComments of the article from the requestScope --%>
  <!--requestScope.numberOfAllComments and requestScope.numberOfTopLevelComments are never used-->
  <%--<jsp:include page="helpers/commentsCounter.jsp" />--%>

  <%-- call helpers/commentsListing.jsp to display the comments listing --%>
  <jsp:include page="helpers/commentsListing.jsp" />

  <%-- now check whether we should display the comment/complaint posting form or not --%>
  <c:set var="displayCommentForm" value="false" />
  <c:if test="${not empty comments.forumId}">
    <forum:group id="forum" forumId="${comments.forumId}" />
    <c:if test="${forum.acceptingPostings}">
      <c:set var="displayCommentForm" value="true" />
    </c:if>
  </c:if>
  <c:if test="${not comments.allowAnonymousComments and empty sessionScope.user}">
    <c:set var="displayCommentForm" value="false" />
  </c:if>

  <%-- call helpers/commentForm.jsp to display comment/complaint form --%>
  <c:if test="${displayCommentForm=='true'}">
    <c:choose>
      <c:when test="${comments.allowAnonymousComments and empty sessionScope.user and comments.captcha}">
        <jsp:include page="helpers/captchaCommentForm.jsp" />
      </c:when>
      <c:otherwise>
        <jsp:include page="helpers/commentForm.jsp" />
      </c:otherwise>
    </c:choose>
  </c:if>
</div>

