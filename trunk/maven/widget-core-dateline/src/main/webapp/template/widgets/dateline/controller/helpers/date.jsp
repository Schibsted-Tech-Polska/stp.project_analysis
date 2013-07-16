<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/controller/helpers/date.jsp#1 $
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
  the purpose of this page is to display current date, published date or last modified date
  on the basis of the given parameter: dateType. While displaying date, this page formats the date
  according to the given parameters: dateTimeZone, dateLocale, dateFormat and displayTimeDifferecne
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>

<jsp:useBean id="dateLocale" type="java.lang.String" scope="request"/>
<jsp:useBean id="dateTimeZone" type="java.lang.String" scope="request"/>
<jsp:useBean id="dateType" type="java.lang.String" scope="request"/>
<jsp:useBean id="dateFormat" type="java.lang.String" scope="request"/>
<jsp:useBean id="displayTimeDifferecne" type="java.lang.String" scope="request"/>

<%-- set the locale for this page to dateLocale if it's not empty --%>
<c:if test="${not empty dateLocale}">
  <fmt:setLocale value="${dateLocale}" scope="page"/>
</c:if>

<%-- set the timezone for this page to dateTimeZone if it's not empty --%>
<c:if test="${not empty dateTimeZone}">
  <fmt:setTimeZone value="${dateTimeZone}" scope="page"/>
</c:if>

<%-- isArticleContext is a boolean, it's true only when we are in article context --%>
<c:set var="isArticleContext" value="${requestScope['com.escenic.context']=='art'}" />
<%-- todaysDate is the current date --%>
<jsp:useBean id="todaysDate" class="java.util.Date"/>

<%-- now, check what type of date should be displayed for this date entry --%>
<c:choose>
  <c:when test="${not empty dateType and dateType == 'modified'}">
    <%-- we have to display the last modified date of article / section --%>
    <%--<c:set var="dateInstance" value="${isArticleContext ? article.lastModifiedDateAsDate : section.lastModified}" />--%>
    <c:set var="dateInstance" value="${isArticleContext ? article.lastModifiedDateAsDate : pool.changedDate}" />
  </c:when>
  <c:when test="${not empty dateType and dateType == 'published'}">
    <%-- we have to display the published date of article / section --%>
    <c:set var="dateInstance" value="${isArticleContext ? article.publishedDateAsDate : section.publishDate}" />
    <%--<c:set var="dateInstance" value="${isArticleContext ? article.publishedDateAsDate : pool.activateDate}" />--%>
  </c:when>
  <c:otherwise>
    <%-- dateType is neither modified nor published, so current date will be displayed --%>
    <c:set var="dateInstance" value="${todaysDate}" />
  </c:otherwise>
</c:choose>

<%--
  if displayTimeDifferecne is false, then the dateInstance will be displayed in the given dateFormat pattern
  But if displayTimeDifferecne is true, then call dateDifference.jsp to render the time difference between dateInstance and todaysDate
--%>
<c:if test="${not empty dateInstance}">
  <c:choose>
    <c:when test="${displayTimeDifferecne == 'false'}">
      <fmt:formatDate value="${dateInstance}" pattern="${dateFormat}" />
    </c:when>
    <c:otherwise>
      <c:set var="comparingDate" value="${dateInstance}" scope="request"/>
      <c:set var="todaysDate" value="${todaysDate}" scope="request"/>
      <jsp:include page="dateDifference.jsp"/>
      <c:remove var="comparingDate" scope="request"/>
      <c:remove var="todaysDate" scope="request"/>
    </c:otherwise>
  </c:choose>
</c:if>