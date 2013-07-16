<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/controller/article.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="storyContent" type="java.util.Map" scope="request" />

<%-- put the values of view specific fields / properties in the map --%>
<c:set target="${storyContent}" property="selectedFields" value="${widgetContent.fields.storyFields.value}"/>

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

    <c:when test="${currentField eq 'tags'}">
      <c:set target="${storyContent}" property="tagList" value="${article.tags}"/>
    </c:when>
  </c:choose>
</c:forEach>
