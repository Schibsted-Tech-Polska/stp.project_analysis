<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileWeather/src/main/webapp/template/widgets/mobileWeather/index.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this JSP page is the entry point of the Video widget. --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<c:set var="city" value="${fn:trim(widgetContent.fields.city.value)}"/>
<c:if test="${empty city}">
  <c:set var="city" value="Oslo"/>
</c:if>

<c:set var="zip" value="${fn:trim(widgetContent.fields.zip.value)}" />

<c:set var="weatherParamValue" value="${zip}"/>
<c:if test="${empty weatherParamValue}">
  <c:set var="weatherParamValue" value="${city}"/>
</c:if>

<c:set var="cacheDuration" value="${fn:trim(widgetContent.fields.cacheDuration.value)}"/>
<c:if test="${empty cacheDuration}">
  <c:set var="cacheDuration" value="600"/>
</c:if>

<util:cache id="mobileWeather${weatherParamValue}${widgetContent.id}" expireTime="${cacheDuration}s">
  <%-- call wf-core:view tag to render the appropraite view of the widget --%>
  <wf-core:view widgetName="mobileWeather" />
</util:cache>





