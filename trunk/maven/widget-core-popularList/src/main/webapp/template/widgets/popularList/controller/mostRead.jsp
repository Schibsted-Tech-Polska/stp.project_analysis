<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-popularList/src/main/webapp/template/widgets/popularList/controller/mostRead.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- This is the controller of the mostRead view of popularList widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="eae" uri="http://www.escenic.com/taglib/escenic-eae" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the general controller has already set a HashMap named 'popularList' in the requestScope --%>
<jsp:useBean id="popularList" type="java.util.HashMap" scope="request"/>

<c:set target="${popularList}" property="headline" value="${fn:trim(element.fields.title.value)}" />
<c:set target="${popularList}" property="showCount" value="${fn:trim(widgetContent.fields.showCountRead)}" />
<c:set var="articleSource" value="${fn:trim(widgetContent.fields.sourceRead)}" />
<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueNameRead)}" />
<c:set var="maxArticles" value="${fn:trim(widgetContent.fields.maxArticlesRead)}" />
<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentTypeRead)}" />
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news" />
</c:if>

<c:set var="age" value="${fn:trim(widgetContent.fields.ageRead)}" />
<c:set var="queryServiceUrl" value="${section.parameters['eae.queryservice.url']}" />

<c:choose>
  <c:when test="${not empty sectionUniqueName}">
    <section:use uniqueName="${sectionUniqueName}">
      <c:set var="sectionId" value="${section.id}" />
    </section:use>

    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      sectionId="${sectionId}"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:when>

  <c:when test="${articleSource == 'current'}">
    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      sectionId="${section.id}"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:when>

  <c:otherwise>
    <eae:most-popular id="mostRead"
                      url="${queryServiceUrl}"
                      collectionId="mostReadArticles"
                      sinceHoursAgo="${age}"
                      max="${maxArticles}"
                      type="article"
                      pubId="${publication.id}"
                      includeContextPubId="true"
                      meta="read-${contentType}" />
  </c:otherwise>

</c:choose>

<collection:createList id="popularItems" type="java.util.ArrayList"/>
<c:forEach var="mostReadArticle" items="${mostReadArticles}">
  <article:use articleId="${mostReadArticle.objId}">
    <jsp:useBean id="popularItem" class="java.util.HashMap"/>
    <c:choose>
      <c:when test="${article.articleTypeName == 'picture'}">
        <c:set target="${popularItem}" property="url" value="${article.url}"/>

        <wf-core:getFieldValueByKey var="titleMap" key="title" articleContent="${article}"/>
        <c:set target="${popularItem}" property="title" value="${titleMap.fieldValue}"/>
        <c:set target="${popularItem}" property="inpageTitleClass" value="${titleMap.inpageStyleClass}"/>
        <c:remove var="titleMap" scope="request"/>

        <wf-core:getFieldValueByKey var="leadtextMap" key="leadtext" articleContent="${article}"/>
        <c:if test="${not empty popularList.maxLeadtextChar}">
          <wf-core:getCurtailedText var="tempCurtailedLeadtext" inputText="${leadtextMap.fieldValue}" maxLength="${popularList.maxLeadtextChar}" ellipsis="..." />
          <c:set target="${leadtextMap}" property="fieldValue" value="${tempCurtailedLeadtext}"/>
          <c:remove var="tempCurtailedLeadtext" scope="request" />
        </c:if>
        <c:set target="${popularItem}" property="leadtext" value="${leadtextMap.fieldValue}"/>
        <c:set target="${popularItem}" property="inpageLeadtextClass" value="${leadtextMap.inpageStyleClass}"/>
        <c:remove var="leadtextMap" scope="request"/>

        <c:set target="${popularItem}" property="count" value="${mostReadArticle.pageviews}"/>
        <c:set var="imageVersion" value="${popularList.imageVersion}"/>

        <c:set target="${popularItem}" property="teaserImageUrl"
               value="${article.fields.alternates.value[imageVersion].href}"/>
        <c:set target="${popularItem}" property="teaserImageAltText" value="${fn:trim(article.fields.alttext.value)}"/>
        <c:set target="${popularItem}" property="teaserImageTitle"
               value="${not empty article.fields.caption.value ? article.fields.caption.value : article.fields.title.value}"/>
        <c:set target="${popularItem}" property="teaserImageWidth"
               value="${article.fields.alternates.value[imageVersion].width}"/>
        <c:set target="${popularItem}" property="teaserImageHeight"
               value="${article.fields.alternates.value[imageVersion].height}"/>
        <c:set target="${popularItem}" property="" value=""/>
        <c:set target="${popularItem}" property="inpageImageClass" value="${article.fields.alternates.value[imageVersion].inpageClasses}"/>

        <c:if test="${popularList.showCommentCount}">
          <wf-core:countArticleComments var="numberOfAllComments" articleId="${article.id}"/>
          <c:set var="commentsLinkUrlSuffix" value="${requestScope.numberOfAllComments==0 ? '#commentsForm' : '#commentsList'}"/>

          <c:url var="commnetsLinkUrl" value="${article.url}">
            <c:param name="tabPane" value="Comments"/>
          </c:url>
          <c:set target="${popularItem}" property="commentsLinkUrl" value="${commnetsLinkUrl}${commentsLinkUrlSuffix}"/>

          <c:set target="${popularItem}" property="commentsLinkText">
            <fmt:message key="popularList.comment.count">
              <fmt:param value="${requestScope.numberOfAllComments}" />
            </fmt:message>
          </c:set>
          <c:remove var="numberOfAllComments" scope="request"/>
        </c:if>

        <collection:add collection="${popularItems}" value="${popularItem}"/>
      </c:when>
      <c:otherwise>
        <c:set target="${popularItem}" property="url" value="${article.url}"/>

        <wf-core:getFieldValueByKey var="titleMap" key="title" articleContent="${article}"/>
        <c:set target="${popularItem}" property="title" value="${titleMap.fieldValue}"/>
        <c:set target="${popularItem}" property="inpageTitleClass" value="${titleMap.inpageStyleClass}"/>
        <c:remove var="titleMap" scope="request"/>

        <wf-core:getFieldValueByKey var="leadtextMap" key="leadtext" articleContent="${article}"/>
        <c:if test="${not empty popularList.maxLeadtextChar}">
          <wf-core:getCurtailedText var="tempCurtailedLeadtext" inputText="${leadtextMap.fieldValue}" maxLength="${popularList.maxLeadtextChar}" ellipsis="..." />
          <c:set target="${leadtextMap}" property="fieldValue" value="${tempCurtailedLeadtext}"/>
          <c:remove var="tempCurtailedLeadtext" scope="request" />
        </c:if>
        <c:set target="${popularItem}" property="leadtext" value="${leadtextMap.fieldValue}"/>
        <c:set target="${popularItem}" property="inpageLeadtextClass" value="${leadtextMap.inpageStyleClass}"/>
        <c:remove var="leadtextMap" scope="request"/>

        <c:set target="${popularItem}" property="count" value="${mostReadArticle.pageviews}"/>

        <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${article.id}"
                                     imageVersion="${popularList.imageVersion}"/>
        <c:if test="${not empty requestScope.teaserImageMap}">
          <c:set target="${popularItem}" property="teaserImageUrl" value="${requestScope.teaserImageMap.url}"/>
          <c:set target="${popularItem}" property="teaserImageAltText" value="${requestScope.teaserImageMap.alttext}"/>
          <c:set target="${popularItem}" property="teaserImageTitle"
                 value="${not empty requestScope.teaserImageMap.caption ? requestScope.teaserImageMap.caption : requestScope.teaserImageMap.title}"/>
          <c:set target="${popularItem}" property="teaserImageWidth" value="${requestScope.teaserImageMap.width}"/>
          <c:set target="${popularItem}" property="teaserImageHeight" value="${requestScope.teaserImageMap.height}"/>
          <c:set target="${popularItem}" property="inpageImageClass" value="${requestScope.teaserImageMap.inpageStyleClass}"/>
        </c:if>
        <c:remove var="teaserImageMap" scope="request"/>

        <wf-core:isVideoArticle var="tempIsVideo" articleContent="${article}"/>
        <c:set target="${popularItem}" property="isVideo" value="${requestScope.tempIsVideo}"/>
        <c:remove var="tempIsVideo"/>

        <c:if test="${popularList.showCommentCount}">
          <wf-core:countArticleComments var="numberOfAllComments" articleId="${article.id}"/>
          <c:set var="commentsLinkUrlSuffix" value="${requestScope.numberOfAllComments==0 ? '#commentsForm' : '#commentsList'}"/>

          <c:url var="commnetsLinkUrl" value="${article.url}">
            <c:param name="tabPane" value="Comments"/>
          </c:url>
          <c:set target="${popularItem}" property="commentsLinkUrl" value="${commnetsLinkUrl}${commentsLinkUrlSuffix}"/>

          <c:set target="${popularItem}" property="commentsLinkText">
            <fmt:message key="popularList.comment.count">
              <fmt:param value="${requestScope.numberOfAllComments}" />
            </fmt:message>
          </c:set>
          <c:remove var="numberOfAllComments" scope="request"/>
        </c:if>

        <collection:add collection="${popularItems}" value="${popularItem}"/>
      </c:otherwise>
    </c:choose>
    <c:remove var="popularItem" scope="page"/>
  </article:use>
</c:forEach>

<c:set target="${popularList}" property="items" value="${popularItems}" />