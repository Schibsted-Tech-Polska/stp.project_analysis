<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/controller/favorite.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is controller for the favourite view of rating widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile"%>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>

<%-- the general controller has already set a Map named 'rating' in the requestScope --%>
<jsp:useBean id="rating" type="java.util.Map" scope="request"/>

<c:if test="${requestScope['com.escenic.context']=='art'}">
  <qual:count id="numberOfFavorites" type="favorite" />
  <c:set target="${rating}" property="numberOfFavorites" value="${numberOfFavorites}" />

  <profile:present>
    <qual:hasQualified id="isFavorite" type="favorite" />
    <c:set target="${rating}" property="isFavorite" value="${isFavorite}" />  
  </profile:present>
</c:if>

<c:set var="favoriteLinkText" value="${fn:trim(widgetContent.fields.favoriteLinkText)}" />
<c:if test="${empty favoriteLinkText}">
  <c:set var="favoriteLinkText">
    <fmt:message key="rating.widget.favorite.addFavourite.linkText" />
  </c:set>
</c:if>

<c:set target="${rating}" property="favoriteLinkText" value="${favoriteLinkText}"/>

<c:set var="favoriteResultTextSuffix" value="${fn:trim(widgetContent.fields.favoriteResultText)}" />
<c:if test="${empty favoriteResultTextSuffix}">
  <c:set var="favoriteResultTextSuffix">
    <fmt:message key="rating.widget.favorite.resultText.suffix" />
  </c:set>
</c:if>

<c:choose>
  <c:when test="${rating.isFavorite==true and rating.numberOfFavorites==1}">
    <c:set var="favoriteResultTextPrefix">
      <fmt:message key="rating.widget.favorite.resultText.prefix3" />
    </c:set>
  </c:when>
  <c:when test="${rating.isFavorite==true and rating.numberOfFavorites>1}">
    <c:set var="favoriteResultTextPrefix">
      <fmt:message key="rating.widget.favorite.resultText.prefix2">
        <fmt:param value="${rating.numberOfFavorites-1}" />
      </fmt:message>
    </c:set>
  </c:when>
  <c:when test="${rating.isFavorite!=true and rating.numberOfFavorites>0}">
    <c:set var="favoriteResultTextPrefix">
      <fmt:message key="rating.widget.favorite.resultText.prefix1">
        <fmt:param value="${rating.numberOfFavorites}" />
      </fmt:message>
    </c:set>
  </c:when>
  <c:otherwise>
    <c:set var="favoriteResultTextPrefix" value=""/>   
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${not empty favoriteResultTextPrefix}">
    <c:set var="favoriteResultText" value="${favoriteResultTextPrefix} ${favoriteResultTextSuffix}" />
  </c:when>
  <c:otherwise>
    <c:set var="favoriteResultText" value="" />
  </c:otherwise>
</c:choose>

<c:set target="${rating}" property="favoriteResultText" value="${favoriteResultText}"/>

<c:set target="${rating}" property="favoriteSelfResultText">
  <fmt:message key="rating.widget.favorite.resultText.prefix3" /> ${favoriteResultTextSuffix}
</c:set>

<c:remove var="favoriteResultTextPrefix" scope="page" />
<c:remove var="favoriteResultTextSuffix" scope="page" />
<c:remove var="favoriteResultText" scope="page" />