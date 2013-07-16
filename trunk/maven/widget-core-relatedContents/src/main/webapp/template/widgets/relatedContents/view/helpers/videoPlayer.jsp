<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/helpers/videoPlayer.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related videos view of the relatedContents widget with video player --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedVideos" value="${relatedContents.videos}" />

<c:forEach var="relatedVideo" items="${relatedVideos}" varStatus="status">
  <c:set target="${relatedContents}" property="currentVideo" value="${relatedVideo.content}" />

  <c:choose>
    <c:when test="${relatedVideo.content.articleTypeName=='youtubeVideo'}">
      <jsp:include page="youtube.jsp" />
    </c:when>
    <c:when test="${relatedVideo.content.articleTypeName=='simpleVideo'}">
      <c:set var="videoUrl" value="${relatedVideo.content.fields.binary.value.href}" />
      <c:choose>
        <c:when test="${fn:endsWith(fn:toLowerCase(videoUrl), '.flv') or fn:endsWith(fn:toLowerCase(videoUrl), '.mp4')}">
          <jsp:include page="flowPlayer.jsp" />
        </c:when>
        <c:otherwise>
          <jsp:include page="wmp.jsp" />
        </c:otherwise>
      </c:choose>
    </c:when>
  </c:choose>
</c:forEach>