<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/helpers/wmp.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to play video in windows media player in the related videos view of relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="videoContent" value="${relatedContents.currentVideo}" />
<c:set var="videoWidth" value="${relatedContents.videoWidth}" />
<c:set var="videoHeight" value="${relatedContents.videoHeight}" />

<c:set var="videoUrl" value="${videoContent.fields.binary.value.href}" />

<c:set var="autoPlay" value="false"/>
<c:set var="repeat" value="false"/>

<wf-core:getVideoPreviewImageUrl var="previewImageUrl" articleId="${videoContent.id}" relationTypeName="previewRel" />

<c:set var="videoContainerId" value="widget${widgetContent.id}-video${videoContent.id}" />

<div id="${videoContainerId}" class="${videoContent.articleTypeName}"
     style="background:url(${previewImageUrl}) #000000 no-repeat 1px 1px;">
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
