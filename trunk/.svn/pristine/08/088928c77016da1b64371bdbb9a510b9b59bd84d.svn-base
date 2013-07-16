<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userContentManager/src/main/webapp/template/widgets/userContentManager/controller/blogPost.jsp#1 $
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


<profile:present>
  <%-- declare the map that contains relevant field values--%>
  <jsp:useBean id="userContentManager" type="java.util.HashMap" scope="request"/>
  
  <c:set target="${userContentManager}" property="contentTypes" value="${fn:trim(widgetContent.fields.contentTypesBlogPost.value)}"/>
  <!--read status filter parameter (possible values: published, draft, all)-->
  <c:set var="statusParam" value="${fn:trim(param.status)}"/>
  <c:choose>
    <c:when test="${statusParam == 'published'}">
      <c:set var="archiveHeading">
        <fmt:message key="userContentManager.widget.blogPost.publishedBlogPosts.heading"/>
      </c:set>
    </c:when>
    <c:when test="${statusParam == 'draft'}">
      <c:set var="archiveHeading">
        <fmt:message key="userContentManager.widget.blogPost.draftBlogPosts.heading"/>
      </c:set>
    </c:when>
    <c:otherwise>
      <c:set var="statusParam" value="all"/>
      <c:set var="archiveHeading">
        <fmt:message key="userContentManager.widget.blogPost.allBlogPosts.heading"/>
      </c:set>
    </c:otherwise>
  </c:choose>
  <c:set target="${userContentManager}" property="statusParam" value="${statusParam}"/>
  <c:set target="${userContentManager}" property="archiveHeading" value="${archiveHeading}"/>

  <%-- put the values of view specific fields / properties in the map --%>
  <c:set target="${userContentManager}" property="showDeleteButton"
         value="${fn:trim(widgetContent.fields.allowDeletionBlogPost.value)}"/>

  <c:set target="${userContentManager}" property="showCreationDate"
         value="${fn:trim(widgetContent.fields.showCreationDateBlogPost.value)}"/>

  <c:set target="${userContentManager}" property="showTimeDifference"
         value="${fn:trim(widgetContent.fields.showTimeDifferenceBlogPost.value)}"/>

  <c:set target="${userContentManager}" property="creationTimeTextStyle"
         value="${fn:trim(widgetContent.fields.creationTimeTextStyleBlogPost.value)}"/>
  <c:set var="creationTimeFormat" value="${fn:trim(widgetContent.fields.creationTimeFormatBlogPost.value)}"/>
  <c:if test="${empty creationTimeFormat}">
    <c:set var="creationTimeFormat" value="MMM dd, yyyy hh:mm a"/>
  </c:if>
  <c:set target="${userContentManager}" property="creationTimeFormat" value="${creationTimeFormat}"/>

  <c:set target="${userContentManager}" property="showEditColumn"
         value="${fn:trim(widgetContent.fields.showEditColumnBlogPost.value)}"/>

  <c:set var="addNewsSectionUniqueName" value="saveBlogPost"/>
  <section:use uniqueName="${addNewsSectionUniqueName}">
    <c:set target="${userContentManager}" property="addNewsUrl" value="${section.url}"/>
  </section:use>

  <c:set target="${userContentManager}" property="currentUrl" value="${section.url}"/>

  <%--create list of all news in the home section of the user --%>
  <collection:createList id="newsAll" type="java.util.ArrayList"/>

  <jsp:useBean id="currentDate" class="java.util.Date"/>
  <section:use uniqueName="${user.userName}">

    <c:set var="bringOnlyLiveNews" value="${statusParam == 'published'}"/>
    <article:list id="userUploadedAllNews"
                  sectionUniqueName="${section.uniqueName}"
                  includeSubSections="true"
                  includeArticleTypes="${userContentManager.contentTypes}"
                  sort="-lastChangedDate"
                  onlyLive="${bringOnlyLiveNews}"
                  from="${requestScope.articleListDateString}"/>
    <c:forEach items="${userUploadedAllNews}" var="userUploadedNews">

      <c:set var="addCurrentNews" value="true"/>
      <c:if test="${statusParam=='draft' and userUploadedNews.stateName=='published'}">
        <c:set var="addCurrentNews" value="false"/>
      </c:if>

      <c:if test="${addCurrentNews == 'true'}">
        <jsp:useBean id="news" class="java.util.HashMap"/>
        <c:set target="${news}" property="contentUrl" value="${userUploadedNews.url}"/>
        <c:set target="${news}" property="id" value="${userUploadedNews.id}"/>
        <c:set target="${news}" property="title" value="${fn:trim(userUploadedNews.fields.title)}"/>
        <c:set target="${news}" property="state"
               value="${fn:toLowerCase(fn:trim(userUploadedNews.stateName))}"/>

        <c:set var="creationTimeText" value=""/>
        <c:set var="creationDate" value="${userUploadedNews.createdDateAsDate}"/>
        <c:set target="${news}" property="dateString">
            <fmt:formatDate value="${creationDate}" pattern="yyyyMMddhhmmss"/>
       </c:set>
        <c:choose>
          <c:when test="${userContentManager.showTimeDifference == 'false' }">
            <c:set var="creationTimeText">
              <fmt:formatDate value="${creationDate}" pattern="${userContentManager['creationTimeFormat']}"/>
            </c:set>
          </c:when>
          <c:otherwise>
            <wf-core:getDateDifference var="tempCreationTimeText" from="${creationDate}" to="${currentDate}"/>
            <c:set var="creationTimeText" value="${tempCreationTimeText}"/>
            <c:remove var="tempCreationTimeText" scope="request"/>
          </c:otherwise>
        </c:choose>
        <c:set target="${news}" property="creationTimeText" value="${creationTimeText}"/>
        <c:set target="${news}" property="article" value="${userUploadedNews}"/>
        <collection:add collection="${newsAll}" value="${news}"/>
        <c:remove var="news"/>
      </c:if>

    </c:forEach>

  </section:use>
  <c:set target="${userContentManager}" property="newsCount" value="${fn:length(newsAll)}"/>
  <c:set target="${userContentManager}" property="newsAll" value="${newsAll}"/>
  <c:set target="${userContentManager}" property="bulkDeleteArticleAction" value="/community/bulkDeleteArticles"/>
  <c:set target="${userContentManager}" property="bulkDeleteArticleSuccessUrl" value="${section.url}"/>
  <c:set target="${userContentManager}" property="bulkDeleteArticleErrorUrl" value="${section.url}"/>

</profile:present>