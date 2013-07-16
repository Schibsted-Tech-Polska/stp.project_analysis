<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/controller/custom.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the controller for the custom view of dateline widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'dateline' in the requestScope --%>
<jsp:useBean id="dateline" type="java.util.HashMap" scope="request"/>

<%-- get necessary parameters from element's article fields --%>
<c:set var="dateTimeZone" value="${fn:trim(widgetContent.fields.timeZone)}" />
<c:if test="${empty dateTimeZone}">
  <c:set var="dateTimeZone" value="" />
</c:if>

<c:set var="languageCountry" value="${fn:trim(widgetContent.fields.languageCountry.value)}" />
  <c:choose>
    <c:when test="${languageCountry=='custom'}">
      <c:set var="dateLocale" value="${fn:trim(widgetContent.fields.locale)}" />
      <c:if test="${empty dateLocale}">
        <c:set var="dateLocale" value="" />
      </c:if>
    </c:when>
    <c:otherwise>
      <c:set var="dateLocale" value="${languageCountry}"/>
    </c:otherwise>
  </c:choose>

<%-- get the field value of an array of complex fields named dateEntries from article --%>
<c:set var="dates" value="${widgetContent.fields.dates.value}" />

<collection:createList id="dateEntries" type="java.util.ArrayList"/>

<c:forEach var="date" items="${dates}" varStatus="status">
  <jsp:useBean id="dateEntry" class="java.util.HashMap" />

  <%-- get field value dateType for the current date, default value: current  --%>
  <c:set var="dateType" value="${fn:trim(date.dateType)}" />

  <%-- get field value dateFormat for the current date, default value: EEE, MMM dd, yyyy hh:mm  --%>
  <c:set var="dateFormat" value="${fn:trim(date.dateFormat)}" />
  <c:if test="${empty dateFormat}">
    <c:set var="dateFormat" value="EEE, MMM dd, yyyy hh:mm a" />
  </c:if>

  <%-- get field value datePrefix for the current date --%>
  <c:set target="${dateEntry}" property="prefix" value="${fn:trim(date.datePrefix)}"/>

  <%-- get field value displayTimeDifference for the current date, default value: false --%>
  <c:set var="showDifference" value="${fn:trim(date.showDifference)}" />
  <c:if test="${empty showDifference}">
    <c:set var="showDifference" value="false" />
  </c:if>

  <%-- call helpers/date.jsp with necessary parameters which eventually render the inner HTML of each date entry --%>
  <c:set var="dateValue">
    <c:set var="dateTimeZone" value="${dateTimeZone}" scope="request"/>
    <c:set var="dateLocale" value="${dateLocale}" scope="request"/>
    <c:set var="dateType" value="${dateType}" scope="request"/>
    <c:set var="dateFormat" value="${dateFormat}" scope="request"/>
    <c:set var="displayTimeDifferecne" value="${showDifference}" scope="request"/>
    <jsp:include page="helpers/date.jsp" />
    <c:remove var="dateTimeZone" scope="request" />
    <c:remove var="dateLocale" scope="request" />
    <c:remove var="dateType" scope="request" />
    <c:remove var="dateFormat" scope="request"/>
    <c:remove var="displayTimeDifferecne" scope="request"/>
  </c:set>
  <c:set target="${dateEntry}" property="value" value="${dateValue}"/>

  <collection:add collection="${dateEntries}" value="${dateEntry}" />
  <c:remove var="dateEntry" scope="page" />
</c:forEach>

<c:set target="${dateline}" property="dateEntries" value="${dateEntries}"/>