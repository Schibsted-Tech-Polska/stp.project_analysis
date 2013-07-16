<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/controller/stories.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the related stories view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="beginIndex" value="${relatedContents.beginIndex}"/>
<c:set var="endIndex" value="${relatedContents.endIndex}"/>
<c:set var="showIntro" value="${fn:trim(widgetContent.fields.showIntroStories)}" />
<c:set var="maxCharacters" value="${fn:trim(widgetContent.fields.maxCharactersStories)}" />
<c:set var="dateline" value="${fn:trim(widgetContent.fields.dateline)}" />

<c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormat)}" />
<c:if test="${empty dateFormat}">
  <c:set var="dateFormat" value="MMM dd yyyy" />
</c:if>

<c:set var="storyRelItems" value="${article.relatedElements.storyRel.items}" />

<c:if test="${empty beginIndex or beginIndex >= fn:length(storyRelItems) or beginIndex > endIndex}">
  <c:set var="beginIndex" value="0" />
</c:if>

<c:if test="${empty endIndex or endIndex >= fn:length(storyRelItems)}">
  <c:set var="endIndex" value="${fn:length(storyRelItems) > 0 ? fn:length(storyRelItems)-1 : 0}" />
</c:if>

<collection:createList id="relatedStories" type="java.util.ArrayList" />

<c:forEach var="story" items="${storyRelItems}" begin="${beginIndex}" end="${endIndex}">
  <collection:add collection="${relatedStories}" value="${story}" />
</c:forEach>

<c:set target="${relatedContents}" property="stories" value="${relatedStories}"/>
<c:set target="${relatedContents}" property="showIntro" value="${showIntro}"/>
<c:set target="${relatedContents}" property="maxCharacters" value="${maxCharacters}"/>
<c:set target="${relatedContents}" property="dateline" value="${dateline}"/>
<c:set target="${relatedContents}" property="dateFormat" value="${dateFormat}"/>