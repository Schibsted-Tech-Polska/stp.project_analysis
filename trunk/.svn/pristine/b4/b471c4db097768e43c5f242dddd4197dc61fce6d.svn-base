<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/view/windowsMediaPlayer.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the windowsMediaPlayer view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request" />

<c:set var="videoWidth" value="${video.width}"/>
<c:set var="videoHeight" value="${video.height}"/>
<c:set var="autoPlay" value="${fn:trim(video.autoPlay)}" />
<c:set var="repeat" value="${fn:trim(video.repeat)}"/>
<c:set var="videoItems" value="${video.items}" />

<c:if test="${not empty videoItems}">
  <div class="${video.wrapperStyleClass}" <c:if test="${not empty video.styleId}">id="${video.styleId}"</c:if> >
    
    <c:set var="videoCounter" value="0" />
    <c:forEach var="videoContent" items="${videoItems}">
      <c:set var="videoUrl" value="${videoContent.fields.binary.value.href}" />
      <c:set var="wmpVideoStyleClass" value="${videoCounter=='0' ? 'wmpVideo topVideo' : 'wmpVideo'}" />
      <wf-core:getVideoPreviewImageUrl var="previewImageUrl" articleId="${videoContent.id}"
                                         relationTypeName="previewRel" />

      <div class="${wmpVideoStyleClass}" style="background:url(${previewImageUrl}) #000000 no-repeat 1px 1px;">
        <object class="mediaPlayer" width="${videoWidth}" height="${videoHeight}"
                classid='CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95'
                codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112"
                standby='Loading Microsoft Windows Media Player components...'
                type='application/x-oleobject'>


          <param name="fileName" value="${videoUrl}" />
          <param name="autostart" value="${autoPlay?'1':'0'}" />
          <param name="playcount" value="${repeat?'0':'1'}" />
          <param name='animationatStart' value='true' />
          <param name='transparentatStart' value='true' />
          <param name='showControls' value="true" />

          <!--[if !IE]>-->
          <object type="application/x-mplayer2" data="${videoUrl}"
                  class="mediaPlayer"
                  width="${videoWidth}" height="${videoHeight}">
            <param name="url" value="${videoUrl}" />
            <param name="autostart" value="${autoPlay?'1':'0'}" />
            <param name="playcount" value="${repeat?'0':'1'}" />
            <param name="controller" value="true" />
          </object>
          <!--<![endif]-->

        </object>
      </div>

      <c:set var="videoCounter" value="${videoCounter+1}" />
      <c:remove var="previewImageUrl" scope="request" />
    </c:forEach>
  </div>
</c:if>

<c:remove var="video" scope="request"/>