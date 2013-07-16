<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileTicker/src/main/webapp/template/widgets/mobileTicker/controller/controller.jsp#1 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="mobileTicker" class="java.util.HashMap" scope="request"/>

<c:set target="${mobileTicker}" property="view" value="${widgetContent.fields.view.value}"/>
<c:set target="${mobileTicker}" property="listSort" value="${fn:trim(widgetContent.fields.listSort.value)}"/>

<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentType.value)}" scope="request"/>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="news" scope="request"/>
</c:if>
<c:set target="${mobileTicker}" property="contentType" value="${contentType}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${mobileTicker}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set var="includeSubSections" value="${fn:trim(widgetContent.fields.includeSubsections.value)}"/>
<c:set var="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>

<section:use uniqueName="${mobileTicker.sectionUniqueName}">
  <c:set target="${mobileTicker}" property="sectionId" value="${section.id}"/>
  <c:set target="${mobileTicker}" property="sectionName" value="${section.name}"/>
</section:use>

<c:choose>
  <c:when test="${mobileTicker.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="myGroup"
                            groupName="${groupName}"
                            areaName="${requestScope.contentAreaName}"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${mobileTicker.sectionUniqueName}">
      <wf-core:getPresentationPool var="myPool" section="${section}"/>
    </section:use>
    <wf-core:getGroupByName var="myGroup"
                            groupName="${groupName}"
                            areaName="${requestScope.contentAreaName}"
                            pool="${requestScope.myPool}"/>
    <c:remove var="myPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="articleSummaries" group="${requestScope.myGroup}"
                                    contentType="${mobileTicker.contentType}"/>
<c:remove var="myGroup" scope="request"/>

<c:set target="${mobileTicker}" property="articleSummaries" value="${requestScope.articleSummaries}"/>

<c:set var="begin" value="${fn:trim(widgetContent.fields.begin.value)}"/>
<c:if test="${not empty begin and begin > 0}">
  <c:set var="begin" value="${begin-1}"/>
</c:if>
<c:set var="end" value="${fn:trim(widgetContent.fields.end.value)}"/>
<c:if test="${not empty end and end > 0}">
  <c:set var="end" value="${end-1}"/>
</c:if>
<c:if test="${empty begin or begin >= fn:length(articleSummaries) or begin > end}">
  <c:set var="begin" value="0"/>
</c:if>
<c:if test="${empty end or end >= fn:length(articleSummaries)}">
  <c:set var="end" value="${fn:length(articleSummaries)-1}"/>
</c:if>

<c:set target="${mobileTicker}" property="begin" value="${begin}"/>
<c:set target="${mobileTicker}" property="end" value="${end lt 0 ? 0 : end}"/>
<c:remove var="articleSummaries" scope="request"/>

<c:set target="${mobileTicker}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${mobileTicker}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${mobileTicker}" property="wrapperStyleClass">widget mobileTicker ${mobileTicker.view}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty mobileTicker.customStyleClass}"> ${mobileTicker.customStyleClass}</c:if></c:set>