<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-mobile/src/main/webapp/template/common.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%@ taglib prefix="wf-mobile" tagdir="/WEB-INF/tags/widget-mobile" %>

<c:set var="defaultWireFrame" value="${section.parameters['template.wireframe.markup.file']}" />
<c:set var="mobileURL" value="${section.parameters['mobile.subdomain']}" />
<c:set var="isConfigSection" value="${fn:startsWith(section.uniqueName,'config')}" scope="request"/>
<c:set var="contentAreaName" value="contentArea" scope="request"/>

<wf-mobile:detectDevice var="wireframe" defaultWireFrame="${defaultWireFrame}"/>


<c:set var="skinName" value="${section.parameters['skin']}"/>
<c:if test="${empty skinName}">
  <c:set var="skinName" value="escenic-times" />
</c:if>

<c:if test="${wireframe eq 'mobile'}">
    <c:set var="publicationURL" value="${publication.url}" scope="request" />
</c:if>
<c:set var="templateUrl" value="${publication.url}template/framework/" scope="request" />
<c:set var="resourceUrl" value="${publication.url}resources/" scope="request"/>
<c:set var="widgetUrl" value="${publication.url}template/widgets/" scope="request" />
<c:set var="skinUrl" value="${publication.url}skins/${skinName}/" scope="request"/>
<c:set var="skinName" value="${skinName}" scope="request" />

<wf-core:getDateString var="articleListDateString" hourDiff="${publication.features['article.list.age.max']}"/>

<%-- definitions of the config sections --%>
<section:use uniqueName="config">
  <c:set var="globalConfigSection" value="${section}" scope="request"/>
</section:use>
<c:choose>
  <c:when test="${isConfigSection}">
    <c:set var="sectionConfigSection" value="${section}" scope="request"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="config.section.${section.uniqueName}">
      <c:set var="sectionConfigSection" value="${section}" scope="request"/>
    </section:use>
  </c:otherwise>
</c:choose>
<section:use uniqueName="config.section">
  <c:set var="globalSectionConfigSection" value="${section}" scope="request"/>
</section:use>
<section:use uniqueName="config.article.${section.uniqueName}">
  <c:set var="articleConfigSection" value="${section}" scope="request"/>
</section:use>
<section:use uniqueName="config.article">
  <c:set var="globalArticleConfigSection" value="${section}" scope="request"/>
</section:use>

<c:if test="${section.parent.uniqueName=='profile'}">
  <section:use uniqueName="config.section.profile">'
    <c:set var="profileConfigSection" value="${section}" scope="request"/>
  </section:use>
</c:if>

<c:if test="${requestScope['com.escenic.context']=='art'}">
  <section:use uniqueName="config.article.type.${article.articleTypeName}">
    <c:set var="articleConfigArticleType" value="${section}" scope="request" />
  </section:use>

  <section:use uniqueName="config.article.${section.uniqueName}.type.${article.articleTypeName}">
    <c:set var="articleConfigArticleTypeSection" value="${section}" scope="request" />
  </section:use>
    
  <section:use uniqueName="${article.fields.customConfigSection.value}">
      <c:set var="customArticleConfigSection" value="${section}" scope="request" />
  </section:use>
</c:if>

<c:set var="jspStats" value="${fn:trim(section.parameters['jsp.statistics'])}"/>
<c:choose>
  <c:when test="${not empty jspStats and fn:toLowerCase(jspStats) == 'on'}">
    <jsp:include page="framework/profiling/turnOn.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="framework/profiling/turnOff.jsp" />
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${wireframe eq 'widget'}">
    <c:set var="wireframewidget" value="${param['widget']}" />
    <c:set var="wireframeview" value="${param['view']}" scope="request" />
    <c:set var="wireframeid" value="${param['contentId']}"/>
    <article:use articleId="${wireframeid}">
      <c:set var="element" value="${article}" scope="request" />
    </article:use>
    <jsp:forward page="widgets/${wireframewidget}/index.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:forward page="framework/wireframe/${wireframe}.jsp"/>
  </c:otherwise>
</c:choose>
