<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/helpers/videoLinks.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related videos view of the relatedContents widget as hyperlinks --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedVideos" value="${relatedContents.videos}" />

<ul>
  <c:forEach var="relatedVideo" items="${relatedVideos}" varStatus="status">
    <li <c:if test="${status.first}">class="first"</c:if> >
      <c:choose>
        <c:when test="${relatedVideo.content.articleTypeName=='youtubeVideo'}">
          <wf-core:getYouTubeVideoUrl var="videoUrl" videoCode="${fn:trim(relatedVideo.content.fields.code)}" embeddedUrl="false" />

          <a href="${videoUrl}" onclick="return openLink(this.href,'_blank')" class="${relatedVideo.fields.title.options.inpageClasses}">
            <c:out value="${relatedVideo.fields.title}" escapeXml="true" />
          </a>
          (<fmt:message key="relatedContents.widget.videos.youTube.type" />)

          <c:remove var="videoUrl" scope="request" />
        </c:when>
        <c:when test="${relatedVideo.content.articleTypeName=='simpleVideo'}">

          <a href="${relatedVideo.content.fields.binary.value.href}" onclick="return openLink(this.href,'_blank')">
            <c:out value="${relatedVideo.fields.title}" escapeXml="true"/>
          </a>
          (<c:out value="${relatedVideo.content.fields.binary.value['mime-type']}"/>)
          
        </c:when>
      </c:choose>
    </li>
  </c:forEach>
</ul>