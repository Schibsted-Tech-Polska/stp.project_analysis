<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/helpers/gallery.jsp#1 $
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
<c:set var="cArticle" value="${requestScope.cArticle}" scope="page"/>

<c:if test="${not empty cArticle.relatedElements['pictureRel'] and not empty cArticle.relatedElements['pictureRel'].items}">
  <c:forEach var="galleryItem" items="${cArticle.relatedElements['pictureRel'].items}">
    <c:if test="${requestScope.counter lt requestScope.max}">
      <collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>
      <c:set target="${attributeMap}" property="isVideo" value="false" />
      <c:set target="${attributeMap}" property="url" value="${galleryItem.content.url}"/>
      <%--START--%>
      <c:set var="articleTitle" value="${fn:trim(galleryItem.fields['title'].value)}" />

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

      <c:if test="${galleryItem.content.articleTypeName == 'picture'}">
        <%--<c:set target="${attributeMap}" property="image" value="${galleryItem.content}"/>--%>

        <c:set target="${attributeMap}" property="imageUrl" value="${galleryItem.content.fields.alternates.value[carousel.imageVersion].href}"/>
        <c:set target="${attributeMap}" property="imageTitle" value="${not empty galleryItem.fields.caption.value ? galleryItem.fields.caption.value : galleryItem.fields.title.value}"/>
        <c:set target="${attributeMap}" property="imageAlttext" value="${galleryItem.fields.altext.value}"/>
        <c:set target="${attributeMap}" property="imageWidth" value="${galleryItem.content.fields.alternates.value[carousel.imageVersion].width}"/>
        <c:set target="${attributeMap}" property="imageHeight" value="${galleryItem.content.fields.alternates.value[carousel.imageVersion].height}"/>

        <c:set target="${attributeMap}" property="thumbnailImageUrl" value="${galleryItem.content.fields.alternates.value[carousel.thumbnailImageVersion].href}"/>
        <c:set target="${attributeMap}" property="thumbnailImageWidth" value="${galleryItem.content.fields.alternates.value[carousel.thumbnailImageVersion].width}"/>
        <c:set target="${attributeMap}" property="thumbnailImageHeight" value="${galleryItem.content.fields.alternates.value[carousel.thumbnailImageVersion].height}"/>
      </c:if>

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

      <!-- comments count --> 
      <c:set var="counter" value="${requestScope.counter + 1}" scope="request"/>
      <c:if test="${carousel.showCommentCount}">
        <wf-core:countArticleComments var="numberOfAllComments" articleId="${galleryItem.content.id}"/>
        <c:set target="${attributeMap}" property="commentCount">
          <fmt:message key="carousel.comment.count">
            <fmt:param value="${requestScope.numberOfAllComments}"/>
          </fmt:message>
        </c:set>
        <c:remove var="numberOfAllComments" scope="request"/>
      </c:if>

      <!-- related items -->
      <c:if test="${carousel.showRelatedItems == 'true'}">
        <c:if test="${not empty galleryItem.content.relatedElements.storyRel and not empty galleryItem.content.relatedElements.storyRel.items }">
          <collection:createList id="relatedItems" type="java.util.ArrayList" toScope="page"/>
          <c:forEach var="item" items="${galleryItem.content.relatedElements.storyRel.items}" begin="0"
                     end="${carousel.maxRelatedItemsCount-1}">
            <collection:add collection="${relatedItems}" value="${item.content}"/>
          </c:forEach>
          <c:set target="${attributeMap}" property="relatedItems" value="${relatedItems}"/>
          <c:remove var="relatedItems" scope="page"/>
        </c:if>
      </c:if>
      <collection:add collection="${requestScope.mapList}" value="${attributeMap}"/>

      <c:remove var="attributeMap" scope="page"/>
    </c:if>
  </c:forEach>
</c:if>
<c:remove var="cArticle" scope="page"/>

