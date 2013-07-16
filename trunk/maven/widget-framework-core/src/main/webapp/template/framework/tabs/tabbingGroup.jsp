<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/tabs/tabbingGroup.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="tabbingGroup" type="neo.xredsys.presentation.PresentationElement" scope="request" />
<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request" />

<c:set var="tabbingGroupAreaName" value="tabbingGroup-area" />
<c:set var="tabbingGroupArea" value="${tabbingGroup.areas[tabbingGroupAreaName]}" />
<c:set var="tabbingGroupItems" value="${tabbingGroupArea.items}" />

<collection:createList id="tabbingGroupItemsList" type="java.util.ArrayList"/>

<c:set var="tabbingGroupUniqueId" value="tabs" />
<c:set var="tabbingGroupNo" value="${requestScope.tabbingGroupNo + 1}" scope="request"/>
<c:set var="tabbingGroupUniqueId" value="${tabbingGroupUniqueId}-${requestScope.tabbingGroupNo}" />

<c:forEach var="tabbingGroupItem" items="${tabbingGroupItems}" varStatus="status">
  <c:choose>
    <c:when test="${tabbingGroupItem.type=='tabPaneGroup'}">
      <c:set var="tabPaneGroupId" value="${requestScope.tabPaneGroupId + 1}" scope="request"/>
      <collection:add collection="${tabbingGroupItemsList}" value="${tabbingGroupItem}" />
      <%--<c:set var="tabbingGroupUniqueId" value="${tabbingGroupUniqueId}-${requestScope.tabPaneGroupId}" />--%>
    </c:when>
    <c:when test="${not empty tabbingGroupItem.content and
                    fn:startsWith(tabbingGroupItem.content.articleTypeName,'widget_')}">
      <collection:add collection="${tabbingGroupItemsList}" value="${tabbingGroupItem}" />
      <%--<c:set var="tabbingGroupUniqueId" value="${tabbingGroupUniqueId}-${tabbingGroupItem.content.id}" />--%>
    </c:when>
  </c:choose>
</c:forEach>

<c:set var="tabbingGroupWidth" value="${fn:trim(tabbingGroup.options.width)}"/>

<c:choose>
  <c:when test="${empty tabbingGroupWidth or tabbingGroupWidth=='auto'}">
    <c:set var="tabPaneWidth" value="${requestScope['elementwidth']}" />
  </c:when>
  <c:otherwise>
    <c:set var="tabPaneWidth" value="${tabbingGroupWidth}" />
  </c:otherwise>
</c:choose>

<c:set var="customStyleClass" value="${fn:trim(tabbingGroup.options.customStyleClass)}"/>
<c:set var="styleClass" value="tabbingGroup ${customStyleClass}" />
<c:set var="styleId" value="${fn:trim(tabbingGroup.options.styleId)}"/>
<c:remove var="customStyleClass" scope="page" />

<c:set var="effect" value="${fn:trim(tabbingGroup.options.effect)}" />
<c:set var="event" value="${fn:trim(tabbingGroup.options.event)}"/>
<c:set var="changeUrl" value="${fn:trim(tabbingGroup.options.changeUrl)}" scope="request"/>

<c:if test="${not empty tabbingGroupItemsList}">
  <div class="${styleClass}"
       <c:if test="${not empty styleId}">id="${styleId}"</c:if>
       <c:if test="${not empty tabbingGroupWidth and tabbingGroupWidth!='auto'}">style="width:${tabPaneWidth}px;"</c:if> >

    <c:remove var="styleClass" scope="page" />
    <c:remove var="styleId" scope="page" />
    <c:remove var="tabbingGroupWidth" scope="page" />

    <%-- set necessary attributes in the requestScope which are required for default.jsp / accordions.jsp --%>
    <c:set var="tabItemsList" value="${tabbingGroupItemsList}" scope="request" />
    <c:set var="tabUniqueId" value="${tabbingGroupUniqueId}" scope="request" />
    <c:set var="tabWidth" value="${tabPaneWidth}" scope="request" />
    <c:set var="tabEvent" value="${event}" scope="request" />

    <c:choose>
      <c:when test="${effect=='accordions'}">
        <jsp:include page="accordions.jsp" />
      </c:when>
      <c:otherwise>
        <jsp:include page="default.jsp" />
      </c:otherwise>
    </c:choose>

    <c:remove var="tabItemsList" scope="request" />
    <c:remove var="tabUniqueId" scope="request" />
    <c:remove var="tabWidth" scope="request" />
    <c:remove var="tabEvent" scope="request" />


    <c:remove var="tabbingGroupItemsList" scope="page" />
    <c:remove var="tabbingGroupUniqueId" scope="page" />
    <c:remove var="tabPaneWidth" scope="page" />
    <c:remove var="effect" scope="page" />
    <c:remove var="event" scope="page" />
  </div>
</c:if>

