<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/controller/threaded.jsp#1 ${PACKAGE_NAME}/${NAME}.jsp#1 $
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

<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<%-- retrive necessary parameters from element fields --%>
<c:set target="${comments}" property="allowAnonymousComments" value="${fn:trim(widgetContent.fields.anonymousThreaded)}"/>
<c:set target="${comments}" property="moderateComments" value="${fn:trim(widgetContent.fields.moderationThreaded)}"/>
<c:set target="${comments}" property="allowComplaints" value="${fn:trim(widgetContent.fields.complaintsThreaded)}"/>
<c:set target="${comments}" property="numberOfCommentsPerPage" value="${fn:trim(widgetContent.fields.commentsPerPageThreaded)}"/>
<c:set target="${comments}" property="numberOfPageLinks" value="${fn:trim(widgetContent.fields.numberOfPageLinksThreaded)}"/>
<c:set target="${comments}" property="threadDepth" value="${fn:trim(widgetContent.fields.threadDepth)}"/>

<c:set var="moderatedForumId" value="${section.parameters['comments.moderated.forumId']}" />
<c:set var="unmoderatedForumId" value="${section.parameters['comments.unmoderated.forumId']}" />
<c:set target="${comments}" property="forumId" value="${comments.moderateComments ? moderatedForumId : unmoderatedForumId}"/>

<c:set var="numberOfPages" value="${comments.numberOfTopLevelComments div comments.numberOfCommentsPerPage}"/>
<c:set var="numberOfPagesFraction" value="${fn:substringAfter(numberOfPages,'.')}"/>
<c:set var="numberOfPages" value="${fn:substringBefore(numberOfPages,'.')}"/>
<c:if test="${numberOfPagesFraction > 0}">
  <c:set var="numberOfPages" value="${numberOfPages+1}"/>
</c:if>
<c:set target="${comments}" property="numberOfPages" value="${numberOfPages}"/>

<c:set var="currentPageNumber" value="${param.pageNumber}"/>
<c:if test="${currentPageNumber==null or empty currentPageNumber or
            currentPageNumber < 1 or currentPageNumber > comments.numberOfPages}">
  <c:set var="currentPageNumber" value="1"/>
</c:if>
<c:set target="${comments}" property="currentPageNumber" value="${currentPageNumber}"/>

<c:set target="${comments}" property="allowReplies" value="true" />