<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/videos.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the pictures view of list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<c:if test="${not empty list.videoMapList}">
  <div class="${list.wrapperStyleClass} ${list.inpageDnDAreaClass}" <c:if test="${not empty list.styleId}">id="${list.styleId}"</c:if>>

    <c:if test="${requestScope.tabbingEnabled!='true'}">
      <div class="header">
        <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <c:choose>
      <c:when test="${list.showPreviewImage}">
        <c:if test="${list.showCaption == 'true' and list.captionStyle == 'below'}">
          <c:set var="styleClassForTitle" value="title"/>
        </c:if>

        <c:if test="${list.showDescription=='true'}" >
          <c:set var="styleClassForDescription" value="description" />
        </c:if>
        <c:forEach var="videoMap" items="${list.videoMapList}">
          <div class="video ${videoMap.inpageDnDSummaryClass}">

            <c:if test="${list.showCaption == 'true' and list.captionStyle == 'above'}">
              <a class="title" href="${videoMap.articleUrl}">
                <p style="width:${list.previewImageWidth}px;" class="${videoMap.inpageTitleClass}"><c:out value="${videoMap.title}" escapeXml="true"/> </p>
              </a>
            </c:if>

            <c:if test="${list.showPreviewImage}">
              <div class="preview">
                <a href="${videoMap.articleUrl}">
                  <img src="${videoMap.previewImageUrl}" alt="${videoMap.title}" title="${videoMap.title}" width="${list.previewImageWidth}" height="${list.previewImageHeight}" />
                </a>
                <a href="${videoMap.articleUrl}">
                  <div class="play ${list.playButtonStyleName}">&nbsp;</div>
                </a>
              </div>
            </c:if>

            <!-- caption and description both should be inside a div so that its height can be specified -->
            <c:if test="${(list.showCaption == 'true' and list.captionStyle == 'below') or list.showDescription=='true'}">
              <div class="info ${styleClassForTitle} ${styleClassForDescription}" style="width:${list.previewImageWidth}px;">
                <c:if test="${list.showCaption == 'true' and list.captionStyle == 'below'}">
                  <a class="title" href="${videoMap.articleUrl}">
                    <p class="${videoMap.inpageTitleClass}"><c:out value="${videoMap.title}" escapeXml="true"/> </p>
                  </a>
                </c:if>
                <c:if test="${list.showDescription=='true' and not empty videoMap.description}">
                  <p class="description ${videoMap.inpageBodyClass}">
                    <c:out value="${videoMap.description}" escapeXml="true"/>
                  </p>
                </c:if>
              </div>
            </c:if>
          </div>
        </c:forEach>
      </c:when>

      <c:otherwise>
        <ul class="videos">
          <c:forEach var="videoMap" items="${list.videoMapList}">
            <li>
              <c:if test="${list.showCaption == 'true'}">
                <a  class="title" href="${videoMap.articleUrl}">
                  <p class="title ${videoMap.inpageTitleClass}"><c:out value="${videoMap.title}" escapeXml="true"/> </p>
                </a>
              </c:if>
              <c:if test="${list.showDescription == 'true'}">
                <p class="description ${videoMap.inpageBodyClass}"><c:out value="${videoMap.description}" escapeXml="true"/> </p>
              </c:if>
            </li>
          </c:forEach>
        </ul>
      </c:otherwise>
    </c:choose>

  </div>
</c:if>

