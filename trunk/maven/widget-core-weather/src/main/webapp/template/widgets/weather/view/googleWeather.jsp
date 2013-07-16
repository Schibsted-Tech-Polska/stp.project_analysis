<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-weather/src/main/webapp/template/widgets/weather/view/googleWeather.jsp#2 $
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

<%-- the controller has already set a HashMap named 'video' in the requestScope --%>

<jsp:useBean id="weather" type="java.util.HashMap" scope="request" />

<div class="${weather.wrapperStyleClass}" <c:if test="${not empty weather.styleId}">id="${weather.styleId}"</c:if> >
  <h4>${weather.title}</h4>
  <c:choose>
  <c:when test="${weather.correctWeatherResponse}">
  <div class="current">
    <p>
      <img src="${weather.curIcon}" alt="${weather.curCondition}" title="${weather.curCondition}" width="40" height="40"/>
      
      <c:if test="${weather.showCurrentTemperature=='true'}">
        <fmt:message key="weather.widget.temperature.label"/>: ${weather.curTemperature}&deg;${weather.unit}<br/>
      </c:if>
      <c:if test="${weather.showCurrentHumidity=='true'}">
        <fmt:message key="weather.widget.humidity.label"/>: ${weather.curHumidity}<br/>
      </c:if>
      <c:if test="${weather.showCurrentWind=='true'}">
        <fmt:message key="weather.widget.wind.label"/>: ${weather.curWind}<br/>
      </c:if>
    </p>
  </div>

  <c:if test="${weather.showForecast=='true'}">
    <div class="forecasts">
      <c:forEach items="${weather.forecasts}" var="forecast">

        <div class="forecast">
          <h4><c:out value="${forecast.day}" escapeXml="true"/></h4>
          <img src="${forecast.icon}" alt="${forecast.condition}" title="${forecast.condition}"/><br/>
          <fmt:message key="weather.widget.high.label"/>: ${forecast.high}&deg;${weather.unit} <br/>
          <fmt:message key="weather.widget.low.label"/>: ${forecast.low}&deg;${weather.unit}
        </div>
      </c:forEach>
    </div>
  </c:if>

  </c:when>
  <c:otherwise>
    <p>
      <fmt:message key="weather.widget.error.message">
        <fmt:param value="${weather.city}" />
      </fmt:message>
    </p>
  </c:otherwise>
  </c:choose>

</div>

<c:remove var="weather" scope="request"/>