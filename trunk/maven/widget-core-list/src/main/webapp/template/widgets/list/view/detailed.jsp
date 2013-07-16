<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/detailed.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<div class="${list.wrapperStyleClass} ${list.inpageDnDAreaClass}" <c:if test="${not empty list.styleId}">id="${list.styleId}"</c:if>>
  <%-- show the header conditionally --%>
  <c:if test="${requestScope.tabbingEnabled!='true' and not empty list.attributeMapList}">
    <div class="header">
      <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
    </div>
  </c:if>

  <c:if test="${not empty list.attributeMapList}">
    <div class="content">
      <c:forEach var="attributeMap" items="${list.attributeMapList}">
        <div class="article ${attributeMap.articleClass} ${attributeMap.inpageDnDSummaryClass}">
          <c:set var="teaserImageMap" value="${attributeMap.teaserImageMap}"/>
          <c:if test="${list.showThumb and not empty teaserImageMap.imageArticle}">
            <c:set var="imageArticle" value="${teaserImageMap.imageArticle}"/>
            <c:set var="imageVersion" value="${list.imageVersion}"/>
            <c:set var="inpageImageClass" value="${imageArticle.fields.alternates.value[imageVersion].inpageClasses}"/>
            <img src="${imageArticle.fields.alternates.value[imageVersion].href}"
                 alt="${teaserImageMap.alttext}"
                 class="${inpageImageClass}"
                 title="${teaserImageMap.caption}"
                 width="${imageArticle.fields.alternates.value[imageVersion].width}"
                 height="${imageArticle.fields.alternates.value[imageVersion].height}"/>
          </c:if>

          <h4>
            <c:choose>
              <c:when test="${not empty attributeMap.articleUrl}">
                <a href="${attributeMap.articleUrl}" class="${attributeMap.inpageTitleClass}">
                  <c:out value="${attributeMap.title}" escapeXml="true"/>
                </a>
              </c:when>
              <c:otherwise>
                <a href="#" class="${attributeMap.inpageTitleClass}">
                  <c:out value="${attributeMap.title}" escapeXml="true"/>
                </a>
              </c:otherwise>
            </c:choose>
          </h4>

          <c:if test="${list.showIntro}">
            <p class="${attributeMap.inpageLeadtextClass}">
              <c:out value="${attributeMap.leadtext}" escapeXml="true"/>
            </p>
          </c:if>

          <c:if test="${list.showDate}">
            <p class="dateline"><c:out value="${attributeMap.publishedDate}" escapeXml="true"/></p>
          </c:if>

          <c:if test="${list.showCommentCount and not empty attributeMap.commentsLinkUrl}">
            <p class="comments">
              <a href="${attributeMap.commentsLinkUrl}"><c:out value="${attributeMap.commentsLinkText}" escapeXml="true"/></a>
            </p>
          </c:if>
        </div>
      </c:forEach>
    </div>
  </c:if>
</div>

<c:remove var="list" scope="request"/>

