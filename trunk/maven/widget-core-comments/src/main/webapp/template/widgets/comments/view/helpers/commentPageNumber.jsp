<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentPageNumber.jsp#1 $
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
  the purpose of this page is to find out the appropiate page number for a given comment
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<jsp:useBean id="comment" type="com.escenic.forum.presentation.PresentationPosting" scope="request" />
<jsp:useBean id="topLevelCommentsList" type="java.util.ArrayList" scope="request" />

<c:set var="pageNumber" value="1" />

<c:if test="${not empty comment}">
  <%
    com.escenic.forum.presentation.PresentationPosting topLevelComment = comment;
    com.escenic.forum.presentation.PresentationPosting currentComment = comment;
    while (currentComment.getParent() != null) {
      topLevelComment = currentComment;
      currentComment = currentComment.getParent();
    }
  %>
  <c:set var="topLevelCommentId" value="<%=topLevelComment.getId()%>" />
  <c:set var="pageCount" value="0" />
  <c:forEach var="topLevelComment" items="${topLevelCommentsList}" varStatus="status">
    <c:if test="${status.index mod comments.numberOfCommentsPerPage == 0}">
      <c:set var="pageCount" value="${pageCount+1}" />
    </c:if>

    <c:if test="${topLevelComment.id == topLevelCommentId}">
      <c:set var="pageNumber" value="${pageCount}" />
    </c:if>
  </c:forEach>
</c:if>

<c:set var="pageNumber" value="${pageNumber}" scope="request" />