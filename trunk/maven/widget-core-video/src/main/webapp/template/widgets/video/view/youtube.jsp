<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/view/youtube.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the youTube view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request" />

<c:set var="videoWidth" value="${video.width}"/>
<c:set var="videoHeight" value="${video.height}"/>
<c:set var="videoItems" value="${video.items}" />

<c:if test="${not empty videoItems}">
  <div class="${video.wrapperStyleClass}" <c:if test="${not empty video.styleId}">id="${video.styleId}"</c:if> >
    
    <c:set var="videoCounter" value="0" />
    <c:forEach var="videoContent" items="${videoItems}">
      <wf-core:getYouTubeVideoUrl var="videoUrl" videoCode="${fn:trim(videoContent.fields.code)}" embeddedUrl="true" />

      <c:if test="${not empty videoUrl}">
        <c:set var="youtubeVideoStyleClass" value="${videoCounter=='0' ? 'youtubeVideo topVideo' : 'youtubeVideo'}" />

        <div class="${youtubeVideoStyleClass}">

          <object width="${videoWidth}" height="${videoHeight}">
            <param name="movie" value="${videoUrl}" />
            <param name="allowFullScreen" value="true" />
            <param name="allowscriptaccess" value="always" />

            <embed src="${videoUrl}"
                   type="application/x-shockwave-flash"
                   allowscriptaccess="always"
                   allowfullscreen="true"
                   width="${videoWidth}"
                   wmode="transparent"
                   height="${videoHeight}"></embed>
          </object>
        </div>

        <c:set var="videoCounter" value="${videoCounter+1}" />
      </c:if>

      <c:remove var="videoUrl" scope="request" /> 
    </c:forEach>
  </div>
</c:if>

<c:remove var="video" scope="request"/>