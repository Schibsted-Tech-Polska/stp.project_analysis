<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsCounter.jsp#1 $
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
  The purpose of this page is to return the number of comments of an article.
  This page stores two objects in the request scope:

  1. number of all comments in requestScope.numberOfAllComments and
  2. number of only the top level comments in requestScope.numberOfTopLevelComments
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<c:set var="numberOfAllComments" value="0"/>
<c:set var="numberOfTopLevelComments" value="0"/>

<article:hasRelation includeArticleTypes="posting">
  <relation:articles id="relatedThread" includeArticleTypes="posting">
    <forum:thread id="thread" threadId="${relatedThread.id}"/>
    <c:set var="numberOfAllComments" value="${numberOfAllComments+thread.postingCount-1}"/>
    <c:set var="numberOfTopLevelComments" value="${numberOfTopLevelComments + thread.root.repliesCount}"/>
  </relation:articles>
</article:hasRelation>

<c:set var="numberOfAllComments" value="${numberOfAllComments}" scope="request" />
<c:set var="numberOfTopLevelComments" value="${numberOfTopLevelComments}" scope="request" />


