<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-poll/src/main/webapp/template/widgets/poll/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the default view of the poll widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="poll" uri="http://www.escenic.com/taglib/escenic-poll" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'poll' in the requestScope --%>
<jsp:useBean id="poll" type="java.util.HashMap" scope="request"/>

<!--read view specific configurations-->
<c:set target="${poll}" property="max" value="${fn:trim(widgetContent.fields.maxPolls)}"/>
<c:set target="${poll}" property="showWidgetName" value="${fn:trim(widgetContent.fields.showWidgetName)}"/>
<c:set target="${poll}" property="voteMultipleTimes" value="${fn:trim(widgetContent.fields.voteMultipleTimes)}"/>

<c:set target="${poll}" property="widgetName" value="${fn:trim(element.fields.title.value)}"/>

<c:choose>
  <c:when test="${poll.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="targetGroup"
                              groupName="${poll.groupName}"
                              areaName="${requestScope.contentAreaName}" />
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${poll.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>

    <wf-core:getGroupByName var="targetGroup"
                              groupName="${poll.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="pollArticleSummaryList" group="${targetGroup}" contentType="${poll.contentType}" max="${poll.max}"/>
<c:remove var="targetGroup" scope="request"/>

<c:choose>
  <c:when test="${requestScope['com.escenic.context']=='art'}">
    <c:set var="pageUrl" value="${article.url}" />
  </c:when>
  <c:otherwise>
    <c:set var="pageUrl" value="${section.url}" />
  </c:otherwise>
</c:choose>

<collection:createList id="pollItems" type="java.util.ArrayList"/>

<c:forEach var="pollArticleSummary" items="${pollArticleSummaryList}">
  <jsp:useBean id="pollItem" class="java.util.HashMap" />

  <c:set var="pollContentId" value="${pollArticleSummary.content.id}" />

  <c:set var="pollStyleId" value="poll${widgetContent.id}${pollContentId}" />
  <c:set target="${pollItem}" property="styleId" value="${pollStyleId}"/>

  <c:set target="${pollItem}" property="headline" value="${fn:trim(pollArticleSummary.fields.headline)}"/>
  <c:set target="${pollItem}" property="question" value="${fn:trim(pollArticleSummary.fields.question)}"/>
  <c:set target="${pollItem}" property="inpageHeadlineClass" value="${pollArticleSummary.fields.headline.options.inpageClasses}"/>
  <c:set target="${pollItem}" property="inpageQuestionClass" value="${pollArticleSummary.fields.question.options.inpageClasses}"/>

  <c:set var="pollFormUrl" value="${pageUrl}${'#'}${pollStyleId}" />
  <c:set target="${pollItem}" property="url" value="${pollFormUrl}"/>

  <c:set target="${pollItem}" property="revoteUrl" value="${pageUrl}?revote=true${'#'}${pollStyleId}"/>

  <c:url var="pollRevoteUrl" value="${pageUrl}">
    <c:param name="revote" value="${true}" />
  </c:url>
  <c:set target="${pollItem}" property="revoteUrl" value="${pollRevoteUrl}${'#'}${pollStyleId}"/>

  <c:url var="pollResultUrl" value="${pageUrl}">
    <c:param name="pollResult" value="${pollContentId}" />
  </c:url>
  <c:set var="pollResultUrl" value="${pollResultUrl}${'#'}${pollStyleId}"/>
  <c:set target="${pollItem}" property="resultUrl" value="${pollResultUrl}"/>

  <poll:use id="mentometer" articleId="${pollContentId}">
    <c:set target="${pollItem}" property="mentometer" value="${mentometer}"/>
    <c:set target="${pollItem}" property="mode" value="${mode}"/>

    <c:choose>
      <c:when test="${mode == 'voted' or param.pollResult == pollContentId}">
        <c:set target="${poll}" property="view" value="default_result"/>
      </c:when>
      <c:otherwise>
        <c:set target="${poll}" property="view" value="default_form"/>
      </c:otherwise>
    </c:choose>
  </poll:use>

  <collection:add collection="${pollItems}" value="${pollItem}" />
  <c:remove var="pollItem" scope="page" />
</c:forEach>

<c:set target="${poll}" property="items" value="${pollItems}"/>

<c:if test="${fn:length(pollItems) == 0}">
  <c:set target="${poll}" property="view" value="default_form"/>
</c:if>
