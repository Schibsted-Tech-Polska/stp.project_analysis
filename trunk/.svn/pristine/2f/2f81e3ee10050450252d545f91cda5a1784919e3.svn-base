<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/slideshows.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the simple view list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="list" type="java.util.Map" scope="request"/>

<div class="${list.wrapperStyleClass} ${list.inpageDnDAreaClass}" <c:if test="${not empty list['styleId']}">id="${list['styleId']}"</c:if>>
  <!-- show the header conditionally -->
  <c:if test="${not empty list['slideshowList']}">
    <c:if test="${requestScope['tabbingEnabled']!='true'}">
      <div class="header">
        <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <div class="content">
      <c:forEach var="slideshowMap" items="${list.slideshowList}">
        <c:set var="slideshow" value="${slideshowMap}" scope="request"/>

        <div class="slideshowArticle ${slideshowMap.inpageDnDSummaryClass}">
          <c:if test="${list.showTitle == 'true'}">
            <h3 class="title"><c:out value="${slideshowMap.title}" escapeXml="true"/> </h3>
          </c:if>

          <div class="slideshow">
            <c:choose>
              <c:when test="${fn:length(slideshow.slideshowPictures) == 1}">
                <jsp:include page="helpers/picture.jsp"/>
              </c:when>
              <c:otherwise>
                <jsp:include page="helpers/slideshow.jsp"/>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <c:remove var="slideshow" scope="request"/>
      </c:forEach>
    </div>
  </c:if>
</div>
