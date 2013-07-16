<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileVideo/src/main/webapp/template/widgets/mobileVideo/view/youtube.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/19 $
 * Version        : $Revision: #3 $
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

<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="mobileVideo" type="java.util.HashMap" scope="request" />
<c:set var="videoItems" value="${mobileVideo.items}" />

<c:if test="${not empty videoItems and fn:length(videoItems) > 0}">
  <dxf:div cssClass="${mobileVideo.wrapperStyleClass}" id="${mobileVideo.styleId}">
    <c:forEach var="videoContent" items="${videoItems}">
      <c:set var="youtubeVideoId" value="${videoContent.fields.code.value}"/>
      <c:set var="videoUrl" value="http://m.youtube.com/#/watch?xl=xl_blazer&v=${youtubeVideoId}"/>

      <dxf:div cssClass="youtubevideoImage">
        <dxf:a href="${videoUrl}">
          <dxf:img src="http://img.youtube.com/vi/${youtubeVideoId}/0.jpg" size="100"/>
        </dxf:a>
      </dxf:div>

      <dxf:div cssClass="youtubevideoPlay">
        <dxf:img size="-10" src="${requestScope.skinUrl}mobile/gfx/youtubeicon_graybg.png" alt=""/>
        <dxf:a href="${videoUrl}">
          <fmt:message key="mobileVideo.play.button.text"/>
        </dxf:a>
      </dxf:div>
    </c:forEach>
  </dxf:div>
</c:if>

<c:remove var="mobileVideo" scope="request"/>