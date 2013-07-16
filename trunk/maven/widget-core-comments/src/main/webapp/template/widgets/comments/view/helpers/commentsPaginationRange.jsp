<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsPaginationRange.jsp#1 $
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
  The purpose of this page is find the pagination range while displaying comments listing of an article
  for given numberOfPages, currentPageNumber and numberOfPageLinks.  
  This page stores two objects in the request scope 'beginPageNumber' and 'endPageNumber' for the range
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<c:set var="beginPageNumber" value="1" />
<c:set var="endPageNumber" value="${comments.numberOfPageLinks}" />

<c:if test="${comments.currentPageNumber >=1 and  comments.currentPageNumber <= comments.numberOfPages}">
  <c:set var="result" value="${comments.currentPageNumber div comments.numberOfPageLinks}" />
  <c:set var="fraction" value="${fn:substringAfter(result, '.')}" />
  <c:set var="result" value="${fn:substringBefore(result, '.')}" />
  <c:if test="${fraction=='0'}">
    <c:set var="result" value="${result-1}" />
  </c:if>

  <c:set var="beginPageNumber" value="${(result * comments.numberOfPageLinks) + 1}"/>
  <c:set var="endPageNumber" value="${(result * comments.numberOfPageLinks) + comments.numberOfPageLinks}"/>

  <c:if test="${endPageNumber > comments.numberOfPages}">
    <c:set var="endPageNumber" value="${comments.numberOfPages}" />
    <c:set var="tempBeginPageNumber" value="${endPageNumber - comments.numberOfPageLinks + 1}" />
    <c:if test="${tempBeginPageNumber > 0}">
      <c:set var="beginPageNumber" value="${tempBeginPageNumber}" />
    </c:if>
  </c:if>
</c:if>

<c:set var="beginPageNumber" value="${beginPageNumber}" scope="request" />
<c:set var="endPageNumber" value="${endPageNumber}" scope="request" />