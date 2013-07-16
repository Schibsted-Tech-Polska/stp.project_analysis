<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/authorName.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this jsp renders the threads view of forum widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<%-- the controller has already set a hashmap named 'forum' in the requestScope --%>
<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:set var="articleId" value="${fn:trim(param.articleId)}" />

<c:if test="${not empty articleId}">
  <article:use articleId="${articleId}">
    <c:set var="authorId" value="${article.author.id}" />

    <%-- first try to load a community user with the given authorId--%>
    <community:user id="communityUser" userId="${authorId}" />

    <c:choose>
      <c:when test="${not empty communityUser and forum.usernameClickable}">
        <a href="${communityUser.section.url}"><c:out value="${communityUser.article.fields.firstname} ${communityUser.article.fields.surname}"/></a>
      </c:when>
      <c:otherwise>
        <c:out value="${article.author.name}"/>
      </c:otherwise>
    </c:choose>
  </article:use>
</c:if>



