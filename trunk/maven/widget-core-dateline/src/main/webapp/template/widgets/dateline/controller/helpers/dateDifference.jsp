<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/controller/helpers/dateDifference.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- the purpose of this page is to display the time differecne between two given dates --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- this JSP page expects the following objects in the request scope  if any of them is missing, then this page will not work --%>
<jsp:useBean id="comparingDate" type="java.util.Date" scope="request" />
<jsp:useBean id="todaysDate" type="java.util.Date" scope="request" />

<%-- get the time in milliseconds of the two given dates --%>
<c:set var="comparingDateTime" value="${comparingDate.time}" />
<c:set var="todaysDateTime" value="${todaysDate.time}" />

<%-- get the time difference between the two given dates in seconds --%>
<c:set var="dateDifference" value="${(todaysDateTime - comparingDateTime) div 1000}" />
<c:if test="${fn:contains(dateDifference, '.')}">
  <c:set var="dateDifference" value="${fn:trim(fn:substringBefore(dateDifference,'.'))}"/>
</c:if>

<c:set var="dayValueInSec" value="${24*60*60}"/>
<c:set var="hourValueInSec" value="${60*60}"/>
<c:set var="minuteValueInSec" value="${60}"/>

<%-- dateDifferencePresentation is initially empty --%>
<c:set var="dateDifferencePresentation" value="" />

<%-- populate dateDifferencePresentation, only if the dateDifference > 0 and then display it --%>
<c:if test="${dateDifference > 0}">
  <c:set var="dateDifferencePresentation">
    <%-- get the number of days from dateDifference value in seconds --%>
    <c:if test="${dateDifference > dayValueInSec}">
      <c:set var="numberOfDays" value="${dateDifference div dayValueInSec}" />
      <c:if test="${fn:contains(numberOfDays, '.')}">
        <c:set var="numberOfDays" value="${fn:trim(fn:substringBefore(numberOfDays,'.'))}"/>
      </c:if>
      <c:choose>
        <c:when test="${(numberOfDays+0) > 1}">
          ${numberOfDays}
          <fmt:message key="dateline.widget.dateDifference.days.unit" />
        </c:when>
        <c:otherwise>
          ${numberOfDays}
          <fmt:message key="dateline.widget.dateDifference.day.unit" />
        </c:otherwise>
      </c:choose>
      <c:set var="dateDifference" value="${dateDifference - (numberOfDays * dayValueInSec)}" />
    </c:if>

    <%--get the number of hours from the remaining dateDifference value in seconds --%>
    <c:if test="${empty numberOfDays}">
      <c:if test="${dateDifference > hourValueInSec}">
        <c:set var="numberOfHours" value="${dateDifference div hourValueInSec}" />
        <c:if test="${fn:contains(numberOfHours, '.')}">
          <c:set var="numberOfHours" value="${fn:trim(fn:substringBefore(numberOfHours,'.'))}"/>
        </c:if>
        <c:choose>
          <c:when test="${(numberOfHours+0) > 1}">
            ${numberOfHours}
            <fmt:message key="dateline.widget.dateDifference.hours.unit" />
          </c:when>
          <c:otherwise>
            ${numberOfHours}
            <fmt:message key="dateline.widget.dateDifference.hour.unit" />
          </c:otherwise>
        </c:choose>
        <c:set var="dateDifference" value="${dateDifference - (numberOfHours * hourValueInSec)}" />
      </c:if>
    </c:if>

    <%--get the number of minutes from the remaining dateDifference value in seconds --%>
    <c:if test="${empty numberOfDays and empty numberOfHours}">
      <c:if test="${dateDifference > minuteValueInSec}">
        <c:set var="numberOfMinutes" value="${dateDifference div minuteValueInSec}" />
        <c:if test="${fn:contains(numberOfMinutes, '.')}">
          <c:set var="numberOfMinutes" value="${fn:trim(fn:substringBefore(numberOfMinutes,'.'))}"/>
        </c:if>
        <c:choose>
          <c:when test="${(numberOfMinutes+0) > 1}">
            ${numberOfMinutes}
            <fmt:message key="dateline.widget.dateDifference.minutes.unit" />
          </c:when>
          <c:otherwise>
            ${numberOfMinutes}
            <fmt:message key="dateline.widget.dateDifference.minute.unit" />
          </c:otherwise>
        </c:choose>
        <c:set var="dateDifference" value="${dateDifference - (numberOfMinutes * minuteValueInSec)}" />
      </c:if>
    </c:if>

    <c:if test="${empty numberOfDays and empty numberOfHours and empty numberOfMinutes}">
      <c:if test="${dateDifference > 0}">
        <c:set var="numberOfSeconds" value="${dateDifference}" />
        <c:choose>
          <c:when test="${(numberOfSeconds+0) > 1}">
            ${numberOfSeconds}
            <fmt:message key="dateline.widget.dateDifference.seconds.unit" />
          </c:when>
          <c:otherwise>
            ${numberOfSeconds}
            <fmt:message key="dateline.widget.dateDifference.second.unit" />
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:if>
  </c:set>

  <%-- display the date difference in the presentation layer if it's not empty --%>
  <c:set var="dateDifferencePresentation" value="${fn:trim(dateDifferencePresentation)}"/>
  <c:if test="${not empty dateDifferencePresentation}">
    <c:out value="${dateDifferencePresentation}"/>
    <fmt:message key="dateline.widget.dateDifference.suffix" />
  </c:if>

</c:if>

<%--
  if dateDifferencePresentation is empty, then it means that
  current date and comparing date are actually pointing to the same dame date and time
--%>
<c:if test="${empty dateDifferencePresentation}">
  <fmt:message key="dateline.widget.dateDifference.noDifference.text" />
</c:if>

