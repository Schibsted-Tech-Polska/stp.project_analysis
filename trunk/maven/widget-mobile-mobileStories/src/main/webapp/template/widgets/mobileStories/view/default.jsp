<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStories/src/main/webapp/template/widgets/mobileStories/view/default.jsp#2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<jsp:useBean id="mobileStories" type="java.util.HashMap" scope="request"/>

<c:if test="${fn:length(mobileStories.articles) > 0}">
  <c:forEach var="item" begin="${mobileStories.begin}" end="${mobileStories.end}" items="${mobileStories.articles}"
             varStatus="status">
    <c:choose>
      <c:when test="${mobileStories.source eq 'automatic'}">
        <c:set var="articleUrl">
          <c:out value="${item.url}" escapeXml="true"/>
        </c:set>
        <c:set var="cArticle" value="${item}"/>
        <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${cArticle.id}"
                                   imageVersion="${mobileStories.imageVersion}"/>
      </c:when>
      <c:otherwise>
        <c:set var="articleUrl">
          <c:out value="${item.content.url}" escapeXml="true"/>
        </c:set>
        <c:set var="articleSummary" value="${item}"/>
        <c:set var="cArticle" value="${item.content}"/>
        <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"
                                   imageVersion="${mobileStories.imageVersion}"/>
      </c:otherwise>
    </c:choose>

    <c:set var="showImage" value="${not empty requestScope.teaserImageMap.imageArticle}"/>

    <%-- display top picture conditionally --%>
    <jsp:useBean id="teaserImageMap" type="java.util.HashMap" scope="request"/>
    <c:set var="picture" value="${teaserImageMap.imageArticle}"/>
    <c:set var="imageUrl" value="${teaserImageMap.url}" scope="request"/>

    <c:choose>
      <c:when test="${mobileStories.source eq 'automatic'}">
        <wf-core:handleLineBreaks var="modifiedTitle" value="${cArticle.fields.title.value}"/>
      </c:when>
      <c:otherwise>
        <wf-core:handleLineBreaks var="modifiedTitle" value="${articleSummary.fields.title.value}"/>
      </c:otherwise>
    </c:choose>

    <c:choose>
      <c:when test="${mobileStories.source eq 'automatic'}">
        <c:set var="intro" value="${cArticle.fields.leadtext.value}"/>
      </c:when>
      <c:otherwise>
        <c:set var="intro" value="${articleSummary.fields.leadtext.value}"/>
      </c:otherwise>
    </c:choose>

    <c:choose>
      <c:when test="${requestScope.inGridContainer eq 'true'}">
        <dxw:gridItem>
          <dxw:article title="${modifiedTitle}" href="${articleUrl}"
                       image="${imageUrl}"
                       ingress="${intro}"
                       imageAlign="${mobileStories.imagePosition}"
                       imageSize="${mobileStories.imageWidth}"/>
        </dxw:gridItem>
      </c:when>
      <c:otherwise>
        <dxw:article title="${modifiedTitle}" href="${articleUrl}"
                     image="${imageUrl}"
                     ingress="${intro}"
                     imageAlign="${mobileStories.imagePosition}"
                     imageSize="${mobileStories.imageWidth}"/>
      </c:otherwise>
    </c:choose>

    <c:remove var="cArticle"/>
    <c:remove var="teaserImageMap" scope="request"/>
  </c:forEach>
</c:if>

<c:remove var="mobileStories" scope="request"/>
