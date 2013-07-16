<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getTeaserImageMapList.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
 This tag retrieves the teaser image, along with caption etc, for an article.
 The image, along with its attributes, are placed in a map in request scope.
 This tag either takes an article summary, or article id in order to identify the source article.
 If both are specified, articleSummary attribute takes precedence.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articleSummary" type="neo.xredsys.presentation.PresentationElement" required="false" rtexprvalue="true" %>
<%@ attribute name="pArticle" type="neo.xredsys.presentation.PresentationArticle" required="false" rtexprvalue="true" %>
<%@ attribute name="articleId" required="false" rtexprvalue="true" %>
<%@ attribute name="imageVersion" required="false" rtexprvalue="true" %>
<%@ attribute name="softCrop" required="false" rtexprvalue="true" %>

<c:choose>
  <c:when test="${not empty articleSummary}">
    <c:if test="${not empty articleSummary.fields.teaserRel}">
      <c:set var="teaserRelations" value="${articleSummary.fields.teaserRel.value}" />
    </c:if>

    <c:if test="${not empty articleSummary.content.relatedElements.teaserRel}">
      <c:set var="articleTeaserRelations" value="${articleSummary.content.relatedElements.teaserRel.items}" />
    </c:if>

    <c:if test="${not empty articleSummary.content.relatedElements.pictureRel}">
      <c:set var="articlePictureRelations" value="${articleSummary.content.relatedElements.pictureRel.items}" />
    </c:if>
  </c:when>
  <c:when test="${not empty pArticle}">
    <c:set var="teaserRelations" value="" />

    <c:if test="${not empty pArticle.relatedElements.teaserRel}">
      <c:set var="articleTeaserRelations" value="${pArticle.relatedElements.teaserRel.items}" />
    </c:if>

    <c:if test="${not empty pArticle.relatedElements.pictureRel}">
      <c:set var="articlePictureRelations" value="${pArticle.relatedElements.pictureRel.items}" />
    </c:if>

  </c:when>
  <c:when test="${not empty articleId}">
    <article:use articleId="${articleId}">
      <c:set var="teaserRelations" value="" />
      <c:if test="${not empty article.relatedElements.teaserRel}">
        <c:set var="articleTeaserRelations" value="${article.relatedElements.teaserRel.items}" />
      </c:if>

      <c:if test="${not empty article.relatedElements.pictureRel}">
        <c:set var="articlePictureRelations" value="${article.relatedElements.pictureRel.items}" />
      </c:if>

    </article:use>
  </c:when>
</c:choose>

<c:if test="${empty softCrop}">
  <c:set var="softCrop" value="${true}" />
</c:if>

<collection:createList id="teaserImageMapList" type="java.util.ArrayList"/>

<c:if test="${not empty teaserRelations}">
  <c:forEach var="teaserItem" items="${teaserRelations}">
    <c:if test="${teaserItem.articleTypeName == 'picture'}">
      <article:use articleId="${teaserItem.id}">
        <collection:createMap id="teaserImageMap" type="java.util.HashMap" toScope="page" />
        <c:set target="${teaserImageMap}" property="title" value="${fn:trim(article.fields.title.value)}"/>
        <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(article.fields.caption.value)}"/>
        <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(article.fields.alttext.value)}"/>
        <c:set target="${teaserImageMap}" property="imageArticle" value="${article}"/>

        <c:if test="${not empty imageVersion}">
          <c:choose>
            <c:when test="${softCrop}">
              <c:set target="${teaserImageMap}" property="url" value="${article.fields.alternates.value[imageVersion].href}" />
              <c:set target="${teaserImageMap}" property="width" value="${article.fields.alternates.value[imageVersion].width}" />
              <c:set target="${teaserImageMap}" property="height" value="${article.fields.alternates.value[imageVersion].height}" />
              <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>
            </c:when>
            <c:otherwise>
              <c:set target="${teaserImageMap}" property="url" value="${article.fields.binary.value[imageVersion]}" />
            </c:otherwise>
          </c:choose>
        </c:if>

        <collection:add collection="${teaserImageMapList}" value="${teaserImageMap}" />
        <c:remove var="teaserImageMap" scope="page" /> 
      </article:use>
    </c:if>
  </c:forEach>
</c:if>


<c:if test="${empty teaserImageMapList and not empty articleTeaserRelations}">
  <c:forEach var="articleTeaserItem" items="${articleTeaserRelations}">
    <c:if test="${articleTeaserItem.content.articleTypeName == 'picture'}">
      <collection:createMap id="teaserImageMap" type="java.util.HashMap" toScope="page" />
      <c:set target="${teaserImageMap}" property="title" value="${fn:trim(articleTeaserItem.fields.title.value)}"/>
      <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(articleTeaserItem.fields.caption.value)}"/>
      <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(articleTeaserItem.fields.alttext.value)}"/>
      <c:set target="${teaserImageMap}" property="imageArticle" value="${articleTeaserItem.content}"/>

      <c:if test="${not empty imageVersion}">
        <c:choose>
          <c:when test="${softCrop}">
            <c:set target="${teaserImageMap}" property="url" value="${articleTeaserItem.content.fields.alternates.value[imageVersion].href}" />
            <c:set target="${teaserImageMap}" property="width" value="${articleTeaserItem.content.fields.alternates.value[imageVersion].width}" />
            <c:set target="${teaserImageMap}" property="height" value="${articleTeaserItem.content.fields.alternates.value[imageVersion].height}" />
            <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${articleTeaserItem.content.fields.alternates.value[imageVersion].inpageClasses}"/>
          </c:when>
          <c:otherwise>
            <c:set target="${teaserImageMap}" property="url" value="${articleTeaserItem.content.fields.binary.value[imageVersion]}" />
          </c:otherwise>
        </c:choose>
      </c:if>

      <collection:add collection="${teaserImageMapList}" value="${teaserImageMap}" />
      <c:remove var="teaserImageMap" scope="page" />
    </c:if>
  </c:forEach>
</c:if>


<c:if test="${empty teaserImageMapList and not empty articlePictureRelations}">
  <c:forEach var="articlePictureItem" items="${articlePictureRelations}">
    <c:if test="${articlePictureItem.content.articleTypeName == 'picture'}">
      <collection:createMap id="teaserImageMap" type="java.util.HashMap" toScope="page" />
      <c:set target="${teaserImageMap}" property="title" value="${fn:trim(articlePictureItem.fields.title.value)}"/>
      <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(articlePictureItem.fields.caption.value)}"/>
      <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(articlePictureItem.fields.alttext.value)}"/>
      <c:set target="${teaserImageMap}" property="imageArticle" value="${articlePictureItem.content}"/>

      <c:if test="${not empty imageVersion}">
        <c:choose>
          <c:when test="${softCrop}">
            <c:set target="${teaserImageMap}" property="url" value="${articlePictureItem.content.fields.alternates.value[imageVersion].href}" />
            <c:set target="${teaserImageMap}" property="width" value="${articlePictureItem.content.fields.alternates.value[imageVersion].width}" />
            <c:set target="${teaserImageMap}" property="height" value="${articlePictureItem.content.fields.alternates.value[imageVersion].height}" />
            <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${articlePictureItem.content.fields.alternates.value[imageVersion].inpageClasses}"/>
          </c:when>
          <c:otherwise>
            <c:set target="${teaserImageMap}" property="url" value="${articlePictureItem.content.fields.binary.value[imageVersion]}" />
          </c:otherwise>
        </c:choose>
      </c:if>

      <collection:add collection="${teaserImageMapList}" value="${teaserImageMap}" />
      <c:remove var="teaserImageMap" scope="page" />
    </c:if>
  </c:forEach>
</c:if>


<%
  request.setAttribute(var, jspContext.getAttribute("teaserImageMapList"));
%>