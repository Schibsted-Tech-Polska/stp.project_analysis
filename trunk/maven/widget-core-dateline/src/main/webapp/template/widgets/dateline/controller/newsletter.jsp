<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/controller/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the controller for the default view of dateline widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the general controller has already set a HashMap named 'dateline' in the requestScope --%>
<jsp:useBean id="dateline" type="java.util.HashMap" scope="request"/>

<%-- retrieve other necessary parameters --%>
<c:set var="todaysDateFormat" value="${fn:trim(widgetContent.fields.todaysDateFormat_newsletter)}"/>
<c:if test="${empty todaysDateFormat}">
  <c:set var="todaysDateFormat" value="EEEE dd MMMM yyyy"/>
</c:if>

<c:set var="lastUpdatedDateFormat" value="${fn:trim(widgetContent.fields.lastUpdatedDateFormat_newsletter)}"/>
<c:if test="${empty lastUpdatedDateFormat}">
  <c:set var="lastUpdatedDateFormat" value="EEE, MMM dd, yyyy hh:mm a"/>
</c:if>

<c:set var="showDifference" value="${fn:trim(widgetContent.fields.showDifference_newsletter)}"/>

<c:set var="dateTimeZone" value="" scope="request"/>
<c:set var="dateLocale" value="" scope="request"/>

<c:set var="currentDate">
  <c:set var="dateType" value="current" scope="request"/>
  <c:set var="dateFormat" value="${todaysDateFormat}" scope="request"/>
  <c:set var="displayTimeDifferecne" value="false" scope="request"/>
  <jsp:include page="helpers/date.jsp"/>
  <c:remove var="dateType" scope="request"/>
  <c:remove var="dateFormat" scope="request"/>
  <c:remove var="displayTimeDifferecne" scope="request"/>
</c:set>

<c:set var="lastModifiedDate">
  <c:set var="dateType" value="modified" scope="request"/>
  <c:set var="dateFormat" value="${lastUpdatedDateFormat}" scope="request"/>
  <c:set var="displayTimeDifferecne" value="${showDifference}" scope="request"/>
  <jsp:include page="helpers/date.jsp"/>
  <c:remove var="dateType" scope="request"/>
  <c:remove var="dateFormat" scope="request"/>
  <c:remove var="displayTimeDifferecne" scope="request"/>
</c:set>

<c:remove var="dateTimeZone" scope="request"/>
<c:remove var="dateLocale" scope="request"/>

<c:set target="${dateline}" property="currentDate" value="${fn:trim(currentDate)}"/>
<c:set target="${dateline}" property="lastModifiedDate" value="${fn:trim(lastModifiedDate)}"/>