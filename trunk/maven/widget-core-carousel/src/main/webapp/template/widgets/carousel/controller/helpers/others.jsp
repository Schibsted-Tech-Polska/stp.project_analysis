<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/helpers/others.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection"%>

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>

<collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>
<c:set target="${attributeMap}" property="url" value="${requestScope.cArticle.url}"/>

<c:set var="articleSummary" value="${requestScope.articleSummary}" scope="page"/>
<c:set var="cArticle" value="${requestScope.cArticle}" scope="page"/>

<%-- simple video and youtube video content type --%>
<wf-core:isVideoArticle var="tempIsVideoArticle" articleContent="${cArticle}" />
<c:set var="isVideoArticle" value="${tempIsVideoArticle}" />
<c:remove var="tempIsVideoArticle" scope="request" />

<c:choose>
  <%-- picture content type --%>
  <c:when test="${cArticle.articleTypeName == 'picture'}">
    <c:set target="${attributeMap}" property="isVideo" value="false" />
    <c:set var="pictureTitle" value="${fn:trim(articleSummary.fields.title.value)}" />
    <c:set var="pictureCaption" value="${fn:trim(articleSummary.fields.caption.value)}" />

    <c:set var="articleTitle" value="${not empty pictureCaption ? pictureCaption : pictureTitle}" />

    <wf-core:getCurtailedText var="curtailedTitle" inputText="${articleTitle}"
                                maxLength="${carousel.titleMaxLength}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="title" value="${curtailedTitle}" />
    <c:remove var="curtailedTitle" scope="request"/>


    <wf-core:getCurtailedText var="curtailedFilmstripTitle" inputText="${articleTitle}"
                                maxLength="${carousel.maxCharactersFilmstripTitle}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="flimstripTitle" value="${curtailedFilmstripTitle}" />
    <c:remove var="curtailedFilmstripTitle" scope="request"/>
    <c:set var="leadtext" value="${fn:trim(cArticle.fields.description.value)}"/>
    <c:if test="${fn:length(leadtext) > (carousel.leadtextMaxLength + 0)}">
      <wf-core:getCurtailedText var="curtailedLeadtext" inputText="${leadtext}"
                                  maxLength="${carousel.leadtextMaxLength}" ellipsis="..."/>
      <c:set var="leadtext" value="${curtailedLeadtext}"/>
      <c:remove var="curtailedLeadtext" scope="request"/>
    </c:if>
    <c:set target="${attributeMap}" property="leadtext" value="${leadtext}" />
    <%--<c:set target="${attributeMap}" property="image" value="${cArticle}" />--%>

    <c:set target="${attributeMap}" property="imageTitle" value="${not empty cArticle.fields.caption.value ? cArticle.fields.caption.value : cArticle.fields.title.value}" />
    <c:set target="${attributeMap}" property="imageAlttext" value="${cArticle.fields.alttext.value}" />

    <c:if test="${cArticle.articleTypeName == 'picture'}" >
      <c:set target="${attributeMap}" property="imageUrl" value="${cArticle.fields.alternates.value[carousel.imageVersion].href}" />
      <c:set target="${attributeMap}" property="imageWidth" value="${cArticle.fields.alternates.value[carousel.imageVersion].width}" />
      <c:set target="${attributeMap}" property="imageHeight" value="${cArticle.fields.alternates.value[carousel.imageVersion].height}" />
      <c:set target="${attributeMap}" property="thumbnailImageUrl" value="${cArticle.fields.alternates.value[carousel.thumbnailImageVersion].href}" />
      <c:set target="${attributeMap}" property="thumbnailImageWidth" value="${cArticle.fields.alternates.value[carousel.thumbnailImageVersion].width}" />
      <c:set target="${attributeMap}" property="thumbnailImageHeight" value="${cArticle.fields.alternates.value[carousel.thumbnailImageVersion].height}" />
    </c:if>

  </c:when>

  <c:when test="${isVideoArticle}">
    <c:set target="${attributeMap}" property="isVideo" value="true" />

    <c:set var="videoTitle" value="${fn:trim(articleSummary.fields.title.value)}" />
    <c:set var="videoCaption" value="${fn:trim(articleSummary.fields.caption.value)}" />

    <c:set var="articleTitle" value="${not empty videoCaption ? videoCaption : videoTitle}" />

    <wf-core:getCurtailedText var="curtailedTitle" inputText="${articleTitle}"
                                maxLength="${carousel.titleMaxLength}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="title" value="${curtailedTitle}" />
    <c:remove var="curtailedTitle" scope="request"/>

    <wf-core:getCurtailedText var="curtailedFilmstripTitle" inputText="${articleTitle}"
                                maxLength="${carousel.maxCharactersFilmstripTitle}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="flimstripTitle" value="${curtailedFilmstripTitle}" />
    <c:remove var="curtailedFilmstripTitle" scope="request"/>
    <c:set var="leadtext" value="${fn:trim(cArticle.fields.body.value)}"/>

    <c:if test="${fn:length(leadtext) > (carousel.leadtextMaxLength + 0)}">
      <wf-core:getCurtailedText var="curtailedLeadtext" inputText="${leadtext}"
                                  maxLength="${carousel.leadtextMaxLength}" ellipsis="..."/>
      <c:set var="leadtext" value="${curtailedLeadtext}"/>
      <c:remove var="curtailedLeadtext" scope="request"/>
    </c:if>
    <c:set target="${attributeMap}" property="leadtext" value="${leadtext}" />

    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}" articleId="${cArticle.id}" imageVersion="${carousel.imageVersion}" prioritizePictureRel="true"/>
    <c:if test="${not empty requestScope.teaserImageMap}">
      <c:set target="${attributeMap}" property="image" value="${requestScope.teaserImageMap.imageArticle}"/>
      <c:set target="${attributeMap}" property="imageUrl" value="${requestScope.teaserImageMap.url}"/>
      <c:set target="${attributeMap}" property="imageTitle" value="${not empty requestScope.teaserImageMap.caption ? requestScope.teaserImageMap.caption : requestScope.teaserImageMap.title}"/>
      <c:set target="${attributeMap}" property="imageAlttext" value="${requestScope.teaserImageMap.alttext}"/>
      <c:set target="${attributeMap}" property="imageWidth" value="${requestScope.teaserImageMap.width}"/>
      <c:set target="${attributeMap}" property="imageHeight" value="${requestScope.teaserImageMap.height}"/>
    </c:if>
    <c:remove var="teaserImageMap" scope="request"/>

    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}" articleId="${cArticle.id}" imageVersion="${carousel.thumbnailImageVersion}"/>
    <c:if test="${not empty requestScope.teaserImageMap}">
      <c:set target="${attributeMap}" property="thumbnailImageUrl" value="${requestScope.teaserImageMap.url}"/>
      <c:set target="${attributeMap}" property="thumbnailImageWidth" value="${requestScope.teaserImageMap.width}"/>
      <c:set target="${attributeMap}" property="thumbnailImageHeight" value="${requestScope.teaserImageMap.height}"/>
    </c:if>
    <c:remove var="teaserImageMap" scope="request"/>

  </c:when>

  <%-- news and all other content types --%>
  <c:otherwise>
    <c:set target="${attributeMap}" property="isVideo" value="false" />
    <c:set var="articleTitle" value="${fn:trim(articleSummary.fields.title.value)}" />
    <wf-core:getCurtailedText var="curtailedTitle" inputText="${articleTitle}"
                                maxLength="${carousel.titleMaxLength}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="title" value="${curtailedTitle}" />
    <c:remove var="curtailedTitle" scope="request"/>

    <wf-core:getCurtailedText var="curtailedFilmstripTitle" inputText="${articleTitle}"
                                maxLength="${carousel.maxCharactersFilmstripTitle}" ellipsis="..."/>
    <c:set target="${attributeMap}" property="flimstripTitle" value="${curtailedFilmstripTitle}" />
    <c:remove var="curtailedFilmstripTitle" scope="request"/>

    <c:set var="leadtext" value="${fn:trim(articleSummary.fields.leadtext)}"/>
    <c:if test="${fn:length(leadtext) > (carousel.leadtextMaxLength + 0)}">
      <wf-core:getCurtailedText var="curtailedLeadtext" inputText="${leadtext}"
                                  maxLength="${carousel.leadtextMaxLength}" ellipsis="..."/>
      <c:set var="leadtext" value="${curtailedLeadtext}"/>
      <c:remove var="curtailedLeadtext" scope="request"/>
    </c:if>
    <c:set target="${attributeMap}" property="leadtext" value="${leadtext}"/>

    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}" articleId="${cArticle.id}" imageVersion="${carousel.imageVersion}" prioritizePictureRel="true"/>
    <c:if test="${not empty requestScope.teaserImageMap}">
      <c:set target="${attributeMap}" property="imageUrl" value="${requestScope.teaserImageMap.url}"/>
      <c:set target="${attributeMap}" property="imageTitle" value="${not empty requestScope.teaserImageMap.caption ? requestScope.teaserImageMap.caption : requestScope.teaserImageMap.title}"/>
      <c:set target="${attributeMap}" property="imageAlttext" value="${requestScope.teaserImageMap.alttext}"/>
      <c:set target="${attributeMap}" property="imageWidth" value="${requestScope.teaserImageMap.width}"/>
      <c:set target="${attributeMap}" property="imageHeight" value="${requestScope.teaserImageMap.height}"/>
    </c:if>
    <c:remove var="teaserImageMap" scope="request"/>

    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}" articleId="${cArticle.id}" imageVersion="${carousel.thumbnailImageVersion}"/>
    <c:if test="${not empty requestScope.teaserImageMap}">
      <c:set target="${attributeMap}" property="thumbnailImageUrl" value="${requestScope.teaserImageMap.url}"/>
      <c:set target="${attributeMap}" property="thumbnailImageWidth" value="${requestScope.teaserImageMap.width}"/>
      <c:set target="${attributeMap}" property="thumbnailImageHeight" value="${requestScope.teaserImageMap.height}"/>
    </c:if>
    <c:remove var="teaserImageMap" scope="request"/>

  </c:otherwise>
</c:choose>

<!-- if not image is available, use default image -->
<c:if test="${empty attributeMap.imageUrl}">
  <c:set target="${attributeMap}" property="imageUrl" value="${carousel.defaultImage}" />
  <c:set target="${attributeMap}" property="imageWidth" value="${carousel.mainDisplayWidth}" />
  <c:set target="${attributeMap}" property="imageHeight" value="${carousel.mainDisplayHeight}" />
</c:if>

<c:if test="${empty attributeMap.thumbnailImageUrl}">
  <c:set target="${attributeMap}" property="thumbnailImageUrl" value="${carousel.defaultThumbnailImage}" />
  <c:set target="${attributeMap}" property="thumbnailImageWidth" value="${carousel.thumbnailImageOriginalWidth}" />
  <c:set target="${attributeMap}" property="thumbnailImageHeight" value="${carousel.thumbnailImageOriginalHeight}" />
</c:if>

<c:set var="counter" value="${requestScope.counter + 1}" scope="request"/>
<c:if test="${carousel.showCommentCount}">
  <wf-core:countArticleComments var="numberOfAllComments" articleId="${cArticle.id}"/>
  <c:set target="${attributeMap}" property="commentCount">
    <fmt:message key="carousel.comment.count">
      <fmt:param value="${requestScope.numberOfAllComments}"/>
    </fmt:message>
  </c:set>
  <c:remove var="numberOfAllComments" scope="request"/>
</c:if>

<c:if test="${carousel.showRelatedItems == 'true'}">
  <c:if test="${not empty cArticle.relatedElements.storyRel and not empty cArticle.relatedElements.storyRel.items }">
    <collection:createList id="relatedItems" type="java.util.ArrayList" toScope="page"/>
    <c:forEach var="item" items="${cArticle.relatedElements.storyRel.items}" begin="0"
               end="${carousel.maxRelatedItemsCount-1}">
      <collection:add collection="${relatedItems}" value="${item.content}"/>
    </c:forEach>
    <c:set target="${attributeMap}" property="relatedItems" value="${relatedItems}"/>
    <c:remove var="relatedItems" scope="page"/>
  </c:if>
</c:if>
<collection:add collection="${requestScope.mapList}" value="${attributeMap}"/>


<c:remove var="attributeMap" scope="page"/>
<c:remove var="cArticle" scope="page"/>
<c:remove var="articleSummary" scope="page"/>