<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/showRating.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to display the rating functionality of a posting --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile"%>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<article:use articleId="${param.ratingPostingId}">
  <qual:qualification id="starRating" type="StarRating" />
  <c:set var="ratingValue" value="${2*starRating.value-starRating.count}"/>
  <c:set var="commentsArticleId" value="${article.id}"/>
  <c:set var="commentCurrentRatingId" value="comment${commentsArticleId}-rating"/>

  <c:choose>
    <c:when test="${ratingValue > 0}">
      <c:set var="commentCurrentRatingClass" value="positive"/>
    </c:when>
    <c:when test="${ratingValue < 0}">
      <c:set var="commentCurrentRatingClass" value="negative"/>
    </c:when>
    <c:otherwise>
      <c:set var="commentCurrentRatingClass" value="zero"/>
    </c:otherwise>
  </c:choose>
</article:use>

<profile:present>
  <section:use uniqueName="${sessionScope.user.userName}">
    <community:user id="currentUser" sectionId="${section.id}"/>
  </section:use>
  <c:set var="unauthorizedMsg" scope="page">
    <fmt:message key="forum.widget.postings.rating.unauthorizedMsg.text" />
  </c:set>
  <c:set var="alreadyRatedMsg" scope="page">
    <fmt:message key="forum.widget.postings.rating.alreadyRatedMsg.text" />
  </c:set>
  <c:set var="onclickUp" value="return submitThumbsUpDownRating(${commentsArticleId}, ${currentUser.id}, ${1},'${commentCurrentRatingId}','${unauthorizedMsg}','${alreadyRatedMsg}');"/>
  <c:set var="onclickDown" value="return submitThumbsUpDownRating(${commentsArticleId}, ${currentUser.id}, ${0},'${commentCurrentRatingId}','${unauthorizedMsg}','${alreadyRatedMsg}');"/>
  <c:remove var="unauthorizedMsg" scope="page"/>
  <c:remove var="alreadyRatedMsg" scope="page"/>
  <c:remove var="currentUser" scope="page"/>    
</profile:present>

<profile:notPresent>
  <fmt:message var="message" key="forum.widget.postings.rating.notloggedin.message.text" />
  <c:set var="onclickUp" value="alert('${message}');"/>
  <c:set var="onclickDown" value="alert('${message}');"/>
</profile:notPresent>

<div class="postingRating">
  <span class="currentRating ${commentCurrentRatingClass}" id="${commentCurrentRatingId}"><c:out value="${ratingValue}"/></span>

  <c:choose>
    <c:when test="${not empty requestScope.currentUserPosting and requestScope.currentUserPosting==true}">
      <a class="thumbsUp thumbsUpDisabled" onclick="return false;"><span>up</span></a>
      <a class="thumbsDown thumbsDownDisabled" onclick="return false;"><span>down</span></a>
    </c:when>
    <c:otherwise>
      <a class="thumbsUp" onclick="${onclickUp}" title="Vote up"><span>up</span></a>
      <a class="thumbsDown" onclick="${onclickDown}" title="Vote down"><span>down</span></a>
    </c:otherwise>
  </c:choose>

</div>

<c:set var="postingCurrentRating" value="${ratingValue}" scope="request" />

<c:remove var="ratingValue" scope="page"/>
<c:remove var="commentCurrentRatingClass" scope="page"/>
<c:remove var="commentsArticleId" scope="page"/>
<c:remove var="commentCurrentRatingId" scope="page"/>
<c:remove var="onclickUp" scope="page"/>
<c:remove var="onclickDown" scope="page"/>



