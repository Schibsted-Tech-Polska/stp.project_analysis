<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userActivity/src/main/webapp/template/widgets/userActivity/controller/controller.jsp#1 $
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

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="userActivity" class="java.util.HashMap" scope="request"/>

<c:set target="${userActivity}" property="view" value="default" />
<c:set target="${userActivity}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${userActivity}" property="customStyleClass" value="${fn:trim(widgetContent.fields['customStyleClass'])}"/>
<%-- set style class name if tabbing is enabled--%>
<c:if test="${not empty requestScope['tabbingEnabled'] and requestScope['tabbingEnabled']=='true'}">
  <c:set target="${userActivity}" property="tabbingStyleClass" value="tabbedView"/>
</c:if>

<c:set var="actionString" value="" scope="page"/>
<c:forEach items="${widgetContent.fields.actions.value}" var="item" varStatus="status">
  <c:set var="actionString" value="${actionString}${status.first?'':','}${item}" scope="page"/>
</c:forEach>
<c:set target="${userActivity}" property="actionString" value="${actionString}"/>
<c:remove var="actionString" scope="page"/>

<c:set target="${userActivity}" property="contentTypes" value="${fn:trim(widgetContent.fields.contentTypes.value)}"/>

<c:set target="${userActivity}" property="userOption" value="${fn:trim(widgetContent.fields.user.value)}"/>
<c:set target="${userActivity}" property="maxActivity" value="${fn:trim(widgetContent.fields.maxActivity.value)}"/>
<c:set target="${userActivity}" property="numberOfDays" value="${fn:trim(widgetContent.fields.numberOfDays.value)}"/>
<c:set target="${userActivity}" property="showDateDifference" value="${fn:trim(widgetContent.fields.showDateDifference.value)}"/>
<c:set target="${userActivity}" property="dateFormat" value="${fn:trim(widgetContent.fields.dateFormat.value)}"/>
<c:set target="${userActivity}" property="showAvatar" value="${fn:trim(widgetContent.fields.showAvatar.value)}"/>
<c:set target="${userActivity}" property="avatarImageVersion" value="${fn:trim(widgetContent.fields.avatarImageVersion.value)}"/>
<c:set target="${userActivity}" property="showSummary" value="${fn:trim(widgetContent.fields.showSummary.value)}"/>
<c:set target="${userActivity}" property="maxSummaryChar" value="${fn:trim(widgetContent.fields.maxSummaryChar.value)}"/>
<c:set target="${userActivity}" property="avatarSize" value="${fn:substringAfter(userActivity.avatarImageVersion, 'w')}" />
