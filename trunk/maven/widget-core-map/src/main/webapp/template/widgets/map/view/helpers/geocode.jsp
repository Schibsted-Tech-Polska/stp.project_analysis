<%--
 * Copyright (C) 2001 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.

 * The reason for the strange formatting, is that in  this way,
 * this file does not include any extra garbage whitespace, that could
 * hurt the resulting page.
 --%>

<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="geocodeAttributes" type="java.util.Map" scope="request"/>
<wf-core:getGeoFieldList var="geoFields" geoData="${fn:trim(geocodeAttributes.geocodeData)}"/>

<c:if test="${not empty requestScope.geoFields}">
  <c:set var="divId" value="widget${widgetContent.id}-article${geocodeAttributes.mapArticleId}"/>
  <c:set var="uniqueId" value="widget${widgetContent.id}_article${geocodeAttributes.mapArticleId}"/>
  <c:set var="width" value="${requestScope.elementwidth - 4}"/>
  <c:set var="height" value="${width}"/>
  
  <script type="text/javascript">
    var latitudeArray_${uniqueId} = new Array();
    var longitudeArray_${uniqueId} = new Array();
    var labelArray_${uniqueId} = new Array();
    var addressArray_${uniqueId} = new Array();
    var count_${uniqueId} = 0;
  </script>

  <c:forEach var="geoField" items="${requestScope.geoFields}">
    <c:set var="latitude" value="${geoField.location.latitude}"/>
    <c:set var="longitude" value="${geoField.location.longitude}"/>
    <c:set var="label" value="${geoField.address.label}"/>
    <c:set var="address" value="${geoField.address.address}"/>

    <script type="text/javascript">
      latitudeArray_${uniqueId}[count_${uniqueId}] = "${latitude}";
      longitudeArray_${uniqueId}[count_${uniqueId}] = "${longitude}";
      labelArray_${uniqueId}[count_${uniqueId}] = "${label}";
      addressArray_${uniqueId}[count_${uniqueId}] = "${address}";
      ++count_${uniqueId};
    </script>
  </c:forEach>

  <div id="${divId}" style="width: ${width}px; height: ${height}px" class="geocode ${geocodeAttributes.styleClass}">&nbsp;</div>
  <script type="text/javascript">
    $(document).ready(function() {
      initializeMap("${divId}", latitudeArray_${uniqueId}, longitudeArray_${uniqueId}, labelArray_${uniqueId}, addressArray_${uniqueId});
    });

    $(document).unload(function() {
      GUnload();
    });
  </script>

  <c:remove var="geoFields" scope="request"/>
</c:if>

