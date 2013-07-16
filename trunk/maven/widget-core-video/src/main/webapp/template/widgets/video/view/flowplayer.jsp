<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-video/src/main/webapp/template/widgets/video/view/flowplayer.jsp#1 $
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
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="video" type="java.util.HashMap" scope="request"/>

<c:if test="${fn:length(video.items)>0}">
  <div class="${video.wrapperStyleClass}"
       <c:if test="${not empty video.styleId}">id="${video.styleId}"</c:if> >
    <c:choose>
      <c:when test="${video.flowplayerStyle=='single'}">
        <c:set var="playerUniqueId" value="${widgetContent.id}" scope="request"/>
        <c:set var="videoList" value="${video.items}" scope="request"/>
        <div class="videoFlow">
          <jsp:include page="helpers/startFlowplayer.jsp"/>
        </div>
        <c:remove var="videoList" scope="request"/>
        <c:remove var="playerUniqueId" scope="request"/>
      </c:when>
      <c:otherwise>
        <c:forEach var="videoItem" items="${video.items}" varStatus="status">
          <c:set var="playerUniqueId" value="${widgetContent.id}_${status.count}" scope="request"/>
          <collection:createList id="videoList" type="java.util.ArrayList" toScope="request"/>
          <collection:add collection="${videoList}" value="${videoItem}"/>
          <div class="${status.first?'flowPlayer-single topVideo':'flowPlayer-single'}">
            <jsp:include page="helpers/startFlowplayer.jsp"/>
          </div>
          <c:remove var="playerUniqueId" scope="request"/>
          <c:remove var="videoList" scope="request"/>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>
</c:if>
