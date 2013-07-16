<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/videos.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related videos view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedVideos" value="${relatedContents.videos}" />

<c:if test="${not empty relatedVideos}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedVideos<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if>>
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>    

    <c:set var="relatedVideosList" value="${relatedVideos}" scope="request" />
    <c:choose>
      <c:when test="${relatedContents.displayStyle=='link'}">
        <jsp:include page="helpers/videoLinks.jsp" />
      </c:when>
      <c:otherwise>
        <jsp:include page="helpers/videoPlayer.jsp" />
      </c:otherwise>
    </c:choose>
    <c:remove var="relatedVideosList" scope="request" />
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>