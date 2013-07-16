<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-ad/src/main/webapp/template/widgets/ad/controller/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>


<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--declare the map that will contain relevant field values --%>
<jsp:useBean id="ad" type="java.util.Map" scope="request"/>

<c:set target="${ad}" property="linkTitle" value="${fn:trim(widgetContent.fields.linkTitle_newsletter.value)}"/>
<c:set target="${ad}" property="url" value="${fn:trim(widgetContent.fields.url_newsletter.value)}"/>
<c:set target="${ad}" property="target" value="_${fn:trim(widgetContent.fields.target_newsletter.value)}"/>

<c:choose>
  <c:when test="${ad.format_newsletter eq 'fullBanner'}">
    <c:set target="${ad}" property="width_newsletter" value="468"/>
    <c:set target="${ad}" property="height_newsletter" value="60"/>
  </c:when>
  <c:when test="${ad.format_newsletter eq 'mediumRectangle'}">
    <c:set target="${ad}" property="width_newsletter" value="300"/>
    <c:set target="${ad}" property="height_newsletter" value="250"/>
  </c:when>
  <c:when test="${ad.format_newsletter eq 'skyscraper'}">
    <c:set target="${ad}" property="width_newsletter" value="120"/>
    <c:set target="${ad}" property="height_newsletter" value="600"/>
  </c:when>
  <c:when test="${ad.format_newsletter eq 'leaderboard'}">
    <c:set target="${ad}" property="width_newsletter" value="728"/>
    <c:set target="${ad}" property="height_newsletter" value="90"/>
  </c:when>
</c:choose>
