<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-tickertape/src/main/webapp/template/widgets/tickertape/controller/default.jsp#1 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- declare the map that will contain field values/collections used by the view--%>
<jsp:useBean id="tickertape" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${tickertape.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="targetGroup"
                              groupName="${tickertape.groupName}"
                              areaName="${requestScope.contentAreaName}"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${tickertape.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>

    <wf-core:getGroupByName var="targetGroup"
                              groupName="${tickertape.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="articleSummaryList" group="${targetGroup}" contentType="${tickertape.contentType}"/>
<c:remove var="targetGroup" scope="request"/>

<c:set target="${tickertape}" property="articleSummaryList" value="${requestScope.articleSummaryList}" />
<c:remove var="articleSummaryList" scope="request" />

<c:set target="${tickertape}" property="uniqueSuffix" value="${requestScope.currentAreaName}-${widgetContent.id}" />