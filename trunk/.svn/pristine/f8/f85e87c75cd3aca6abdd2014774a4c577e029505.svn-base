<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/controller/flowplayer.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the flowplayer view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- the general controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request"/>

<c:set target="${video}" property="contentTypes" value="simpleVideo"/>

<c:set var="contentTypes" value="${video.contentTypes}"/>
<c:set var="beginIndex" value="${video.beginIndex}"/>
<c:set var="endIndex" value="${video.endIndex}"/>

<c:set target="${video}" property="flowplayerStyle" value="${fn:trim(widgetContent.fields.flowplayerStyle)}"/>
<c:set target="${video}" property="autoPlay" value="${fn:trim(widgetContent.fields.autoPlayFlowplayer)}"/>
<c:set target="${video}" property="autoBuffering" value="${fn:trim(widgetContent.fields.autoBufferingFlowplayer)}"/>
<c:set target="${video}" property="repeat" value="${fn:trim(widgetContent.fields.repeatFlowplayer)}"/>
<c:set target="${video}" property="nextClipPopupTime"
       value="${1000*fn:trim(widgetContent.fields.nextClipPopupTimeFlowplayer.value)}"/>
<c:set target="${video}" property="maxTitleLength"
       value="${fn:trim(widgetContent.fields.maxTitleLengthFlowplayer.value)}"/>
<c:set target="${video}" property="maxBodyLength"
       value="${fn:trim(widgetContent.fields.maxBodyLengthFlowplayer.value)}"/>

<c:set target="${video}" property="adStreamerUrl" value="${skinUrl}gfx/video/OpenAdStreamer.swf"/>
<c:set target="${video}" property="adSource" value="${fn:trim(widgetContent.fields.adSourceFlowplayer)}"/>
<c:set target="${video}" property="adType" value="${fn:trim(widgetContent.fields.flowplayerAd)}-roll"/>

<c:set target="${video}" property="adTime">
  <c:set var="hh" value="${fn:trim(widgetContent.fields.flowplayerAdTime.value.hh)}"/>
  <c:set var="mm" value="${fn:trim(widgetContent.fields.flowplayerAdTime.value.mm)}"/>
  <c:set var="ss" value="${fn:trim(widgetContent.fields.flowplayerAdTime.value.ss)}"/>
  ${fn:length(hh) eq 1 ? '0':''}${hh}:${fn:length(mm) eq 1 ? '0':''}${mm}:${fn:length(ss) eq 1 ? '0':''}${ss}
</c:set>

<c:set target="${video}" property="adStartTime" value="${(3600000*((empty fn:trim(widgetContent.fields.flowplayerAdTime.value.hh))?0:fn:trim(widgetContent.fields.flowplayerAdTime.value.hh)))
         +(60000*((empty fn:trim(widgetContent.fields.flowplayerAdTime.value.mm))?0:fn:trim(widgetContent.fields.flowplayerAdTime.value.mm)))
         +(1000*((empty fn:trim(widgetContent.fields.flowplayerAdTime.value.ss))?0:fn:trim(widgetContent.fields.flowplayerAdTime.value.ss)))}"/>

<c:set var="maxScrollpaneItems" value="${fn:trim(widgetContent.fields.maxScrollpaneItemsFlowplayer)}"/>
<c:if test="${empty maxScrollpaneItems}">
  <c:set var="maxScrollpaneItems" value="5"/>
</c:if>
<c:set target="${video}" property="maxScrollpaneItems" value="${maxScrollpaneItems}"/>

<c:choose>
  <c:when test="${video.source=='desked' and not empty video.groupName}">
    <c:choose>
      <c:when test="${video.sectionUniqueName == section.uniqueName}">
        <wf-core:getGroupByName var="targetGroup" groupName="${video.groupName}"
                                areaName="${requestScope.contentAreaName}"/>
      </c:when>
      <c:otherwise>
        <section:use uniqueName="${video.sectionUniqueName}">
          <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
        </section:use>

        <wf-core:getGroupByName var="targetGroup" groupName="${video.groupName}"
                                areaName="${requestScope.contentAreaName}" pool="${targetSectionPool}"/>
        <c:remove var="targetSectionPool" scope="request"/>
      </c:otherwise>
    </c:choose>

    <wf-core:getVideosInGroup var="videoContents" group="${targetGroup}" contentTypes="${contentTypes}"
                              beginIndex="${beginIndex}" endIndex="${endIndex}" fileExtensions="flv, mp4"/>

    <c:remove var="targetGroup" scope="request"/>
  </c:when>

  <c:when test="${video.source=='latest'}">
    <c:set var="maxLatestVideos" value="${video.maxLatestVideos}"/>

    <section:use uniqueName="${video.sectionUniqueName}">
      <article:list id="videosList"
                    sectionUniqueName="${video.sectionUniqueName}"
                    includeSubSections="${video.includeSubsections}"
                    includeArticleTypes="${contentTypes}"
                    sort="-publishDate"
                    max="${2 * maxLatestVideos}"
                    from="${requestScope.articleListDateString}"/>
    </section:use>

    <c:set var="latestVideoCounter" value="0"/>
    <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
    <c:forEach var="videoItem" items="${videosList}">
      <c:if test="${(latestVideoCounter+0) < (maxLatestVideos+0)}">
        <c:set var="videoUrl" value="${videoItem.fields.binary.value.href}"/>
        <c:if
            test="${(fn:endsWith(fn:toLowerCase(videoUrl), '.flv') or fn:endsWith(fn:toLowerCase(videoUrl), '.mp4'))}">
          <collection:add collection="${videoContents}" value="${videoItem}"/>
          <c:set var="latestVideoCounter" value="${latestVideoCounter+1}"/>
        </c:if>
      </c:if>
    </c:forEach>
  </c:when>

  <c:when test="${video.source=='related' and
                  requestScope['com.escenic.context'] == 'art' and
                  not empty article.relatedElements.videoRel.items}">

    <c:set var="videoRelItems" value="${article.relatedElements.videoRel.items}"/>

    <c:if test="${empty beginIndex or beginIndex >= fn:length(videoRelItems) or beginIndex > endIndex}">
      <c:set var="beginIndex" value="0"/>
    </c:if>

    <c:if test="${empty endIndex or endIndex >= fn:length(videoRelItems)}">
      <c:set var="endIndex" value="${fn:length(videoRelItems)-1}"/>
    </c:if>

    <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
    <c:forEach var="videoRelItem" items="${videoRelItems}" begin="${beginIndex+0}" end="${endIndex+0}">
      <c:if test="${fn:containsIgnoreCase(contentTypes, videoRelItem.content.articleTypeName)}">
        <c:set var="videoUrl" value="${videoRelItem.content.fields.binary.value.href}"/>
        <c:if test="${fn:endsWith(fn:toLowerCase(videoUrl), '.flv') or fn:endsWith(fn:toLowerCase(videoUrl), '.mp4')}">
          <collection:add collection="${videoContents}" value="${videoRelItem.content}"/>
        </c:if>
      </c:if>
    </c:forEach>

  </c:when>
  <c:when
      test="${requestScope['com.escenic.context'] == 'art' and article.articleTypeName=='simpleVideo' and video.source=='article'}">
    <c:set var="videoUrl" value="${article.fields.binary.value.href}"/>
    <c:if test="${fn:endsWith(fn:toLowerCase(videoUrl), '.flv') or fn:endsWith(fn:toLowerCase(videoUrl), '.mp4')}">
      <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
      <collection:add collection="${videoContents}" value="${article}"/>
      <c:set target="${video}" property="autoPlay" value="${(fn:trim(param.playVideo)=='true')?'true':'false'}"/>

      <c:if test="${not empty article.relatedElements.videoRel.items}">
        <c:set var="videoRelItems" value="${article.relatedElements.videoRel.items}"/>
        <c:if test="${empty beginIndex or beginIndex >= fn:length(videoRelItems) or beginIndex > endIndex}">
          <c:set var="beginIndex" value="0"/>
        </c:if>

        <c:if test="${empty endIndex or endIndex >= fn:length(videoRelItems)}">
          <c:set var="endIndex" value="${fn:length(videoRelItems)}"/>
        </c:if>

        <c:forEach var="videoRelItem" items="${videoRelItems}" begin="${beginIndex+0}" end="${endIndex-1}">
          <c:if test="${fn:containsIgnoreCase(contentTypes, videoRelItem.content.articleTypeName)}">
            <c:set var="videoUrl" value="${videoRelItem.content.fields.binary.value.href}"/>
            <c:if
                test="${fn:endsWith(fn:toLowerCase(videoUrl), '.flv') or fn:endsWith(fn:toLowerCase(videoUrl), '.mp4')}">
              <collection:add collection="${videoContents}" value="${videoRelItem.content}"/>
            </c:if>
          </c:if>
        </c:forEach>
      </c:if>

    </c:if>
  </c:when>
</c:choose>

<%--<c:if test="${fn:length(videoContents) eq 1}">--%>
<%--<c:set target="${video}" property="flowplayerStyle" value="multiple"/>--%>
<%--</c:if>--%>

<c:if test="${video.adSource == 'internal'}">
  <c:set target="${video}" property="adType" value="none-roll"/>
</c:if>

<c:set var="videoWidth" value="${requestScope.elementwidth}"/>
<c:set var="videoHeight">
  <fmt:formatNumber value="${0.5625 * videoWidth}" pattern="###" maxFractionDigits="0" type="number"/>
</c:set>
<c:set target="${video}" property="width" value="${videoWidth}"/>
<c:set target="${video}" property="height" value="${videoHeight}"/>

<c:set target="${video}" property="items" value="${videoContents}"/>
<c:remove var="videoContents" scope="request"/>

<c:set var="thumbnailWidth" value="${(videoWidth-40) / (video.maxScrollpaneItems+0)}"/>
<c:set var="thumbnailWidth" value="${thumbnailWidth - 12}"/>
<c:if test="${fn:contains(thumbnailWidth, '.')}">
  <c:set var="thumbnailWidth" value="${fn:substringBefore(thumbnailWidth, '.')}"/>
</c:if>
<c:set target="${video}" property="thumbnailWidth" value="${thumbnailWidth}"/>

<c:set var="thumbnailHeight" value="${thumbnailWidth * 0.7}"/>
<c:if test="${fn:contains(thumbnailHeight, '.')}">
  <c:set var="thumbnailHeight" value="${fn:substringBefore(thumbnailHeight, '.')}"/>
</c:if>
<c:set target="${video}" property="thumbnailHeight" value="${thumbnailHeight}"/>
