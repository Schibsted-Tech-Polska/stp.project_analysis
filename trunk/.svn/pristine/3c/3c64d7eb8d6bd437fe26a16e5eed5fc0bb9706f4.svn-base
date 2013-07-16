<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-map/src/main/webapp/template/widgets/map/controller/helpers/relatedMaps.jsp#1 $
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
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<jsp:useBean id="map" type="java.util.Map" scope="request"/>

<c:if test="${requestScope['com.escenic.context'] == 'art'}">
  <c:set var="relatedMapCount" value="${fn:length(article.relatedElements.mapRel.items)}"/>
  <c:set var="begin" value="${widgetContent.fields.begin.value}"/>
  <c:set var="end" value="${widgetContent.fields.end.value}"/>

  <c:if test="${not empty begin and begin > 0}">
    <c:set var="begin" value="${begin - 1}"/>
  </c:if>

  <c:if test="${not empty end and end > 0}">
    <c:set var="end" value="${end - 1}"/>
  </c:if>

  <c:if test="${empty begin or begin > end or begin >= relatedMapCount}">
    <c:set var="begin" value="0"/>
  </c:if>

  <c:if test="${empty end or end >= relatedMapCount}">
    <c:choose>
      <c:when test="${relatedMapCount > 0}">
        <c:set var="end" value="${relatedMapCount - 1}"/>
      </c:when>
      <c:otherwise>
        <c:set var="end" value="0"/>
      </c:otherwise>
    </c:choose>
  </c:if>

  <jsp:useBean id="mapList" class="java.util.ArrayList"/>

  <c:forEach var="mapSummary" items="${article.relatedElements.mapRel.items}" varStatus="loopStatus" begin="${begin}" end="${end}">
    <jsp:useBean id="attributeMap" class="java.util.HashMap" />
    <c:set target="${attributeMap}" property="mapArticleId" value="${mapSummary.content.id}"/>
    <c:set target="${attributeMap}" property="title" value="${fn:trim(mapSummary.fields.title.value)}"/>
    <c:set target="${attributeMap}" property="leadText" value="${fn:trim(mapSummary.fields.leadText.value)}"/>
     <%--Uncomment this to enable curios map --%>
    <%--<c:set target="${attributeMap}" property="mapType" value="${mapSummary.content.fields.mapType.value}"/>--%>

    <c:if test="${loopStatus.last}">
      <c:set target="${attributeMap}" property="styleClass" value="last"/>
    </c:if>
    <%--Uncomment this to enable curios map --%>
    <%--<c:choose>--%>
      <%--<c:when test="${attributeMap.mapType == 'curiousMap'}">--%>
        <%--<c:set target="${attributeMap}" property="curiousMapData" value="${mapSummary.content.fields.curiousMapData.value}"/>--%>
      <%--</c:when>--%>
      <%--<c:otherwise>--%>
        <c:set target="${attributeMap}" property="geocodeData" value="${mapSummary.content.fields['com.escenic.geocode'].value}"/>
     <%--Uncomment this to enable curios map --%>
      <%--</c:otherwise>--%>
    <%--</c:choose>--%>

    <collection:add collection="${mapList}" value="${attributeMap}"/>
    <c:remove var="attributeMap"/>
  </c:forEach>

  <c:set target="${map}" property="mapList" value="${mapList}"/>
</c:if>
