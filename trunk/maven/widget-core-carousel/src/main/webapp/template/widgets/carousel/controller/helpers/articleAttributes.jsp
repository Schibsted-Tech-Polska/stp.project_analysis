<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/controller/helpers/articleAttributes.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection"%>

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>
<collection:createList id="mapList" type="java.util.ArrayList" toScope="request"/>

<c:choose>
  <c:when test="${requestScope.sectionUniqueName == section.uniqueName}">
    <wf-core:getGroupByName var="targetGroup"
                              groupName="${requestScope.groupName}"
                              areaName="${requestScope.contentAreaName}"/>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${requestScope.sectionUniqueName}">
      <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
    </section:use>

    <wf-core:getGroupByName var="targetGroup"
                              groupName="${requestScope.groupName}"
                              areaName="${requestScope.contentAreaName}"
                              pool="${targetSectionPool}"/>
    <c:remove var="targetSectionPool" scope="request"/>
  </c:otherwise>
</c:choose>

<wf-core:getArticleSummariesInGroup var="articleSummaries" group="${targetGroup}" contentType="${requestScope.contentTypes}"/>
<c:remove var="targetGroup" scope="request"/>

<c:if test="${not empty requestScope.articleSummaries}">
  <c:set var="counter" value="0" scope="request"/>
  <c:forEach var="articleSummary" items="${requestScope.articleSummaries}">

    <c:if test="${counter lt requestScope.max}">
      <c:set var="cArticle" value="${articleSummary.content}" scope="request"/>
      <c:set var="articleSummary" value="${articleSummary}" scope="request"/>
      <c:choose>
        <c:when test="${cArticle.articleTypeName == 'gallery'}">
          <jsp:include page="gallery.jsp"/>
        </c:when>
        <c:otherwise>
          <jsp:include page="others.jsp"/>
        </c:otherwise>
      </c:choose>
      <c:remove var="cArticle" scope="request"/>
      <c:remove var="articleSummary" scope="request"/>
    </c:if>
  </c:forEach>
  <c:remove var="counter" scope="request"/>
</c:if>

<c:remove var="articleSummaries" scope="request"/>
<c:remove var="targetGroup" scope="request"/>
<c:set target="${carousel}" property="attributeMapList" value="${mapList}"/>
<c:remove var="mapList" scope="request"/>

