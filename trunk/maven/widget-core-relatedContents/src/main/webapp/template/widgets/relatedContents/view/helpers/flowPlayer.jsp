<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/helpers/flowPlayer.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to display flashVideo in the related videos view of relatedContents widget --%>
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
<c:set var="autoBuffering" value="true"/>

<wf-core:getVideoPreviewImageUrl var="previewImageUrl" articleId="${videoContent.id}" relationTypeName="previewRel" />
<c:set var="videoContainerId" value="widget${widgetContent.id}-video${videoContent.id}" />
<c:set var="flowPlayerUrl" value="${requestScope.resourceUrl}flash/flowplayer-3.1.5.swf" />

<div class="${videoContent.articleTypeName}">
  <div id="${videoContainerId}" style="width:${videoWidth}px; height:${videoHeight}px;"></div>

  <script type="text/javascript" src="${requestScope.resourceUrl}js/flowplayer-util.js"></script>
  <script type="text/javascript">
    // <![CDATA[
    $(function(){
      startPlayer('${videoContainerId}', '${videoUrl}', '${flowPlayerUrl}', '${autoPlay}','${repeat}', '${autoBuffering}');
    });
    // ]]>
  </script>
</div>





