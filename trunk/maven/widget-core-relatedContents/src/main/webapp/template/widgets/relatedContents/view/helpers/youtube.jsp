<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/helpers/youtube.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to play youTube video in the related videos view of relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="videoContent" value="${relatedContents.currentVideo}" />
<c:set var="videoWidth" value="${relatedContents.videoWidth}" />
<c:set var="videoHeight" value="${relatedContents.videoHeight}" />

<wf-core:getYouTubeVideoUrl var="videoUrl" videoCode="${fn:trim(videoContent.fields.code)}" embeddedUrl="true" /> 

<c:if test="${not empty videoUrl}">
  <div class="${videoContent.articleTypeName}">
    <object width="${videoWidth}" height="${videoHeight}">
      <param name="movie" value="${videoUrl}" />
      <param name="allowFullScreen" value="true" />
      <param name="allowscriptaccess" value="always" />
      <embed src="${videoUrl}"
             type="application/x-shockwave-flash"
             allowscriptaccess="always"
             allowfullscreen="true"
             width="${videoWidth}"
             height="${videoHeight}"></embed>
    </object>
  </div>
</c:if>

<c:remove var="videoUrl" scope="request" />

