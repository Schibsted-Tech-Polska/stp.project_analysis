<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/articleAttributes.jsp#1 $
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
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>


<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<jsp:useBean id="articleClass" class="java.lang.String" scope="request"/>

<%--create the map that will contain various attributes of article --%>
<jsp:useBean id="attributeMap" class="java.util.HashMap" scope="request"/>

<c:set target="${attributeMap}" property="articleClass" value="${articleClass}"/>
<c:set target="${attributeMap}" property="publishedDate">
  <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${list.dateFormat}"/>
</c:set>

<c:choose>
  <c:when test="${list.articleSource eq 'groupedContent' and not empty requestScope.contentSummary}">
    <c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
    <c:set target="${attributeMap}" property="articleUrl" value="${article.url}"/>
    <c:set target="${attributeMap}" property="inpageDnDSummaryClass" value="${requestScope.contentSummary.options.inpageClasses}"/>

    <c:choose>
      <c:when test="${requestScope.contentSummary.content.articleTypeName == 'picture'}">
        <c:set var="pictureTitle" value="${fn:trim(requestScope.contentSummary.fields.title.value)}" />
        <c:set var="pictureCaption" value="${fn:trim(requestScope.contentSummary.fields.caption.value)}" />
        <c:set var="inpageTitleClass" value="${requestScope.contentSummary.fields.title.options.inpageClasses}"/>
        <c:set var="inpageCaptionClass" value="${requestScope.contentSummary.fields.caption.options.inpageClasses}"/>

        <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
        <c:set target="${attributeMap}" property="inpageTitleClass"
               value="${not empty pictureCaption ? inpageCaptionClass : inpageTitleClass}"/>
        <c:set target="${attributeMap}" property="leadtext" value="${fn:trim(article.fields.description.value)}" />
        <c:remove var="pictureTitle" scope="page" />
        <c:remove var="pictureCaption" scope="page" />
      </c:when>
      <c:otherwise>
        <c:set target="${attributeMap}" property="title" value="${fn:trim(requestScope.contentSummary.fields.title.value)}" />
        <c:set target="${attributeMap}" property="inpageTitleClass" value="${requestScope.contentSummary.fields.title.options.inpageClasses}"/>
        <wf-core:getFieldValueByKey var="leadtextMap" key="leadtext" articleSummary="${requestScope.contentSummary}" />
        <c:set target="${attributeMap}" property="leadtext" value="${leadtextMap.fieldValue}" />
        <c:set target="${attributeMap}" property="inpageLeadtextClass" value="${leadtextMap.inpageStyleClass}"/>
        <c:remove var="leadtextMap" scope="request" />
      </c:otherwise>
    </c:choose>
  </c:when>

  <c:when test="${article.articleTypeName == 'picture'}">
    <c:set var="pictureTitle" value="${fn:trim(article.fields.title.value)}" />
    <c:set var="pictureCaption" value="${fn:trim(article.fields.caption.value)}" />
    <c:set var="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
    <c:set var="inpageCaptionClass" value="${article.fields.caption.options.inpageClasses}"/> 
    <c:set target="${attributeMap}" property="title" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />
    <c:set target="${attributeMap}" property="inpageTitleClass" value="${not empty pictureCaption ? inpageCaptionClass : inpageTitleClass}"/>
    <c:set target="${attributeMap}" property="leadtext" value="${fn:trim(article.fields.description.value)}" />
    <c:set target="${attributeMap}" property="inpageDescriptionClass" value="${article.fields.description.options.inpageClasses}"/>
    <c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
    <c:set target="${attributeMap}" property="articleUrl" value="${article.url}"/>
    <c:remove var="pictureTitle" scope="page" />
    <c:remove var="pictureCaption" scope="page" />
  </c:when>

  <c:when test="${article.articleTypeName=='posting'}">
    <c:set target="${attributeMap}" property="title" value="${fn:trim(article.fields.title.value)}" />
    <c:set target="${attributeMap}" property="leadtext" value="${fn:trim(article.fields.body.value)}" />
    <c:set var="postingArticleId" value="${fn:trim(article.fields.articleId)}" />

    <c:if test="${not empty postingArticleId}">
      <article:use articleId="${postingArticleId}">
        <c:url var="articleUrl" value="${article.url}">
          <c:param name="tabPane" value="Comments"/>
        </c:url>
        <c:set target="${attributeMap}" property="articleUrl" value="${articleUrl}#commentsList" />
        <c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
      </article:use>
    </c:if>

    <c:remove var="postingArticleId" scope="page" />
  </c:when>

  <c:otherwise>
    <c:set target="${attributeMap}" property="title" value="${fn:trim(article.fields.title.value)}" />
    <c:set target="${attributeMap}" property="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
    <wf-core:getFieldValueByKey var="leadtextMap" key="leadtext" articleContent="${article}"  />
    <c:set target="${attributeMap}" property="leadtext" value="${leadtextMap.fieldValue}" />
    <c:set target="${attributeMap}" property="inpageLeadtextClass" value="${leadtextMap.inpageStyleClass}"/>
    <c:remove var="leadtextMap" scope="request" />
    <c:set target="${attributeMap}" property="articleUrl" value="${article.url}"/>
    <c:set target="${attributeMap}" property="articleId" value="${article.id}"/>
  </c:otherwise>
</c:choose>

<c:if test="${not empty attributeMap.leadtext}">
  <wf-core:getCurtailedText var="curtailedLeadtext" inputText="${attributeMap.leadtext}" maxLength="${list.maxCharacters}" ellipsis="....."/>
  <c:set target="${attributeMap}" property="leadtext" value="${requestScope.curtailedLeadtext}"/>
  <c:remove var="curtailedLeadtext" scope="request"/>
</c:if>

<c:if test="${list.showCommentCount and not empty attributeMap.articleId}">
  <article:use articleId="${attributeMap.articleId}">
    <wf-core:countArticleComments var="numberOfAllComments" articleId="${attributeMap.articleId}"/>
    <c:set var="commentsLinkUrlSuffix" value="${requestScope.numberOfAllComments==0 ? '#commentsForm' : '#commentsList'}"/>
    <c:url var="commnetsLinkUrl" value="${article.url}">
     <c:param name="tabPane" value="Comments"/>
    </c:url>

    <c:set target="${attributeMap}" property="commentsLinkUrl" value="${commnetsLinkUrl}${commentsLinkUrlSuffix}"/>
    <c:set target="${attributeMap}" property="commentsLinkText">
      <fmt:message key="list.comment.count">
        <fmt:param value="${requestScope.numberOfAllComments}" />
      </fmt:message>
    </c:set>

    <c:remove var="numberOfAllComments" scope="request"/>
  </article:use>
</c:if>

<c:if test="${list.showThumb}">
  <c:choose>
    <c:when test="${article.articleTypeName == 'picture'}">
      <jsp:useBean id="teaserImageMap" class="java.util.HashMap" scope="page"/>
      <c:set target="${teaserImageMap}" property="title" value="${fn:trim(article.fields.title.value)}"/>
      <c:set target="${teaserImageMap}" property="caption" value="${fn:trim(article.fields.caption.value)}"/>
      <c:set target="${teaserImageMap}" property="alttext" value="${fn:trim(article.fields.alttext.value)}"/>
      <c:set target="${teaserImageMap}" property="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
      <c:set target="${teaserImageMap}" property="inpageCaptionClass" value="${article.fields.caption.options.inpageClasses}"/>
      <c:set var="imageVersion" value="${list.imageVersion}"/>

      <c:set target="${teaserImageMap}" property="url" value="${article.fields.alternates.value[imageVersion].href}"/>
      <c:set target="${teaserImageMap}" property="width" value="${article.fields.alternates.value[imageVersion].width}"/>
      <c:set target="${teaserImageMap}" property="height" value="${article.fields.alternates.value[imageVersion].height}"/>
      <c:set target="${teaserImageMap}" property="inpageImageClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>

      <c:set target="${attributeMap}" property="teaserImageMap" value="${teaserImageMap}"/>
      <c:remove var="teaserImageMap" scope="page"/>
    </c:when>

    <c:when test="${list.articleSource eq 'groupedContent' and not empty requestScope.contentSummary}">
      <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${requestScope.contentSummary}"
                                   imageVersion="${list.imageVersion}"/>
      <c:set target="${attributeMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
      <c:remove var="teaserImageMap" scope="request"/>
    </c:when>

    <c:otherwise>
      <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${article.id}" imageVersion="${list.imageVersion}"/>
      <c:set target="${attributeMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
      <c:remove var="teaserImageMap" scope="request"/>
    </c:otherwise>

  </c:choose>
</c:if>

