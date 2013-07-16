<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/controller/rssHeadline.jsp#1 $
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

<%-- put the relevant field values in the map--%>
<c:set target="${feed}" property="sourceUrls" value="${widgetContent.fields.sourceUrlsRssHeadline.value}"/>
<c:set target="${feed}" property="maxArticles" value="${fn:trim(widgetContent.fields.maxArticlesRssHeadline.value)}" />
<c:set target="${feed}" property="updateInterval" value="${fn:trim(widgetContent.fields.updateIntervalRssHeadline.value)}" />