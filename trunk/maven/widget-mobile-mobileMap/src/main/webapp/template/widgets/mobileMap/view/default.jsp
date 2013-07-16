<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMap/src/main/webapp/template/widgets/mobileMap/view/default.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="dxw" uri="http://mobiletech.no/jsp/dextella-frame-widgets" %>

<jsp:useBean id="mobileMap" type="java.util.Map" scope="request"/>

<c:if test="${not empty mobileMap.mapList}">
  <c:set var="geocodeScriptsIncluded" value="false"/>
  <c:forEach var="mapAttributes" items="${mobileMap.mapList}">
    <wf-core:getGeoFieldList var="geoFields" geoData="${fn:trim(mapAttributes.geocodeData)}"/>
    <c:forEach var="geoField" items="${requestScope.geoFields}">
      <c:set var="latitude" value="${geoField.location.latitude}"/>
      <c:set var="longitude" value="${geoField.location.longitude}"/>
      <c:set var="key" value="${section.parameters['google.map.key']}"/>
      <dxw:map
          key="${key}"
          latitude="${latitude}"
          longitude="${longitude}"
          showNavigationLinks="${mobileMap.showNavigationLinks}"
          showZoomLinks="${mobileMap.showZoomLinks}"
          showMapTypeSwitcher="${mobileMap.showMapTypeSwitcher}"
          iconSize="${mobileMap.iconSize}"
          zoom="${mobileMap.zoomLevel}"
          />
    </c:forEach>
    <c:remove var="geocodeAttributes" scope="request"/>
  </c:forEach>
</c:if>