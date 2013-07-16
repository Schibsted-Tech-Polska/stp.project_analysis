<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getCurtailedText.tag#3 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  The purpose of this tag is to get the difference of two dates.
--%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="from" required="true" rtexprvalue="true" type="java.util.Date" %>
<%@ attribute name="to" required="true" rtexprvalue="true" type="java.util.Date" %>

<%
  long comparingDateTime = from.getTime();
  long todaysDateTime = to.getTime();
  long dateDifference = (todaysDateTime-comparingDateTime)/1000;

  int dayValueInSec = 24*60*60;
  int hourValueInSec = 60*60;
  int minuteValueInSec = 60;
  int nDay = 0;
  int nHour = 0;
  int nMin = 0;
  int nSec = 0;
  if(dateDifference>0){
    if(dateDifference>dayValueInSec){
      nDay = (int)(dateDifference/dayValueInSec);
    }
    dateDifference -= nDay*dayValueInSec;
    if(dateDifference>hourValueInSec){
      nHour = (int)(dateDifference/hourValueInSec);
    }
    dateDifference -= nHour*hourValueInSec;
    if(dateDifference>minuteValueInSec){
      nMin = (int)(dateDifference/minuteValueInSec);
    }
    dateDifference -= nMin*minuteValueInSec;
    nSec = (int)dateDifference;
  }
  jspContext.setAttribute("day",nDay);
  jspContext.setAttribute("hour",nHour);
  jspContext.setAttribute("min",nMin);
  jspContext.setAttribute("sec",nSec);

%>

<c:set var="dateDifferencePresentation">
  <c:choose>
    <c:when test="${day > 0}">
      <c:choose>
        <c:when test="${(day) > 1}">
          <c:out value="${day}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.days.unit" />
        </c:when>
        <c:otherwise>
          <c:out value="${day}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.day.unit" />
        </c:otherwise>
      </c:choose>
    </c:when>
    <c:when test="${hour > 0}">
      <c:choose>
        <c:when test="${hour > 1}">
          <c:out value="${hour}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.hours.unit" /> <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:when>
        <c:otherwise>
          <c:out value="${hour}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.hour.unit" /> <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:otherwise>
      </c:choose>
    </c:when>
    <c:when test="${min > 0}">
      <c:choose>
        <c:when test="${min > 1}">
         <c:out value="${min}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.minutes.unit" /> <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:when>
        <c:otherwise>
          <c:out value="${min}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.minute.unit" /> <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:otherwise>
      </c:choose>
    </c:when>
    <c:when test="${sec > 0}">
      <c:choose>
        <c:when test="${sec > 1}">
          <c:out value="${sec}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.seconds.unit" />  <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:when>
        <c:otherwise>
          <c:out value="${sec}" escapeXml="true"/> <fmt:message key="dateline.widget.dateDifference.second.unit" /> <fmt:message key="dateline.widget.dateDifference.suffix" />
        </c:otherwise>
      </c:choose>
    </c:when>
    <c:otherwise>
      <fmt:message key="dateline.widget.dateDifference.noDifference.text" />
    </c:otherwise>
  </c:choose>
</c:set>
<%
  request.setAttribute(var, jspContext.getAttribute("dateDifferencePresentation"));
%>