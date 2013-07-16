<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/groupedContent.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<jsp:useBean id="list" type="java.util.HashMap" scope="request"/>

<c:choose>
  <c:when test="${list.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="targetGroup"
                              groupName="${list.groupName}"
                              areaName="${requestScope.contentAreaName}" />
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${list.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>

    <wf-core:getGroupByName var="targetGroup"
                              groupName="${list.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${list.contentType=='picture'}">
    <wf-core:getPicturesInGroup var="resultList" group="${targetGroup}" contentType="${list.contentType}"
                                max="${list.itemCount}" includeArticleRelatedPictures="${true}"/>
  </c:when>
  <c:otherwise>
    <wf-core:getArticleSummariesInGroup var="resultList" group="${targetGroup}" contentType="${list.contentType}" max="${list.itemCount}" />
  </c:otherwise>
</c:choose>

<c:set var="areaName" value="${list.groupName}-area"/>
<c:set target="${list}" property="inpageDnDAreaClass" value="${requestScope.targetGroup.areas[areaName].options.inpageClasses}"/>

<c:remove var="targetGroup" scope="request"/>