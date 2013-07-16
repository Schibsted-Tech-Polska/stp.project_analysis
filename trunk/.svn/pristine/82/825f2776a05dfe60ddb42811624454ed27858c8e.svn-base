<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStoryContent/src/main/webapp/template/widgets/mobileStoryContent/controller/section.jsp#1 $
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
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="mobileStoryContent" type="java.util.Map" scope="request" />

<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}" scope="request"/>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news" scope="request" />
</c:if>
<c:set target="${mobileStoryContent}" property="contentType" value="${contentType}" />

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${mobileStoryContent}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<%-- find out which article we should display --%>
<c:set target="${mobileStoryContent}" property="source" value="${widgetContent.fields.source.value}"/>

<c:choose>
  <c:when test="${mobileStoryContent.source eq 'desked'}">
  	<%-- generating the widget using desked content source: display the first article you can find in the group --%>
  	<c:set var="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}" />
  	<c:if test="${not empty groupName}">
      <c:choose>
        <c:when test="${mobileStoryContent.sectionUniqueName == section.uniqueName}">
          <wf-core:getGroupByName var="myGroup"
                                    groupName="${groupName}"
                                    areaName="${requestScope.contentAreaName}"/>
        </c:when>
        <c:otherwise>
          <section:use uniqueName="${mobileStoryContent.sectionUniqueName}">
            <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
          </section:use>

          <wf-core:getGroupByName var="myGroup"
                                    groupName="${groupName}"
                                    areaName="${requestScope.contentAreaName}"
                                    pool="${targetSectionPool}"/>
          <c:remove var="targetSectionPool" scope="request"/>
        </c:otherwise>
      </c:choose>
      <%-- now that we have the group, let's get the first article --%>
      <wf-core:getArticlesInGroup var="articleList" group="${myGroup}" contentType="${mobileStoryContent.contentType}" max="1" />
      <c:remove var="myGroup" scope="request"/>
      <c:forEach var="currentItem" items="${articleList}">
	    <c:set var="currentArticle" value="${currentItem}" scope="request" />
      </c:forEach>
    </c:if>
  </c:when>
  <c:when test="${mobileStoryContent.source eq 'articleId'}">
  	<%-- generating the widget using article id --%>
  	<c:set target="${mobileStoryContent}" property="articleId" value="${widgetContent.fields.articleId.value}"/>
  	<article:use articleId="${mobileStoryContent.articleId}">
  	  <c:set var="currentArticle" value="${article}" scope="request" />
  	</article:use>
  </c:when>
  <c:otherwise>
  	<%-- generating the widget using automatic source: basically take the first article you can find --%>
  	<c:set var="listSort" value="${widgetContent.fields.listSort.value}" scope="page" />
    <c:choose>
      <c:when test="${not empty mobileStoryContent.sectionUniqueName}">
        <section:use uniqueName="${mobileStoryContent.sectionUniqueName}">
          <article:list id="articleList"
                        sectionUniqueName="${mobileStoryContent.sectionUniqueName}"
                        max="1"
                        sort="${listSort}"
                        includeArticleTypes="${mobileStoryContent.contentType}"
                        all="true"
                        homeSectionOnly="true"
                        from="${requestScope.articleListDateString}"/>
        </section:use>
      </c:when>
      <c:otherwise>
        <article:list id="articleList"
                      max="1"
                      sort="${listSort}"
                      includeArticleTypes="${mobileStoryContent.contentType}"
                      all="true"
                      homeSectionOnly="true"
                      from="${requestScope.articleListDateString}"/>
      </c:otherwise>
    </c:choose>

    <%-- now we have the list of one article, let's get the article itself --%>
    <c:forEach var="currentItem" items="${articleList}">
	  <c:set var="currentArticle" value="${currentItem}" scope="request" />
    </c:forEach>

  </c:otherwise>
</c:choose>

<%-- put the values of view specific fields / properties in the map --%>
<c:set target="${mobileStoryContent}" property="selectedFields" value="${widgetContent.fields.storyFieldsSection.value}"/>

<c:if test="${not empty currentArticle}">
  <article:use article="${currentArticle}">
    <c:forEach var="currentField" items="${mobileStoryContent.selectedFields}">
      <c:choose>
        <c:when test="${currentField eq 'title'}">
          <wf-core:handleLineBreaks var="titleFieldValue" value="${fn:trim(article.fields.title.value)}"/>
          <c:set target="${mobileStoryContent}" property="title" value="${requestScope.titleFieldValue}"/>
          <c:remove var="titleFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'subtitle'}">
          <wf-core:handleLineBreaks var="subtitleFieldValue" value="${fn:trim(article.fields.subtitle.value)}"/>
          <c:set target="${mobileStoryContent}" property="subtitle" value="${requestScope.subtitleFieldValue}"/>
          <c:remove var="subtitleFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'byline'}">
          <c:set var="bylinePrefix" value="${fn:trim(article.fields.bylinePrefix.value)}"/>
          <c:if test="${empty bylinePrefix}">
            <c:set var="bylinePrefix" value="By"/>
          </c:if>
          <c:set target="${mobileStoryContent}" property="bylinePrefix" value="${bylinePrefix}"/>

          <c:set var="byline" value="${fn:trim(article.fields.byline.value)}"/>
          <c:if test="${empty byline}">
            <c:set var="byline" value="${article.author.name}"/>
          </c:if>
          <c:set target="${mobileStoryContent}" property="byline" value="${byline}"/>
        </c:when>
        <c:when test="${currentField eq 'dateline'}">
          <c:set target="${mobileStoryContent}" property="publishedDate">
            <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${mobileStoryContent.dateFormat}"/>
          </c:set>
          <c:set target="${mobileStoryContent}" property="lastModifiedDate">
            <fmt:formatDate value="${article.lastModifiedDateAsDate}" pattern="${mobileStoryContent.dateFormat}"/>
          </c:set>
        </c:when>
        <c:when test="${currentField eq 'leadtext'}">
          <wf-core:handleLineBreaks var="leadtextFieldValue" value="${fn:trim(article.fields.leadtext.value)}"/>
          <c:set target="${mobileStoryContent}" property="leadtext" value="${requestScope.leadtextFieldValue}"/>
          <c:remove var="leadtextFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'quote'}">
          <c:set target="${mobileStoryContent}" property="quote" value="${fn:trim(article.fields.quote.value)}"/>
        </c:when>
      </c:choose>
    </c:forEach>
  </article:use>
</c:if>