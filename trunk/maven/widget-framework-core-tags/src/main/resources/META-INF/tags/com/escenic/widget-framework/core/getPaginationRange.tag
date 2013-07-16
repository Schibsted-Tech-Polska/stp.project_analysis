<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getPaginationRange.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  This tag takes 3 attributes: numberOfPages, currentPageNumber and numberOfPageLinks.
  This tag finds the appropiate pagination range and
  sets 2 attributes 'beginPageNumber' and 'endPageNumber' in the requestScope.  
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>

<%@ attribute name="numberOfPages" required="true" rtexprvalue="true" %>
<%@ attribute name="currentPageNumber" required="true" rtexprvalue="true" %>
<%@ attribute name="numberOfPageLinks" required="true" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="numberOfPages" value="${numberOfPages + 0}"/>
<c:set var="currentPageNumber" value="${currentPageNumber + 0}"/>
<c:set var="numberOfPageLinks" value="${numberOfPageLinks + 0}"/>

<c:set var="beginPageNumber" value="1" />
<c:set var="endPageNumber" value="${numberOfPageLinks}" />

<c:if test="${currentPageNumber >=1 and  currentPageNumber <= numberOfPages}">
  <c:set var="result" value="${currentPageNumber div numberOfPageLinks}" />
  <c:set var="fraction" value="${fn:substringAfter(result, '.')}" />
  <c:set var="result" value="${fn:substringBefore(result, '.')}" />
  <c:if test="${fraction=='0'}">
    <c:set var="result" value="${result-1}" />
  </c:if>

  <c:set var="beginPageNumber" value="${(result * numberOfPageLinks) + 1}"/>
  <c:set var="endPageNumber" value="${(result * numberOfPageLinks) + numberOfPageLinks}"/>

  <c:if test="${endPageNumber > numberOfPages}">
    <c:set var="endPageNumber" value="${numberOfPages}" />
    <c:set var="tempBeginPageNumber" value="${endPageNumber - numberOfPageLinks + 1}" />
    <c:if test="${tempBeginPageNumber > 0}">
      <c:set var="beginPageNumber" value="${tempBeginPageNumber}" />
    </c:if>
  </c:if>
</c:if>

<c:set var="beginPageNumber" value="${beginPageNumber}" scope="request" />
<c:set var="endPageNumber" value="${endPageNumber}" scope="request" />
