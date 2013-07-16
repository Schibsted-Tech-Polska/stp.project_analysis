<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/pictureAttributes.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<jsp:useBean id="articleClass" class="java.lang.String" scope="request"/>

<%--create the map that will contain various attributes of article --%>
<jsp:useBean id="pictureMap" class="java.util.HashMap" scope="request"/>

<c:if test="${article.articleTypeName == 'picture'}">
  <c:choose>
    <c:when test="${list.articleSource eq 'groupedContent' and not empty requestScope.contentSummary}">
      <c:set target="${pictureMap}" property="title" value="${fn:trim(requestScope.contentSummary.fields.title.value)}"/>
      <c:set target="${pictureMap}" property="caption" value="${fn:trim(requestScope.contentSummary.fields.caption.value)}"/>
      <c:set target="${pictureMap}" property="alttext" value="${fn:trim(requestScope.contentSummary.fields.alttext.value)}"/>
      <c:set target="${pictureMap}" property="photographer" value="${fn:trim(article.fields.photographer.value)}"/>
      <c:set target="${pictureMap}" property="articleId" value="${article.id}"/>
      <c:set target="${pictureMap}" property="articleUrl" value="${article.url}"/>
      <c:set var="imageVersion" value="${list.imageVersion}"/>
      <c:set target="${pictureMap}" property="imageUrl" value="${article.fields.alternates.value[imageVersion].href}"/>
      <c:set target="${pictureMap}" property="width" value="${article.fields.alternates.value[imageVersion].width}"/>
      <c:set target="${pictureMap}" property="height" value="${article.fields.alternates.value[imageVersion].height}"/>
      <c:set target="${pictureMap}" property="inpageTitleClass" value="${requestScope.contentSummary.fields.title.options.inpageClasses}"/>
      <c:set target="${pictureMap}" property="inpageCaptionClass" value="${requestScope.contentSummary.fields.caption.options.inpageClasses}"/>
      <c:set target="${pictureMap}" property="inpageImageClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>
      <c:set target="${pictureMap}" property="inpageDnDSummaryClass" value="${requestScope.contentSummary.options.inpageClasses}"/>
    </c:when>
    <c:otherwise>
      <c:set target="${pictureMap}" property="title" value="${fn:trim(article.fields.title.value)}"/>
      <c:set target="${pictureMap}" property="caption" value="${fn:trim(article.fields.caption.value)}"/>
      <c:set target="${pictureMap}" property="alttext" value="${fn:trim(article.fields.alttext.value)}"/>
      <c:set target="${pictureMap}" property="photographer" value="${fn:trim(article.fields.photographer.value)}"/>
      <c:set target="${pictureMap}" property="articleId" value="${article.id}"/>
      <c:set target="${pictureMap}" property="articleUrl" value="${article.url}"/>
      <c:set var="imageVersion" value="${list.imageVersion}"/>
      <c:set target="${pictureMap}" property="imageUrl" value="${article.fields.alternates.value[imageVersion].href}"/>
      <c:set target="${pictureMap}" property="width" value="${article.fields.alternates.value[imageVersion].width}"/>
      <c:set target="${pictureMap}" property="height" value="${article.fields.alternates.value[imageVersion].height}"/>
      <c:set target="${pictureMap}" property="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
      <c:set target="${pictureMap}" property="inpageCaptionClass" value="${article.fields.caption.options.inpageClasses}"/>
      <c:set target="${pictureMap}" property="inpageImageClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>
    </c:otherwise>
  </c:choose>
</c:if>
