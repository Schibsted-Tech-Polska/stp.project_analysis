<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userContentManager/src/main/webapp/template/widgets/userContentManager/controller/pictures.jsp#1 $
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
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section"%>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="userContentManager" type="java.util.HashMap" scope="request"/>

<%-- put the values of view specific fields / properties in the map --%>
<c:set var="addPictureSectionUniqueName" value="savePicture"/>

<c:set target="${userContentManager}" property="contentTypes" value="${fn:trim(widgetContent.fields.contentTypesPictures.value)}"/>

<c:set var="imageVersionPictures" value="${fn:trim(widgetContent.fields.imageVersionPictures.value)}"/>
<c:if test="${empty imageVersionPictures}">
  <c:set var="imageVersionPictures" value="w80"/>
</c:if>
<c:set target="${userContentManager}" property="imageVersionPictures" value="${imageVersionPictures}"/>

<c:set target="${userContentManager}" property="showCaptionPictures" value="${fn:trim(widgetContent.fields.showCaptionPictures.value)}"/>
<c:set target="${userContentManager}" property="showCreationTimePictures" value="${fn:trim(widgetContent.fields.showCreationTimePictures.value)}"/>
<c:set target="${userContentManager}" property="showTimeDifferencePictures" value="${fn:trim(widgetContent.fields.showTimeDifferencePictures.value)}"/>

<c:set var="creationTimeFormatPictures" value="${fn:trim(widgetContent.fields.creationTimeFormatPictures.value)}"/>
<c:if test="${empty creationTimeFormatPictures}">
  <c:set var="creationTimeFormatPictures" value="MMM dd, yyyy hh:mm a"/>
</c:if>
<c:set target="${userContentManager}" property="creationTimeFormatPictures" value="${creationTimeFormatPictures}"/>

<c:set target="${userContentManager}" property="showEditLinkPictures" value="${fn:trim(widgetContent.fields.showEditLinkPictures.value)}"/>

<c:set var="editLinkTextPictures">
  <fmt:message key="userContentManager.widget.pictures.edit.label"/>
</c:set>
<c:set target="${userContentManager}" property="editLinkTextPictures" value="${editLinkTextPictures}"/>

<c:set target="${userContentManager}" property="showPostLinkPictures"
       value="${fn:trim(widgetContent.fields.showPostLinkPictures.value)}"/>
<c:set var="postLinkTextPictures">
  <fmt:message key="userContentManager.widget.pictures.post.label"/>
</c:set>
<c:set target="${userContentManager}" property="postLinkTextPictures" value="${postLinkTextPictures}"/>

<c:set target="${userContentManager}" property="allowDeletionPictures" value="${fn:trim(widgetContent.fields.allowDeletionPictures.value)}"/>
<c:set var="deletePicturesLinkTextPictures">
  <fmt:message key="userContentManager.widget.pictures.delete.label"/>
</c:set>
<c:set target="${userContentManager}" property="deletePicturesLinkTextPictures" value="${deletePicturesLinkTextPictures}"/>
<c:set target="${userContentManager}" property="bulkDeleteArticleAction" value="/community/bulkDeleteArticles"/>
<c:set target="${userContentManager}" property="bulkDeleteArticleSuccessUrl" value="${section.url}"/>
<c:set target="${userContentManager}" property="bulkDeleteArticleErrorUrl" value="${section.url}"/>

  <c:set var="addPictureLinkTextPictures">
    <fmt:message key="userContentManager.widget.pictures.add.label"/>
  </c:set>
<c:set target="${userContentManager}" property="addPictureLinkTextPictures" value="${addPictureLinkTextPictures}"/>

<%--create list of all pictures in the home section of the user --%>
<collection:createList id="pictures" type="java.util.ArrayList"/>
<profile:present>
  <jsp:useBean id="currentDate" class="java.util.Date"/>
  <section:use uniqueName="${user.userName}">
    <article:list id="userUploadedPictures"
                  sectionUniqueName="${section.uniqueName}"
                  includeSubSections="true"
                  includeArticleTypes="${userContentManager.contentTypes}"
                  sort="-publishDate"
                  from="${requestScope.articleListDateString}"/>
    
    <c:forEach items="${userUploadedPictures}" var="userUploadedPicture">
      <jsp:useBean id="picture" class="java.util.HashMap" scope="page"/>
      <c:set target="${picture}" property="contentUrl" value="${userUploadedPicture.url}"/>
      <c:set target="${picture}" property="id" value="${userUploadedPicture.id}"/>
      <c:if test="${(not empty userUploadedPicture.fields.alternates) and (not empty userUploadedPicture.fields.alternates.value)
		      and (not empty userUploadedPicture.fields.alternates.value[imageVersionPictures])}">
        <c:set target="${picture}" property="src" value="${userUploadedPicture.fields.alternates.value[imageVersionPictures].href}"/>
      </c:if>

      <c:if test="${not empty fn:trim(userUploadedPicture.fields.alttext)}">
        <c:set target="${picture}" property="altText" value="${fn:trim(userUploadedPicture.fields.alttext.value)}"/>
      </c:if>

      <c:if test="${not empty fn:trim(userUploadedPicture.fields.caption)}">
        <c:set target="${picture}" property="caption" value="${fn:trim(userUploadedPicture.fields.caption.value)}"/>
      </c:if>

      <c:if test="${(not empty userUploadedPicture.fields.alternates) and (not empty userUploadedPicture.fields.alternates.value)
 		      and (not empty userUploadedPicture.fields.alternates.value[imageVersionPictures])}">
        <c:set target="${picture}" property="width" value="${userUploadedPicture.fields.alternates.value[imageVersionPictures].width}"/>
        <c:set target="${picture}" property="height" value="${userUploadedPicture.fields.alternates.value[imageVersionPictures].height}"/>
      </c:if>

      <c:set var="creationTimeText" value=""/>
      <c:set var="creationDate" value="${userUploadedPicture.createdDateAsDate}"/>
      <c:choose>
        <c:when test="${userContentManager['showTimeDifferencePictures'] != 'true' }">
          <c:set var="creationTimeText">
            <fmt:formatDate value="${creationDate}" pattern="${userContentManager['creationTimeFormatPictures']}"/>
          </c:set>
        </c:when>
        <c:otherwise>
          <wf-core:getDateDifference var="tempCreationTimeText" from="${creationDate}" to="${currentDate}"/>
          <c:set var="creationTimeText" value="${tempCreationTimeText}"/>
          <c:remove var="tempCreationTimeText" scope="request"/>
        </c:otherwise>
      </c:choose>
      <c:set target="${picture}" property="creationTimeText" value="${creationTimeText}"/>

      <collection:add collection="${pictures}" value="${picture}"/>
      <c:remove var="picture" scope="page"/>
    </c:forEach>

  </section:use>
</profile:present>
<c:set target="${userContentManager}" property="pictures" value="${pictures}"/>
<c:set target="${userContentManager}" property="pictureCount" value="${fn:length(pictures)}"/>

<section:use uniqueName="${addPictureSectionUniqueName}">
  <c:set target="${userContentManager}" property="addPictureUrl" value="${section.url}"/>
</section:use>

<%-- todo make the inline picture width configurable --%>
<c:set target="${userContentManager}" property="inlinePictureWidth" value="300"/>