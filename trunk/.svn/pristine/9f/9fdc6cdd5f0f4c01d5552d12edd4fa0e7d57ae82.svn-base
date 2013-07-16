<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileCarousel/src/main/webapp/template/widgets/mobileCarousel/view/default.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<jsp:useBean id="mobileCarousel" type="java.util.HashMap" scope="request"/>

<c:if test="${not empty mobileCarousel.articles and fn:length(mobileCarousel.articles) > 0}">
  <dxf:div cssClass="${mobileCarousel.wrapperStyleClass}" id="${mobileCarousel.styleId}">
    <dxw:slideShow cssClass="sshow"
                   id="ss${mobileCarousel.uniqueId}"
                   imageScale="100"
                   skipLinks="true"
                   indexId="indexId${mobileCarousel.uniqueId}"
                   hideBack="true"
                   hideBackId="hideId"
                   transitionPostfix="${mobileCarousel.transitionPostfix}">
      <c:forEach var="item" begin="${mobileCarousel.begin}" end="${mobileCarousel.end}" items="${mobileCarousel.articles}"
                 varStatus="status">
        <c:choose>
          <c:when test="${mobileCarousel.source eq 'automatic'}">
            <c:set var="articleUrl">
              <c:out value="${item.url}" escapeXml="true"/>
            </c:set>
            <c:set var="cArticle" value="${item}"/>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${cArticle.id}"
                                       imageVersion="${mobileCarousel.imageVersion}"/>
          </c:when>
          <c:otherwise>
            <c:set var="articleUrl">
              <c:out value="${item.content.url}" escapeXml="true"/>
            </c:set>
            <c:set var="articleSummary" value="${item}"/>
            <c:set var="cArticle" value="${item.content}"/>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"
                                       imageVersion="${mobileCarousel.imageVersion}"/>
          </c:otherwise>
        </c:choose>

        <c:set var="picture" value="${requestScope.teaserImageMap.imageArticle}"/>
        <c:set var="imageUrl" value="${requestScope.teaserImageMap.url}" scope="request"/>

        <c:if test="${empty imageUrl}">
          <c:set var="imageUrl" value="${requestScope.skinUrl}mobile/gfx/defaultPreview.png"/>
        </c:if>

        <c:choose>
          <c:when test="${mobileCarousel.source eq 'automatic'}">
            <wf-core:handleLineBreaks var="modifiedTitle" value="${cArticle.fields.title.value}"/>
          </c:when>
          <c:otherwise>
            <wf-core:handleLineBreaks var="modifiedTitle" value="${articleSummary.fields.title.value}"/>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${mobileCarousel.source eq 'automatic'}">
            <c:set var="intro" value="${cArticle.fields.leadtext.value}"/>
          </c:when>
          <c:otherwise>
            <c:set var="intro" value="${articleSummary.fields.leadtext.value}"/>
          </c:otherwise>
        </c:choose>

        <c:set var="anHref" value=""/>
        <c:if test="${mobileCarousel.hideCaption ne 'true'}">
          <c:set var="anHref"><dxf:a href="${articleUrl}"><c:out value="${requestScope.modifiedTitle}" escapeXml="false"/></dxf:a></c:set>
        </c:if>
        <dxw:slideShowImage id="image${status.index}" src="${imageUrl}" caption="${anHref}"/>

        <c:remove var="cArticle"/>
        <c:remove var="imageUrl"/>
        <c:remove var="modifiedTitle" scope="request"/>
        <c:remove var="teaserImageMap" scope="request"/>
      </c:forEach>
    </dxw:slideShow>

    <dxw:slideShowAction countVar="countVa" indexVar="indexVa"
                         slideShowId="ss${mobileCarousel.uniqueId}"
                         triggerNextVar="theActionNext"
                         triggerBackVar="theActionBack"
                         typeVar="theType"/>
    <dxf:div cssClass="slideShowNavigation">
      <c:choose>
        <c:when test="${capabilities.pointing_method eq 'touchscreen'}">
          <dxf:span style="float:left;">
            <dxf:a rel="prev" href="${theActionBack}" id="ss${mobileCarousel.uniqueId}pid">
              <dxf:img size="-10" src="${skinUrl}/mobile/gfx/left.png" alt="back"/>
            </dxf:a>
          </dxf:span>
          <dxf:span style="float:right;">
            <dxf:a rel="next" href="${theActionNext}" id="ss${mobileCarousel.uniqueId}nid">
              <dxf:img size="-10" src="${skinUrl}/mobile/gfx/right.png" alt="next"/>
            </dxf:a>
          </dxf:span>

        </c:when>
        <c:otherwise>
          <dxf:span style="float:left;">
            <dxf:a rel="prev" href="${theActionBack}" id="ss1pid">
              <fmt:message key="mobileCarousel.widget.previous.link.text"/>
            </dxf:a>
          </dxf:span>
          <dxf:span style="float:right;">
            <dxf:a rel="next" href="${theActionNext}" id="ss1nid">
              <fmt:message key="mobileCarousel.widget.next.link.text"/>
            </dxf:a>
          </dxf:span>
        </c:otherwise>
      </c:choose>
      <dxf:div cssClass="slideshowText" style="text-align:center;">
        Story <dxf:span id="indexId${mobileCarousel.uniqueId}"><c:out value="${indexVa}" escapeXml="true"/>
      </dxf:span> of <c:out value="${countVa}" escapeXml="true"/>
      </dxf:div>
    </dxf:div>
    <dxf:div style="clear:both;"/>

    <c:remove var="mobileCarousel" scope="request"/>
  </dxf:div>
</c:if>