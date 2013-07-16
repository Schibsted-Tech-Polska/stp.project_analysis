<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getYouTubeVideoUrl.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="videoCode" required="true" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="embeddedUrl" required="true" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="videoCode" value="${fn:trim(videoCode)}" />

<c:choose>
  <c:when test="${embeddedUrl==false}">
    <c:choose>
      <c:when test="${fn:startsWith(videoCode, 'http://www.youtube.com/watch?v=')}">
        <c:set var="videoUrl" value="${videoCode}" />
      </c:when>
      <c:when test="${fn:startsWith(videoCode, '<object')}">
        <c:set var="embedVideoUrl" value="${fn:substringAfter(videoCode, '<embed src=\"')}" />
        <c:set var="embedVideoUrl" value="${fn:substringBefore(embedVideoUrl, '\"')}" />
        <c:set var="embedVideoUrl" value="${fn:substringBefore(embedVideoUrl, '&')}" />
        <c:set var="videoId" value="${fn:substringAfter(embedVideoUrl, 'http://www.youtube.com/v/')}" />
        <c:url var="videoUrl" value="http://www.youtube.com/watch">
          <c:param name="v" value="${videoId}" />
        </c:url>
        <c:remove var="embedVideoUrl" scope="page" />
        <c:remove var="videoId" scope="page" />
      </c:when>
      <c:otherwise>
        <c:url var="videoUrl" value="http://www.youtube.com/watch">
          <c:param name="v" value="${videoCode}" />
        </c:url>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:choose>
      <c:when test="${fn:startsWith(videoCode, 'http://www.youtube.com/watch?v=')}">
        <c:set var="videoId" value="${fn:substringAfter(videoCode, 'http://www.youtube.com/watch?v=')}" />
        <c:if test="${fn:contains(videoId, '&')}">
          <c:set var="videoId" value="${fn:substringBefore(videoId, '&')}" />
        </c:if>
        <c:set var="videoUrl" value="http://www.youtube.com/v/${videoId}&hl=en&fs=1&rel=1&border=0" />
        <c:remove var="videoId" scope="page" />
      </c:when>
      <c:when test="${fn:startsWith(videoCode, '<object')}">
        <c:set var="videoUrl" value="${fn:substringAfter(videoCode, '<embed src=\"')}" />
        <c:set var="videoUrl" value="${fn:substringBefore(videoUrl, '\"')}" />
      </c:when>
      <c:otherwise>
        <c:set var="videoId" value="${videoCode}"/>
        <c:set var="videoUrl" value="http://www.youtube.com/v/${videoId}&hl=en&fs=1&rel=1&border=0" />
        <c:remove var="videoId" scope="page" />
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>

<%
  request.setAttribute(var, jspContext.getAttribute("videoUrl"));
%>


