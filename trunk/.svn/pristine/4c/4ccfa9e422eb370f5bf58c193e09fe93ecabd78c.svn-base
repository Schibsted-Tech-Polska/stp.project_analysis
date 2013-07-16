<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileWeather/src/main/webapp/template/widgets/mobileWeather/view/googleWeather.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- the purpose of this page is to render the default view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>

<jsp:useBean id="mobileWeather" type="java.util.HashMap" scope="request" />

<dxf:div cssClass="${mobileWeather.wrapperStyleClass}" id="${mobileWeather.styleId}" >
  <dxf:h4><c:out value="${mobileWeather.title}" escapeXml="true"/></dxf:h4>
  <c:choose>
  <c:when test="${mobileWeather.correctWeatherResponse}">
  <dxf:div cssClass="current">
    <dxf:p>
      <img src="${mobileWeather.curIcon}" alt="${mobileWeather.curCondition}" title="${mobileWeather.curCondition}" width="40" height="40"/>
      
      <c:if test="${mobileWeather.showCurrentTemperature=='true'}">
        <fmt:message key="mobileWeather.widget.temperature.label"/>: <c:out value="${mobileWeather.curTemperature}" escapeXml="true"/>&deg;<c:out value="${mobileWeather.unit}" escapeXml="false"/><br/>
      </c:if>
      <c:if test="${mobileWeather.showCurrentHumidity=='true'}">
        <fmt:message key="mobileWeather.widget.humidity.label"/>: <c:out value="${mobileWeather.curHumidity}" escapeXml="true"/><br/>
      </c:if>
      <c:if test="${mobileWeather.showCurrentWind=='true'}">
        <fmt:message key="mobileWeather.widget.wind.label"/>: <c:out value="${mobileWeather.curWind}" escapeXml="true"/><br/>
      </c:if>
    </dxf:p>
  </dxf:div>

  <c:if test="${mobileWeather.showForecast=='true'}">
    <dxf:div cssClass="${mobileWeather.rowStyle}">
      <c:forEach items="${mobileWeather.forecasts}" var="forecast">

        <dxf:div cssClass="forecast">
          <dxf:h4><c:out value="${forecast.day}" escapeXml="true"/></dxf:h4>
          <img src="${forecast.icon}" alt="${forecast.condition}" title="${forecast.condition}"/><br/>
          <fmt:message key="mobileWeather.widget.high.label"/>: <c:out value="${forecast.high}" escapeXml="true"/>&deg;<c:out value="${mobileWeather.unit}" escapeXml="false"/> <br/>
          <fmt:message key="mobileWeather.widget.low.label"/>: <c:out value="${forecast.low}" escapeXml="true"/>&deg;<c:out value="${mobileWeather.unit}" escapeXml="false"/>
        </dxf:div>
      </c:forEach>
    </dxf:div>
  </c:if>

  </c:when>
  <c:otherwise>
    <dxf:p>
      <fmt:message key="mobileWeather.widget.error.message">
        <fmt:param value="${mobileWeather.city}" />
      </fmt:message>
    </dxf:p>
  </c:otherwise>
  </c:choose>

</dxf:div>

<c:remove var="mobileWeather" scope="request"/>