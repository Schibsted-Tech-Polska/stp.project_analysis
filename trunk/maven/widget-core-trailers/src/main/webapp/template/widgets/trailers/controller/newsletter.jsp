<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/controller/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- declare the map that will contain relevant field values--%>
<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>

<%--read field values specific to this view --%>
<c:set target="${trailers}" property="maxTrailers" value="${fn:trim(widgetContent.fields.maxTrailersNewsletter.value)}"/>
<c:set target="${trailers}" property="showSectionName" value="${widgetContent.fields.showSectionNameNewsletter.value}"/>
<c:set target="${trailers}" property="showComments" value="${fn:trim(widgetContent.fields.showCommentCountNewsletter.value)}" />
<c:set target="${trailers}" property="trailerWidthNewsletter" value="${widgetContent.fields.trailerWidthRow.value}"/>
<c:set target="${trailers}" property="imagePositionNewsletter"
       value="${fn:trim(widgetContent.fields.imagePositionRow.value)}"/>
<c:set target="${trailers}" property="showTitleNewsletter" value="${widgetContent.fields.showTitleRow.value}"/>
<c:set target="${trailers}" property="showIntroNewsletter" value="${widgetContent.fields.showIntroRow.value}"/>
<c:set target="${trailers}" property="maxCharactersNewsletter"
       value="${fn:trim(widgetContent.fields.maxCharactersRow)}"/>

<!--for row view, set maxItems to 1 -->
<c:set target="${trailers}" property="maxItems" value="1"/>

<!--get the articles from the specified group -->
<c:choose>
  <c:when test="${trailers.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="myGroup"
                              groupName="${trailers.groupName}"
                              areaName="${requestScope.contentAreaName}"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${trailers.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>
    <wf-core:getGroupByName var="myGroup"
                              groupName="${trailers.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="groupArticleSummaries" group="${requestScope.myGroup}"
                                      contentType="${trailers.contentType}"/>
<c:remove var="myGroup" scope="request"/>

<c:set var="articleListSize" value="${fn:length(groupArticleSummaries)}"/>

<c:choose>
  <c:when test="${trailers.maxTrailers > articleListSize}">
    <c:set target="${trailers}" property="trailerColumnCount" value="${articleListSize}"/>
  </c:when>
  <c:otherwise>
    <c:set target="${trailers}" property="trailerColumnCount" value="${trailers.maxTrailers}"/>
  </c:otherwise>
</c:choose>

<collection:createList id="articleMapList" type="java.util.ArrayList" toScope="page"/>

<c:forEach var="articleSummary" items="${requestScope.groupArticleSummaries}" varStatus="loopStatus">
  <c:if test="${loopStatus.count <= trailers.trailerColumnCount}">
    <collection:createMap id="articleMap" type="java.util.HashMap" toScope="page"/>

    <%--<c:choose>
      <c:when test="${loopStatus.first}">
        <c:set target="${articleMap}" property="trailerStyleClass" value="first"/>
      </c:when>
      <c:when test="${loopStatus.count eq trailers.trailerColumnCount}">
        <c:set target="${articleMap}" property="trailerStyleClass" value="last"/>
      </c:when>
    </c:choose>

    <c:set target="${articleMap}" property="articleStyleClass" value="first"/>--%>

    <%-- put image version and image related attributes in the map --%>
    <c:set var="articleAttributeMap" value="${articleMap}" scope="request"/>
    <jsp:include page="helpers/imageVersionInNewsletterView.jsp"/>
    <c:remove var="articleAttributeMap" scope="request"/>

    <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"/>
    <c:set target="${articleMap}" property="teaserImageMap" value="${requestScope.teaserImageMap}"/>
    <c:remove var="teaserImageMap" scope="request"/>

    <%--put attributes of article in the map --%>
    <c:set target="${articleMap}" property="articleId" value="${articleSummary.content.id}"/>
    <c:set target="${articleMap}" property="url" value="${articleSummary.content.url}"/>
    <c:set target="${articleMap}" property="homeSectionName" value="${articleSummary.content.homeSection.name}"/>

    <wf-core:handleLineBreaks var="title" value="${fn:trim(articleSummary.fields.title.value)}"/>
    <c:set target="${articleMap}" property="title" value="${requestScope.title}"/>
    <c:remove var="title" scope="request"/>

    <wf-core:getCurtailedText var="intro" inputText="${fn:trim(articleSummary.fields.leadtext.value)}"
                                maxLength="${trailers.maxCharactersRow}"/>
    <c:set target="${articleMap}" property="intro" value="${requestScope.intro}"/>
    <c:remove var="intro" scope="request"/>
    <c:if test="${trailers.showComments}">
      <wf-core:countArticleComments var="numOfComments" articleId="${articleSummary.content.id}"/>
      <c:set target="${articleMap}" property="numOfComments" value="${numOfComments}"/>
      <c:remove var="numOfComments" scope="request"/>
    </c:if>

    <collection:add collection="${articleMapList}" value="${articleMap}"/>
    <c:remove var="articleMap" scope="page"/>
  </c:if>
</c:forEach>

<c:set target="${trailers}" property="articleMapList" value="${articleMapList}"/>
<c:remove var="groupArticleSummaries" scope="request"/>
