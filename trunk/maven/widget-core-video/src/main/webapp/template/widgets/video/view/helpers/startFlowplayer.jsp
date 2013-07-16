<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/view/helpers/startFlowplayer.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the flowplayer view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request"/>


<c:set var="videoItems" value="${requestScope.videoList}"/>
<c:set var="playerUniqueId" value="${requestScope.playerUniqueId}"/>

<c:set var="autoPlay" value="${fn:trim(video.autoPlay)}"/>
<c:set var="autoBuffering" value="${fn:trim(video.autoBuffering)}"/>
<c:set var="norepeat" value="${fn:trim(video.repeat) == 'true' ? 'false' : 'true'}"/>
<c:set var="flowPlayerUrl" value="${requestScope.resourceUrl}flash/flowplayer-3.1.5.swf"/>
<c:set var="adStreamerUrl" value="${fn:trim(video.adStreamerUrl)}"/>
<c:set var="adType" value="${fn:trim(video.adType)}"/>
<c:set var="adTime" value="${fn:trim(video.adTime)}"/>
<c:set var="adStartTime" value="${fn:trim(video.adStartTime)}"/>
<c:set var="videoWidth" value="${video.width}"/>
<c:set var="videoHeight" value="${video.height}"/>
<c:set var="showFilmstrip" value="${(videoWidth>=240)and(fn:length(videoItems)>1)}"/>
<c:set var="uniqueId" value="videoWidget${playerUniqueId}"/>
<c:set var="filmstripId" value="filmstrip${playerUniqueId}"/>
<c:set var="browsableId" value="browsable${playerUniqueId}"/>
<c:set var="playlistId" value="playlist${playerUniqueId}"/>
<c:set var="nextClipId" value="nextClip${playerUniqueId}"/>
<c:set var="playerId" value="player${playerUniqueId}"/>
<c:set var="thumbnailWidth" value="${video.thumbnailWidth}"/>
<c:set var="thumbnailHeight" value="${video.thumbnailHeight}"/>
<fmt:message var="prevButtonTitle" key="video.widget.flowplayer.prevPage.button.title"/>
<fmt:message var="nextButtonTitle" key="video.widget.flowplayer.nextPage.button.title"/>
<c:set var="defaultPreviewImageUrl" value="${skinUrl}gfx/video/video-default-thumbnail.png"/>
<c:set var="divId" value="flowplayer-${playerUniqueId}"/>
<c:set var="videoScrollerId" value="flowplayer-scroller-${playerUniqueId}"/>
<c:set var="scrollableWidth" value="${videoWidth-110}"/>
<c:set var="maxScrollpaneItems"
       value="${fn:length(videoItems)<video.maxScrollpaneItems?fn:length(videoItems):video.maxScrollpaneItems}"/>
<c:set var="maxScrollpaneItems" value="${maxScrollpaneItems<3?3:maxScrollpaneItems}"/>
<c:set var="gap" value="${1+scrollableWidth/(maxScrollpaneItems*10)}"/>
<c:set var="scrollableItemWidth" value="${((scrollableWidth-(gap*(maxScrollpaneItems-1)))/maxScrollpaneItems)-10}"/>
<c:choose>
  <c:when test="${scrollableItemWidth>=160}">
    <c:set var="scrollableImgWidth"
           value="${(scrollableItemWidth/2)>100?((scrollableItemWidth-(scrollableItemWidth%2))/2):100}"/>
    <c:set var="showFilmstripText" value="true"/>
  </c:when>
  <c:otherwise>
    <c:set var="scrollableImgWidth" value="${scrollableItemWidth}"/>
    <c:set var="showFilmstripText" value="false"/>
  </c:otherwise>
</c:choose>

<c:set var="scrollableImgHeight" value="${(scrollableImgWidth*9)/16}"/>

<c:set var="scrollableHeight" value="${scrollableImgHeight+12}"/>

<c:set var="navMargine" value="${(scrollableHeight-30)/2}"/>

<div id="${filmstripId}" class="filmstrip"
     style="width:${videoWidth}px;height:${scrollableImgHeight+32}px;display:none;">
  <a class="prevPage browse left" style="margin-top:${navMargine}px;margin-bottom:${navMargine}px;">&nbsp;</a>

  <div class="scrollable" id="${browsableId}" style="width:${scrollableWidth+4}px;height:${scrollableHeight}px;">
    <div class="items" id="${playlistId}">
      <c:forEach var="videoContent" items="${videoItems}" varStatus="status">
        <c:if test="${videoContent.articleTypeName == 'simpleVideo' and (fn:endsWith(fn:toLowerCase(videoContent.fields.binary.value.href) ,'.mp4' )
                          or fn:endsWith(fn:toLowerCase(videoContent.fields.binary.value.href) ,'.flv')) }">
          <c:set var="videoUrl" value="${videoContent.fields.binary.value.href}"/>
        </c:if>

        <c:choose>
          <c:when test="${not empty fn:trim(videoContent.fields.caption)}">
            <c:set var="videoCaption" value="${fn:trim(videoContent.fields.caption)}"/>
          </c:when>
          <c:otherwise>
            <c:set var="videoCaption" value="${fn:trim(videoContent.title)}"/>
          </c:otherwise>
        </c:choose>
        <wf-core:getCurtailedText var="videoCaptionCurtailed" inputText="${videoCaption}"
                                  maxLength="${video.maxTitleLength}"/>
        <c:set var="videoDesc" value="${fn:trim(videoContent.fields.body.value)}"/>
        <wf-core:getCurtailedText var="videoDescCurtailed" inputText="${videoDesc}"
                                  maxLength="${video.maxBodyLength}"/>
        <wf-core:getImageRepresentation var="filmstripImageVersion" prefferedWidth="${scrollableImgWidth}"/>
        <wf-core:getVideoPreviewImageUrl var="previewImageUrl"
                                         articleId="${videoContent.id}"
                                         relationTypeName="previewRel"
                                         imageVersion="${imageVersion}"/>
        <c:remove var="filmstripImageVersion" scope="request"/>

        <c:if test="${empty previewImageUrl}">
          <c:set var="previewImageUrl" value="${defaultPreviewImageUrl}" scope="request"/>
        </c:if>

        <div id="index${uniqueId}${status.count-1}" onclick="clickedOnPlayList(${status.count-1},'${uniqueId}');"
             style="width:${scrollableItemWidth}px;height:${scrollableImgHeight}px;position:relative;margin-right:${gap}px">

          <c:forEach items="${videoContent.relatedElements.preRollAdsRel.items}" var="preRollAd">
            <c:if test="${preRollAd.content.articleTypeName == 'simpleVideo'}">
              <a class="preAd" href="${preRollAd.content.fields.binary.value.href}" style="display:none;">&nbsp;</a>
            </c:if>
          </c:forEach>

          <a class="mainVideo" href="${videoUrl}" style="display:none;">&nbsp;</a>

          <c:forEach items="${videoContent.relatedElements.postRollAdsRel.items}" var="postRollAd">
            <c:if test="${postRollAd.content.articleTypeName == 'simpleVideo'}">
              <a class="postAd" href="${postRollAd.content.fields.binary.value.href}" style="display:none;">
                &nbsp;</a>
              <c:set var="videoUrl" value="${postRollAd.content.fields.binary.value.href}"/>
            </c:if>
          </c:forEach>

          <img src="${previewImageUrl}" width="${scrollableImgWidth+6}px" height="${scrollableImgHeight+6}px" alt=""
               style="position:absolute;top:2px;left:2px;"/>
          <c:if test="${showFilmstripText}">
            <div
                style="overflow:hidden;position:absolute;top:2px;left:${scrollableImgWidth+12}px;width:${scrollableItemWidth-scrollableImgWidth-6}px;height:${scrollableImgHeight+6}px;margin:0;padding:0;background-color:transparent;">
              <strong style="height:16px;overflow:hidden;">${videoCaptionCurtailed}</strong>

              <p style="height:14px;overflow:hidden;">
                <c:choose>
                  <c:when test="${empty videoDescCurtailed}">
                    &nbsp;
                  </c:when>
                  <c:otherwise>
                    ${videoDescCurtailed}
                  </c:otherwise>
                </c:choose>
              </p>

              <p class="link" style="height:14px;overflow:hidden;">Play video</p>
            </div>
          </c:if>
        </div>
        <c:remove var="videoDescCurtailed" scope="request"/>
        <c:remove var="videoCaptionCurtailed" scope="request"/>
        <c:remove var="previewImageUrl" scope="request"/>
      </c:forEach>
    </div>
  </div>
  <c:set var="browser_right_style"
         value="margin-top:${navMargine}px;margin-bottom:${navMargine}px;${(fn:length(videoItems)>maxScrollpaneItems)?'':'display:none;'}"/>
  <a class="nextPage browse right" style="${browser_right_style}">&nbsp;</a>

  <div class="navi">&nbsp;</div>
</div>
<%-- container for next video clip--%>
<c:if test="${showFilmstrip}">
  <div class="nextClip" id="${nextClipId}" style="width:${scrollableItemWidth}px;height:${scrollableImgHeight}px;">
    &nbsp;</div>
</c:if>
<%-- container for video --%>
<div style="background-color:#272727;display:block;width:${videoWidth}px;height:${videoHeight}px;" class="player"
     id="${playerId}"></div>
<script type="text/javascript" src="${resourceUrl}js/flowplayer-util.js"></script>
<script type="text/javascript">
  // <![CDATA[
  function getGegeralConfig${uniqueId}() {
    var configObject = new Object();
    configObject.autoPlay = ${autoPlay};
    configObject.showFilmstrip = ${showFilmstrip};
    configObject.nextClipPopupTime = ${video.nextClipPopupTime};
    configObject.adStartTime = ${adStartTime};
    configObject.flowPlayerUrl = "${flowPlayerUrl}";
    configObject.divId = "${playerId}";
    configObject.adSource = "${video.adSource}";
    configObject.adType = "${adType}";
    configObject.filmstripId = "#${filmstripId}";
    configObject.nextClipId = "#${nextClipId}";
    configObject.nextClipIdNotHashed = "${nextClipId}";
    configObject.perFilmStripId = "#index${uniqueId}";
    configObject.perFilmStripIdNotHashed = "index${uniqueId}";
    configObject.browsableId = "#${browsableId}";
    configObject.adStreamerUrl = "${adStreamerUrl}";
    configObject.maxScrollpaneItems = ${maxScrollpaneItems};
    configObject.numberOfItems = ${fn:length(videoItems)};
    configObject.uniqueId = "${uniqueId}";
    configObject.flowplayerScrollableApi = flowplayerScrollableApi${uniqueId};
    configObject.isShowing = false;
    configObject.show = function() {
      if (configObject.showFilmstrip) {
        $(configObject.filmstripId).animate({ height: 'show', opacity: 'show' }, 'slow', function() {
          configObject.isShowing = true;
        });
      }
    };
    configObject.hide = function() {
      if (configObject.showFilmstrip) {
        $(configObject.filmstripId).animate({ height: 'hide', opacity: 'hide' }, 'slow', function() {
          configObject.isShowing = false;
        });
      }
    };
    return configObject;
  }
  var flowplayerScrollableApi${uniqueId} = null;
  $(function() {
    var object = getGegeralConfig${uniqueId}();
    if (object.showFilmstrip) {
      $(object.filmstripId).show();
      $(object.nextClipId).show();
    }
    flowplayerScrollableApi${uniqueId} = $(object.browsableId).scrollable({size: object.maxScrollpaneItems}).navigator({api:true});
    object.flowplayerScrollableApi = flowplayerScrollableApi${uniqueId};
    object.listIndex = 0;
    createPlayList(object);
  });
  // ]]>
</script>

