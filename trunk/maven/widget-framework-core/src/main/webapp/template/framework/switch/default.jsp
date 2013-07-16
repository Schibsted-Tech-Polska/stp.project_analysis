<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/switch/default.jsp#1 $
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

<jsp:useBean id="switchingGroup" type="neo.xredsys.presentation.PresentationElement" scope="request" />

<c:set var="switchingGroupAreaName" value="switchingGroup-area" />
<c:set var="switchingGroupArea" value="${switchingGroup.areas[switchingGroupAreaName]}" />
<c:set var="switchingGroupItems" value="${switchingGroupArea.items}" />

<c:forEach var="switchingGroupItem" items="${switchingGroupItems}" varStatus="status">
  <c:if test="${not empty switchingGroupItem.content and
                fn:startsWith(switchingGroupItem.content.articleTypeName,'widget_')}">

    <c:choose>
      <c:when test="${status.first and empty param['switchItem']}">
        <c:set var="widgetName" value="${fn:substringAfter(switchingGroupItem.content.articleTypeName, 'widget_')}" scope="request"/>
        <c:set var="element" value="${switchingGroupItem}" scope="request"/>
        <wf-core:include widgetName="${widgetName}" />
      </c:when>
      <c:when test="${not empty fn:trim(param['switchItem'])}">
        <c:set var="switchingGroupItemTitle"
               value="${not empty switchingGroupItem.fields.title ? switchingGroupItem.fields.title : switchingGroupItem.content.title }"  />

        <c:if test="${fn:trim(param['switchItem'])==switchingGroupItemTitle}">
          <c:set var="widgetName" value="${fn:substringAfter(switchingGroupItem.content.articleTypeName, 'widget_')}" scope="request"/>
          <c:set var="element" value="${switchingGroupItem}" scope="request"/>
          <wf-core:include widgetName="${widgetName}" />
        </c:if>

        <c:remove var="switchingGroupItemTitle" scope="page" />
      </c:when>
    </c:choose>
  </c:if>
</c:forEach>