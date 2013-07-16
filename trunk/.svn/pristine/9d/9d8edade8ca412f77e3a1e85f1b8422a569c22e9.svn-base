<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/controller/youtube.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the youtube view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>


<%-- the general controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request" />

<c:set target="${video}" property="contentTypes" value="youtubeVideo"/>

<c:set var="contentTypes" value="${video.contentTypes}" />
<c:set var="beginIndex" value="${video.beginIndex}" />
<c:set var="endIndex" value="${video.endIndex}" />

<c:choose>
  <c:when test="${video.source=='desked' and not empty video.groupName}">
    <c:choose>
      <c:when test="${video.sectionUniqueName == section.uniqueName}">
        <wf-core:getGroupByName var="targetGroup" groupName="${video.groupName}" areaName="${requestScope.contentAreaName}" />
      </c:when>
      <c:otherwise>
        <section:use uniqueName="${video.sectionUniqueName}">
          <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
        </section:use>

        <wf-core:getGroupByName var="targetGroup" groupName="${video.groupName}" areaName="${requestScope.contentAreaName}" pool="${targetSectionPool}"/>
        <c:remove var="targetSectionPool" scope="request"/>
      </c:otherwise>
    </c:choose>

    <wf-core:getVideosInGroup var="videoContents" group="${targetGroup}" contentTypes="${contentTypes}"
                                beginIndex="${beginIndex}" endIndex="${endIndex}"/>

    <c:remove var="targetGroup" scope="request"/>
  </c:when>

  <c:when test="${video.source=='latest'}">
    <c:set var="maxLatestVideos" value="${video.maxLatestVideos}" />

    <section:use uniqueName="${video.sectionUniqueName}">
      <article:list id="videosList"
                    sectionUniqueName="${video.sectionUniqueName}"
                    includeSubSections="${video.includeSubsections}"
                    includeArticleTypes="${contentTypes}"
                    max="${maxLatestVideos}"
                    sort="-publishDate"
                    from="${requestScope.articleListDateString}"/>
    </section:use>

    <c:set var="videoContents" value="${videosList}" scope="request" />
  </c:when>

  <c:when test="${video.source=='related' and
                  requestScope['com.escenic.context'] == 'art' and
                  not empty article.relatedElements.videoRel.items}">

    <c:set var="videoRelItems" value="${article.relatedElements.videoRel.items}" />

    <c:if test="${empty beginIndex or beginIndex >= fn:length(videoRelItems) or beginIndex > endIndex}">
      <c:set var="beginIndex" value="0" />
    </c:if>

    <c:if test="${empty endIndex or endIndex >= fn:length(videoRelItems)}">
      <c:set var="endIndex" value="${fn:length(videoRelItems)-1}"/>
    </c:if>
    
    <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
    <c:forEach var="videoRelItem" items="${videoRelItems}" begin="${beginIndex+0}" end="${endIndex+0}">
      <c:if test="${fn:containsIgnoreCase(contentTypes, videoRelItem.content.articleTypeName)}">
        <collection:add collection="${videoContents}" value="${videoRelItem.content}" />
      </c:if>
    </c:forEach>

  </c:when>
  <c:when test="${requestScope['com.escenic.context'] == 'art' and article.articleTypeName=='youtubeVideo' and video.source=='article'}" >
      <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
      <collection:add collection="${videoContents}" value="${article}" />
      <c:set target="${video}" property="beginIndex" value="0"/>
      <c:set target="${video}" property="endIndex" value="0"/>
  </c:when>
</c:choose>

<c:set var="videoWidth" value="${requestScope.elementwidth}"/>
<c:set var="videoHeight" value="${(videoWidth+0) * 0.7}" />
<c:if test="${fn:contains(videoHeight, '.')}">
  <c:set var="videoHeight" value="${fn:substringBefore(videoHeight, '.')}" />
</c:if>
<c:set target="${video}" property="width" value="${videoWidth}"/>
<c:set target="${video}" property="height" value="${videoHeight}"/>

<c:set target="${video}" property="items" value="${videoContents}"/>
<c:remove var="videoContents" scope="request" />
