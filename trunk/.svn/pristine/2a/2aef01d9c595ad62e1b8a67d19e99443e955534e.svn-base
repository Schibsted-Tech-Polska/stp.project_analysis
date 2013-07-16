<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/renderFormFields.tag#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articleSummary" type="neo.xredsys.presentation.PresentationElement" required="false" rtexprvalue="true" %>
<%@ attribute name="articleId" required="false" rtexprvalue="true" %>
<%@ attribute name="imageVersion" required="false" rtexprvalue="true" %>
<%@ attribute name="softCrop" required="false" rtexprvalue="true" %>
<%@ attribute name="prioritizePictureRel" required="false" rtexprvalue="true" %>

<!--
if prioritizePictureRel is true, then this tag first searches image in the articles 'pictureRel' or similar relations,
then searches summary teaser, then article teaser.
Note: usual search priority is - summary teaser, article teaser, article picture
-->

<jsp:useBean id="teaserImageMap" class="java.util.HashMap" scope="page"/>
<c:set var="prioritizePictureRel" value="${prioritizePictureRel == 'true' ? true : false}" />

<c:if test="${empty softCrop}">
  <c:set var="softCrop" value="true"/>
</c:if>

<c:if test="${prioritizePictureRel=='true' and (not empty articleSummary or not empty articleId)}">
  <article:use articleId="${not empty articleSummary ? articleSummary.content.id : articleId}">
      <c:choose>
        <c:when test="${not empty article.relatedElements['pictureRel'] and not empty article.relatedElements['pictureRel'].items and (article.relatedElements['pictureRel'].items[0].content.articleTypeName == 'picture')}">
          <c:set var="imageElement" value="${article.relatedElements['pictureRel'].items[0]}"/>
        </c:when>
        <c:when test="${not empty article.relatedElements['previewRel'] and not empty article.relatedElements['previewRel'].items and (article.relatedElements['previewRel'].items[0].content.articleTypeName == 'picture')}">
          <c:set var="imageElement" value="${article.relatedElements['previewRel'].items[0]}"/>
        </c:when>
      </c:choose>

      <c:if test="${not empty imageElement}">

        <c:choose>
          <c:when test="${article.articleTypeName == 'picture'}">
            <c:set var="imageElementContent" value="${article}" />
          </c:when>
          <c:otherwise>
            <c:set var="imageElementContent" value="${imageElement.content}" />
          </c:otherwise>
        </c:choose>

        <c:set target="${teaserImageMap}" property="imageArticle" value="${imageElementContent}"/>
        <c:set target="${teaserImageMap}" property="imageArticleId" value="${imageElementContent.id}"/>
        <c:set target="${teaserImageMap}" property="contentType" value="${imageElementContent.articleTypeName}"/>
        <c:set target="${teaserImageMap}" property="title" value="${fn:trim(imageElement.fields['title'].value)}"/>
        <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(imageElement.fields['caption'].value)}"/>
        <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(imageElement.fields['alttext'].value)}"/>
        <c:choose>
          <c:when test="${not empty imageVersion and imageElementContent.articleTypeName == 'picture'}">
            <c:choose>
              <c:when test="${softCrop}">
                <c:set target="${teaserImageMap}" property="url" value="${imageElementContent.fields.alternates.value[imageVersion].href}"/>
                <c:set target="${teaserImageMap}" property="width" value="${imageElementContent.fields.alternates.value[imageVersion].width}"/>
                <c:set target="${teaserImageMap}" property="height" value="${imageElementContent.fields.alternates.value[imageVersion].height}"/>
                <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${imageElementContent.fields.alternates.value[imageVersion].inpageClasses}"/>
              </c:when>
              <c:otherwise>
                <c:set target="${teaserImageMap}" property="url" value="${imageElementContent.fields.binary.value[imageVersion]}"/>
              </c:otherwise>
            </c:choose>
          </c:when>
        </c:choose>
      </c:if>
  </article:use>
</c:if>

<c:if test="${empty imageElement and not empty articleSummary}">
  <c:set var="articleId" value="${articleSummary.content.id}"/>
  <c:if test="${not empty articleSummary.fields['teaserRel'].value and (articleSummary.fields['teaserRel'].value[0].articleTypeName == 'picture')}">
    <article:use articleId="${articleSummary.fields['teaserRel'].value[0].id}">
      <c:set target="${teaserImageMap}" property="imageArticle" value="${article}"/>
      <c:set target="${teaserImageMap}" property="imageArticleId" value="${article.id}"/>
      <c:set target="${teaserImageMap}" property="contentType" value="${article.articleTypeName}"/>
      <c:set target="${teaserImageMap}" property="title" value="${fn:trim(article.fields['title'].value)}"/>
      <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(article.fields['caption'].value)}"/>
      <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(article.fields['alttext'].value)}"/>
      <c:choose>
        <c:when test="${not empty imageVersion and article.articleTypeName == 'picture'}">
          <c:choose>
            <c:when test="${softCrop}">
              <c:set target="${teaserImageMap}" property="url" value="${article.fields.alternates.value[imageVersion].href}"/>
              <c:set target="${teaserImageMap}" property="width" value="${article.fields.alternates.value[imageVersion].width}"/>
              <c:set target="${teaserImageMap}" property="height" value="${article.fields.alternates.value[imageVersion].height}"/>
              <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>
            </c:when>
            <c:otherwise>
              <c:set target="${teaserImageMap}" property="url" value="${article.fields.binary.value[imageVersion]}"/>
            </c:otherwise>
          </c:choose>
        </c:when>
      </c:choose>
      <c:set var="foundTeaserImage" value="true"/>
    </article:use>
  </c:if>
</c:if>

<c:if test="${empty imageElement and not foundTeaserImage and not empty articleId}">
  <article:use articleId="${articleId}">
      <c:choose>
        <c:when test="${article.articleTypeName == 'picture'}">
          <c:set var="imageElement" value="${article}"/>
        </c:when>
        <c:when test="${not empty article.relatedElements['teaserRel'] and not empty article.relatedElements['teaserRel'].items and (article.relatedElements['teaserRel'].items[0].content.articleTypeName == 'picture')}">
          <c:set var="imageElement" value="${article.relatedElements['teaserRel'].items[0]}"/>
        </c:when>
        <c:when test="${not empty article.relatedElements['pictureRel'] and not empty article.relatedElements['pictureRel'].items and (article.relatedElements['pictureRel'].items[0].content.articleTypeName == 'picture')}">
          <c:set var="imageElement" value="${article.relatedElements['pictureRel'].items[0]}"/>
        </c:when>
        <c:when test="${not empty article.relatedElements['previewRel'] and not empty article.relatedElements['previewRel'].items and (article.relatedElements['previewRel'].items[0].content.articleTypeName == 'picture')}">
          <c:set var="imageElement" value="${article.relatedElements['previewRel'].items[0]}"/>
        </c:when>
      </c:choose>

      <c:if test="${not empty imageElement}">

        <c:choose>
          <c:when test="${article.articleTypeName == 'picture'}">
            <c:set var="imageElementContent" value="${article}" />
          </c:when>
          <c:otherwise>
            <c:set var="imageElementContent" value="${imageElement.content}" />
          </c:otherwise>
        </c:choose>

        <c:set target="${teaserImageMap}" property="imageArticle" value="${imageElementContent}"/>
        <c:set target="${teaserImageMap}" property="imageArticleId" value="${imageElementContent.id}"/>
        <c:set target="${teaserImageMap}" property="contentType" value="${imageElementContent.articleTypeName}"/>
        <c:set target="${teaserImageMap}" property="title" value="${fn:trim(imageElement.fields['title'].value)}"/>
        <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(imageElement.fields['caption'].value)}"/>
        <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(imageElement.fields['alttext'].value)}"/>
        <c:choose>
          <c:when test="${not empty imageVersion and imageElementContent.articleTypeName == 'picture'}">
            <c:choose>
              <c:when test="${softCrop}">
                <c:set target="${teaserImageMap}" property="url" value="${imageElementContent.fields.alternates.value[imageVersion].href}"/>
                <c:set target="${teaserImageMap}" property="width" value="${imageElementContent.fields.alternates.value[imageVersion].width}"/>
                <c:set target="${teaserImageMap}" property="height" value="${imageElementContent.fields.alternates.value[imageVersion].height}"/>
                <c:set target="${teaserImageMap}" property="inpageStyleClass" value="${imageElementContent.fields.alternates.value[imageVersion].inpageClasses}"/>
              </c:when>
              <c:otherwise>
                <c:set target="${teaserImageMap}" property="url" value="${imageElementContent.fields.binary.value[imageVersion]}"/>
              </c:otherwise>
            </c:choose>
          </c:when>
        </c:choose>
      </c:if>
  </article:use>
</c:if>

<%
  request.setAttribute(var, jspContext.getAttribute("teaserImageMap"));
%>