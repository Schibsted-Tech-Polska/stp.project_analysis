<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/controller/rssFull.jsp#1 $
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

<%--declare the map that will contain view specific field values --%>
<jsp:useBean id="feed" type="java.util.Map" scope="request" />

<%--put the relevant field values in the map --%>
<c:set target="${feed}" property="sourceUrls" value="${widgetContent.fields.sourceUrlsRssFull.value}"/>
<c:set target="${feed}" property="maxArticles" value="${fn:trim(widgetContent.fields.maxArticlesRssFull.value)}" />
<c:set target="${feed}" property="updateInterval" value="${fn:trim(widgetContent.fields.updateIntervalRssFull.value)}" />
<c:set target="${feed}" property="showSummary" value="${widgetContent.fields.showSummary.value}" />
<c:set target="${feed}" property="maxCharactersInSummary" value="${fn:trim(widgetContent.fields.maxCharactersInSummary.value)}" />
<c:set target="${feed}" property="showImage" value="${widgetContent.fields.showImage.value}" />
<c:set target="${feed}" property="showAuthor" value="${widgetContent.fields.showAuthor.value}" />
<c:set target="${feed}" property="showSource" value="${widgetContent.fields.showSource.value}" />
<c:set target="${feed}" property="showDate" value="${widgetContent.fields.showDateRssFull.value}" />
<c:set target="${feed}" property="imageWidth" value="48"/>
<c:set target="${feed}" property="imageHeight" value="48"/>

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormat.value)}"/>
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMM d, yyyy h:mm aaa"/>
</c:if>
<c:set target="${feed}" property="dateFormat" value="${dateFormat}"/>