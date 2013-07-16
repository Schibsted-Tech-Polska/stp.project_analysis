<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-map/src/main/webapp/template/widgets/map/view/default.jsp#1 $
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

<jsp:useBean id="map" type="java.util.Map" scope="request"/>

<c:if test="${not empty map.mapList}">
  <c:set var="geocodeScriptsIncluded" value="false"/>

  <div class="${map.wrapperStyleClass}" <c:if test="${not empty map.styleId}">id="${map.styleId}"</c:if>>
    <c:forEach var="mapAttributes" items="${map.mapList}">
      <%--Uncomment this to enable curios map --%>
      <%--<c:choose>--%>
        <%--<c:when test="${mapAttributes.mapType == 'curiousMap'}">--%>
          <%--<c:set var="curiousMapAttributes" value="${mapAttributes}" scope="request"/>--%>
          <%--<jsp:include page="helpers/curiousMap.jsp"/>--%>
          <%--<c:remove var="curiousMapAttributes" scope="request"/>--%>
        <%--</c:when>--%>
        <%--<c:otherwise>--%>
          <c:if test="${not geocodeScriptsIncluded}">
            <script type="text/javascript"
                    src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=${section.parameters['google.map.key']}"></script>
            <c:set var="geocodeScriptsIncluded" value="true"/>
          </c:if>
          <c:set var="geocodeAttributes" value="${mapAttributes}" scope="request"/>
          <jsp:include page="helpers/geocode.jsp"/>
          <c:remove var="geocodeAttributes" scope="request"/>
       <%--Uncomment this to enable curios map --%>
        <%--</c:otherwise>--%>
      <%--</c:choose>--%>
    </c:forEach>
  </div>
</c:if>