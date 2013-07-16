<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/controller/threads.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the threads view of forum widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%-- the general controller has already set a hasmap named 'forum' in the requestScope --%>
<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<%-- required attributes in the requestScope --%>
<jsp:useBean id="widgetContent" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>

<c:set target="${forum}" property="threadsSource" value="${fn:trim(widgetContent.fields.threadsSource.value)}" />

<c:set target="${forum}" property="threadTitleLength" value="${fn:trim(widgetContent.fields.titleLengthThreads.value)}" />
<c:if test="${empty forum.threadTitleLength}">
  <c:set target="${forum}" property="threadTitleLength" value="${100}" />
</c:if>

<c:set target="${forum}" property="threadBodyLength" value="${fn:trim(widgetContent.fields.bodyLength.value)}" />
<c:if test="${empty forum.threadBodyLength}">
  <c:set target="${forum}" property="threadBodyLength" value="${1000}" />
</c:if>

<c:set var="relatedForums" value="${widgetContent.relatedElements.forumRel.items}" />
<c:set var="forumIds" value="${fn:trim(widgetContent.fields.forumIds.value)}" />

<collection:createList id="forumMapsList" toScope="page"/>

<c:choose>
  <%-- if threadsSource='article', article context, article = forum article, then we will display the latest threads of the current forum article --%>
  <c:when test="${forum.threadsSource=='article' and
                  requestScope['com.escenic.context'] == 'art' and
                  article.articleTypeName=='forum'}">
    <collection:createMap id="forumMap" type="java.util.HashMap" toScope="page" />

    <c:set target="${forumMap}" property="forum" value="${article}" />

    <forum:latestThreads id="latestForumThreads" forumIds="${article.id}" max="${forum.maxItems}" />
    <c:set target="${forumMap}" property="latestThreads" value="${latestForumThreads}" />

    <collection:add collection="${forumMapsList}" value="${forumMap}"/>
    <c:remove var="latestForumThreads" scope="page" />
    <c:remove var="forumMap" scope="page" />
  </c:when>

  <%-- if threadsSource='allForums', we will display latest threads of all the forums in the current section --%>
  <c:when test="${forum.threadsSource=='allForums'}">
    <section:use uniqueName="${forum.sectionUniqueName}">
      <forum:groups id="sectionForums" sectionId="${section.id}"/>
    </section:use>

    <c:forEach var="sectionForum" items="${sectionForums}">
      <collection:createMap id="forumMap" type="java.util.HashMap" toScope="page" />

      <c:set target="${forumMap}" property="forum" value="${sectionForum}" />

      <forum:latestThreads id="latestForumThreads" forumIds="${sectionForum.id}" max="${forum.maxItems}"/>
      <c:set target="${forumMap}" property="latestThreads" value="${latestForumThreads}" />

      <collection:add collection="${forumMapsList}" value="${forumMap}"/>
      <c:remove var="latestForumThreads" scope="page" />
      <c:remove var="forumMap" scope="page" />
    </c:forEach>
  </c:when>

  <%-- if threadsSource='selectedForums', we will display latest threads of the selected forums either related with the widget or the forums of the given forumIDs--%>
  <c:when test="${forum.threadsSource=='selectedForums'}">
    <c:choose>
      <c:when test="${not empty relatedForums}">
        <c:forEach var="relatedForum" items="${relatedForums}">
          <collection:createMap id="forumMap" type="java.util.HashMap" toScope="page" />

          <c:set target="${forumMap}" property="forum" value="${relatedForum.content}" />

          <forum:latestThreads id="latestForumThreads" forumIds="${relatedForum.content.id}" max="${forum.maxItems}"/>
          <c:set target="${forumMap}" property="latestThreads" value="${latestForumThreads}" />

          <collection:add collection="${forumMapsList}" value="${forumMap}"/>
          <c:remove var="latestForumThreads" scope="page" />
          <c:remove var="forumMap" scope="page" />
        </c:forEach>
      </c:when>
      <c:when test="${not empty forumIds}">
        <c:forTokens var="forumId" items="${forumIds}" delims=",">
          <forum:group id="aForum" forumId="${fn:trim(forumId)}" />
          <c:if test="${not empty aForum}">
            <collection:createMap id="forumMap" type="java.util.HashMap" toScope="page" />

            <c:set target="${forumMap}" property="forum" value="${aForum}" />

            <forum:latestThreads id="latestForumThreads" forumIds="${aForum.id}" max="${forum.maxItems}"/>
            <c:set target="${forumMap}" property="latestThreads" value="${latestForumThreads}" />

            <collection:add collection="${forumMapsList}" value="${forumMap}"/>
            <c:remove var="latestForumThreads" scope="page" />
            <c:remove var="forumMap" scope="page" />
          </c:if>
          <c:remove var="aForum" scope="page" />
        </c:forTokens>
      </c:when>
    </c:choose>
  </c:when>
</c:choose>

<c:set target="${forum}" property="forumMaps" value="${forumMapsList}"/>