<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/controller/section.jsp#1 $
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
<jsp:useBean id="storyContent" type="java.util.Map" scope="request" />

<c:set target="${storyContent}" property="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}" />

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${storyContent}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<%-- find out which article we should display --%>
<c:set target="${storyContent}" property="source" value="${widgetContent.fields.source.value}"/>

<c:choose>
  <c:when test="${storyContent.source eq 'desked'}">
  	<%-- generating the widget using desked content source: display the first article you can find in the group --%>
  	<c:set var="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}" />
  	<c:if test="${not empty groupName}">
      <c:choose>
        <c:when test="${storyContent.sectionUniqueName == section.uniqueName}">
          <wf-core:getGroupByName var="myGroup"
                                    groupName="${groupName}"
                                    areaName="${requestScope.contentAreaName}"/>
        </c:when>
        <c:otherwise>
          <section:use uniqueName="${storyContent.sectionUniqueName}">
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
      <wf-core:getArticlesInGroup var="articleList" group="${myGroup}" contentType="${storyContent.contentType}" max="1" />
      <c:remove var="myGroup" scope="request"/>
      <c:forEach var="currentItem" items="${articleList}">
	    <c:set var="currentArticle" value="${currentItem}" scope="request" />
      </c:forEach>
    </c:if>
  </c:when>
  <c:when test="${storyContent.source eq 'articleId'}">
  	<%-- generating the widget using article id --%>
  	<c:set target="${storyContent}" property="articleId" value="${widgetContent.fields.articleId.value}"/>
  	<article:use articleId="${storyContent.articleId}">
  	  <c:set var="currentArticle" value="${article}" scope="request" />
  	</article:use>
  </c:when>
  <c:otherwise>
  	<%-- generating the widget using automatic source: basically take the first article you can find --%>
  	<c:set var="listSort" value="${widgetContent.fields.listSort.value}" scope="page" />
    <c:choose>
      <c:when test="${not empty storyContent.sectionUniqueName}">
        <section:use uniqueName="${storyContent.sectionUniqueName}">
          <article:list id="articleList"
                        sectionUniqueName="${storyContent.sectionUniqueName}"
                        max="1"
                        sort="${listSort}"
                        includeArticleTypes="${storyContent.contentType}"
                        all="true"
                        homeSectionOnly="true"
                        from="${requestScope.articleListDateString}"/>
        </section:use>
      </c:when>
      <c:otherwise>
        <article:list id="articleList"
                      max="1"
                      sort="${listSort}"
                      includeArticleTypes="${storyContent.contentType}"
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
<c:set target="${storyContent}" property="selectedFields" value="${widgetContent.fields.storyFieldsSection.value}"/>

<c:if test="${not empty currentArticle}">
  <article:use article="${currentArticle}">
    <c:forEach var="currentField" items="${storyContent.selectedFields}">
      <c:choose>
        <c:when test="${currentField eq 'title'}">
          <wf-core:handleLineBreaks var="titleFieldValue" value="${fn:trim(article.fields.title.value)}"/>
          <c:set target="${storyContent}" property="title" value="${requestScope.titleFieldValue}"/>
          <c:set target="${storyContent}" property="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
          <c:remove var="titleFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'subtitle'}">
          <wf-core:handleLineBreaks var="subtitleFieldValue" value="${fn:trim(article.fields.subtitle.value)}"/>
          <c:set target="${storyContent}" property="subtitle" value="${requestScope.subtitleFieldValue}"/>
          <c:set target="${storyContent}" property="inpageSubtitleClass" value="${article.fields.subtitle.options.inpageClasses}"/>
          <c:remove var="subtitleFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'byline'}">
          <c:set var="bylinePrefix" value="${fn:trim(article.fields.bylinePrefix.value)}"/>
          <c:if test="${empty bylinePrefix}">
            <c:set var="bylinePrefix" value="By"/>
          </c:if>
          <c:set target="${storyContent}" property="bylinePrefix" value="${bylinePrefix}"/>

          <c:set var="byline" value="${fn:trim(article.fields.byline.value)}"/>
          <c:if test="${empty byline}">
            <c:set var="byline" value="${article.author.name}"/>
          </c:if>
          <c:set target="${storyContent}" property="byline" value="${byline}"/>
        </c:when>
        <c:when test="${currentField eq 'dateline'}">
          <c:set target="${storyContent}" property="publishedDate">
            <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${storyContent.dateFormat}"/>
          </c:set>
          <c:set target="${storyContent}" property="lastModifiedDate">
            <fmt:formatDate value="${article.lastModifiedDateAsDate}" pattern="${storyContent.dateFormat}"/>
          </c:set>
        </c:when>
        <c:when test="${currentField eq 'leadtext'}">
          <wf-core:handleLineBreaks var="leadtextFieldValue" value="${fn:trim(article.fields.leadtext.value)}"/>
          <c:set target="${storyContent}" property="leadtext" value="${requestScope.leadtextFieldValue}"/>
          <c:set target="${storyContent}" property="inpageLeadtextClass" value="${article.fields.leadtext.options.inpageClasses}"/>
          <c:remove var="leadtextFieldValue" scope="request"/>
        </c:when>
        <c:when test="${currentField eq 'quote'}">
          <c:set target="${storyContent}" property="quote" value="${fn:trim(article.fields.quote.value)}"/>
          <c:set target="${storyContent}" property="inpageQuoteClass" value="${article.fields.quote.options.inpageClasses}"/>
        </c:when>
      </c:choose>
    </c:forEach>
  </article:use>
</c:if>