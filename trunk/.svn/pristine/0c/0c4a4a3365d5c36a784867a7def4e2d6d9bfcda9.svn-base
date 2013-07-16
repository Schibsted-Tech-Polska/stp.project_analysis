<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-mobile/src/main/webapp/template/framework/tabs/mobile.jsp#1 $
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
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<%--
  this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="tabbingGroup" type="neo.xredsys.presentation.PresentationElement" scope="request" />
<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request" />

<c:set var="tabbingGroupAreaName" value="tabbingGroup-area" />
<c:set var="tabbingGroupArea" value="${tabbingGroup.areas[tabbingGroupAreaName]}" />
<c:set var="tabbingGroupItems" value="${tabbingGroupArea.items}" />

<collection:createList id="tabbingGroupItemsList" type="java.util.ArrayList"/>

<c:set var="tabbingContentUniquePrefix" value="tabbingGroupContent" />

<c:forEach var="tabbingGroupItem" items="${tabbingGroupItems}" varStatus="status">
    <c:choose>
        <c:when test="${tabbingGroupItem.type=='tabPaneGroup'}">
            <c:set var="tabPaneGroupId" value="${requestScope.tabPaneGroupId + 1}" scope="request"/>
            <collection:add collection="${tabbingGroupItemsList}" value="${tabbingGroupItem}" />
            <c:set var="tabbingContentUniquePrefix" value="${tabbingContentUniquePrefix}-${requestScope.tabPaneGroupId}" />
        </c:when>
        <c:when test="${not empty tabbingGroupItem.content and
                        fn:startsWith(tabbingGroupItem.content.articleTypeName,'widget_')}">
                <collection:add collection="${tabbingGroupItemsList}" value="${tabbingGroupItem}" />
                <c:set var="tabbingContentUniquePrefix" value="${tabbingContentUniquePrefix}-${tabbingGroupItem.content.id}" />
        </c:when>
    </c:choose>
</c:forEach>



<c:set var="customStyleClass" value="${fn:trim(tabbingGroup.options.customStyleClass)}"/>
<c:set var="styleClass" value="tabbingGroup ${customStyleClass}" />
<c:set var="styleId" value="${fn:trim(tabbingGroup.options.styleId)}"/>
<c:set var="scheme" value="${fn:trim(tabbingGroup.options.scheme)}"/>
<c:set var="tabName" value="${fn:trim(tabbingGroup.options.name)}"/>
<c:remove var="customStyleClass" scope="page" />

<c:if test="${not empty tabbingGroupItemsList}">
    <div class="${styleClass}"
         <c:if test="${not empty styleId}">id="${styleId}"</c:if>
         <c:if test="${not empty tabbingGroupWidth and tabbingGroupWidth!='areaWidth'}">style="width:${tabbingGroupWidth}px;"</c:if> >

        <c:remove var="styleClass" scope="page" />
        <c:remove var="tabbingGroupWidth" scope="page" />

        <%-- tab navigation --%>
        <dxw:tabpane scheme="${scheme}" cssClass=""  itemId="${styleId}">
            <c:remove var="styleId" scope="page" />
            <c:choose>
                <c:when test="${capabilities.ajax_manipulate_dom eq 'true' and capabilities.css_extension eq 'webkit' and capabilities.pointing_method eq 'touchscreen'}">
                    <c:if test="${not empty tabName}">
                        <dxf:li cssClass="tabName">
                            <dxf:out>${tabName}</dxf:out>
                        </dxf:li>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <c:if test="${not empty tabName}">
                        <dxf:span cssClass="tabName">
                            <dxf:out>${tabName}</dxf:out>
                        </dxf:span>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <c:remove var="tabName" scope="page" />
            <c:forEach var="tabbingGroupItem" items="${tabbingGroupItemsList}" varStatus="status">
                <c:choose>
                    <c:when test="${not empty tabbingGroupItem.content and
                                    fn:startsWith(tabbingGroupItem.content.articleTypeName,'widget_')}">
                        <c:set var="tabbingGroupItemTitle" value="${tabbingGroupItem.content.title}" />

                        <c:set var="tabLocation" value="m"/>
                        <c:if test="${status.first}"><c:set var="tabLocation" value="l"/></c:if>
                        <c:if test="${status.last}"><c:set var="tabLocation" value="r"/></c:if>

                        <dxw:pane tabname="${tabbingGroupItemTitle}" location="${tabLocation}">
                            <c:set var="widgetName" value="${fn:substringAfter(tabbingGroupItem.content.articleTypeName, 'widget_')}" scope="request"/>
                            <c:set var="element" value="${tabbingGroupItem}" scope="request"/>
                            <wf-core:include widgetName="${widgetName}" />
                        </dxw:pane>
                    </c:when>
                </c:choose>
                <c:remove var="tabbingGroupItemTitle" scope="page" />
                <c:remove var="tabLocation" scope="page"/>
            </c:forEach>
        </dxw:tabpane>

        <c:remove var="tabbingEnabled" scope="request" />
    </div>
</c:if>

