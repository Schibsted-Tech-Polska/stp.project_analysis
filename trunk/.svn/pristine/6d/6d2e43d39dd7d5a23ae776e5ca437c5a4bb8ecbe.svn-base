<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-weather/src/main/webapp/template/widgets/weather/controller/googleWeather.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the default view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="weather" type="java.util.HashMap" scope="request" />

<c:set target="${weather}" property="city" value="${fn:trim(widgetContent.fields.city.value)}" />
<c:set target="${weather}" property="zip" value="${fn:trim(widgetContent.fields.zip.value)}" />
<c:set target="${weather}" property="showCurrentTemperature" value="${fn:trim(widgetContent.fields.showCurrentTemperature.value)}" />
<c:set target="${weather}" property="showCurrentHumidity" value="${fn:trim(widgetContent.fields.showCurrentHumidity.value)}" />
<c:set target="${weather}" property="showCurrentWind" value="${fn:trim(widgetContent.fields.showCurrentWind.value)}" />
<c:set target="${weather}" property="showForecast" value="${fn:trim(widgetContent.fields.showForecast.value)}" />
<c:set target="${weather}" property="forecastCount" value="${fn:trim(widgetContent.fields.forecastCount.value)}" />
<c:set target="${weather}" property="unit" value="${fn:trim(widgetContent.fields.unit.value)}" />

<%-- create service url --%>
<c:set var="weatherParamValue" value="${weather.zip}"/>
<c:if test="${empty weatherParamValue}">
  <c:set var="weatherParamValue" value="${weather.city}"/>
</c:if>

<c:url var="serviceUrl" value="http://www.google.com/ig/api">
  <c:param name="weather" value="${weatherParamValue}"/>
</c:url>

<%-- read service response --%>
<c:import url="${serviceUrl}" var="xmldoc"/>
<c:set var="correctWeatherResponse" value="false"/>

<c:if test="${not empty xmldoc}">
  <%-- parse xml --%>
  <x:parse xml="${xmldoc}" var="output"/>

  <x:if select="$output/xml_api_reply/weather/current_conditions">
    <%-- correct response found --%>
    <c:set var="correctWeatherResponse" value="true"/>
    <c:if test="${weatherParamValue==weather.zip}">
      <c:set var="cityFromZipCode">
        <x:out select="$output/xml_api_reply/weather/forecast_information/city/@data" escapeXml="true"/>
      </c:set>

      <c:if test="${fn:contains(cityFromZipCode,',')}">
        <c:set var="cityFromZipCode" value="${fn:substringBefore(cityFromZipCode,',')}"/>
      </c:if>
    </c:if>

    <%-- current info --%>

    <c:set var="curTemperature">
      <x:out select="$output/xml_api_reply/weather/current_conditions/temp_f/@data" escapeXml="true" />
    </c:set>

    <c:if test="${weather.unit=='C'}">
      <wf-core:convertFahrenheitToCelsius var="temp" f="${curTemperature}"/>
      <c:set var="curTemperature" value="${temp}"/>
      <c:remove var="temp" scope="request"/>
    </c:if>

    <c:set var="curIcon">
      http://www.google.com<x:out select="$output/xml_api_reply/weather/current_conditions/icon/@data" escapeXml="true" />
    </c:set>
    <c:set var="curCondition">
      <x:out select="$output/xml_api_reply/weather/current_conditions/condition/@data" escapeXml="true" />
    </c:set>
    <c:set var="curHumidity">
      <x:out select="$output/xml_api_reply/weather/current_conditions/humidity/@data" escapeXml="true" />
    </c:set>
    <c:if test="${not empty curHumidity and fn:contains(curHumidity,':')}">
      <c:set var="curHumidity" value="${fn:trim(fn:substringAfter(curHumidity,':'))}"/>
    </c:if>
    <c:set var="curWind">
      <x:out select="$output/xml_api_reply/weather/current_conditions/wind_condition/@data" escapeXml="true" />
    </c:set>
    <c:if test="${not empty curWind and fn:contains(curWind,':')}">
      <c:set var="curWind" value="${fn:trim(fn:substringAfter(curWind,':'))}"/>
    </c:if>

    <%-- forcast --%>
    <c:if test="${weather.showForecast=='true'}">
      <collection:createList id="forecasts" type="java.util.ArrayList"/>
      <x:forEach select="$output/xml_api_reply/weather/forecast_conditions" begin="0" end="${weather.forecastCount-1}" step="1" var="f">

        <jsp:useBean id="forecast" class="java.util.HashMap"/>
        <c:set var="day">
          <x:out select="$f/day_of_week/@data"/>
        </c:set>
        <c:set target="${forecast}" property="day" value="${day}"/>

        <c:set var="low">
          <x:out select="$f/low/@data"/>
        </c:set>
        <c:if test="${weather.unit=='C'}">
          <wf-core:convertFahrenheitToCelsius var="temp" f="${low}"/>
          <c:set var="low" value="${temp}"/>
          <c:remove var="temp" scope="request"/>
        </c:if>
        <c:set target="${forecast}" property="low" value="${low}"/>
        <c:set var="high">
          <x:out select="$f/high/@data"/>
        </c:set>
        <c:if test="${weather.unit=='C'}">
          <wf-core:convertFahrenheitToCelsius var="temp" f="${high}"/>
          <c:set var="high" value="${temp}"/>
          <c:remove var="temp" scope="request"/>
        </c:if>
        <c:set target="${forecast}" property="high" value="${high}"/>

        <c:set var="icon">
          http://www.google.com<x:out select="$f/icon/@data"/>
        </c:set>
        <c:set target="${forecast}" property="icon" value="${icon}"/>

        <c:set var="condition">
          <x:out select="$f/condition/@data"/>
        </c:set>
        <c:set target="${forecast}" property="condition" value="${condition}"/>
        <collection:add collection="${forecasts}" value="${forecast}"/>
        <c:remove var="forecast"/>
      </x:forEach>
    </c:if>
  </x:if>
</c:if>

<c:if test="${not empty cityFromZipCode}">
  <c:set target="${weather}" property="city" value="${cityFromZipCode}" />
</c:if>

<c:set target="${weather}" property="correctWeatherResponse" value="${correctWeatherResponse}"/>
<c:set target="${weather}" property="curIcon" value="${curIcon}"/>
<c:set target="${weather}" property="curCondition" value="${curCondition}"/>
<c:set target="${weather}" property="curTemperature" value="${curTemperature}"/>
<c:set target="${weather}" property="curHumidity" value="${curHumidity}"/>
<c:set target="${weather}" property="curWind" value="${curWind}"/>
<c:set target="${weather}" property="forecasts" value="${forecasts}"/>



