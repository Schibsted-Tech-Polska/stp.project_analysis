<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getImageRepresentation.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="prefferedWidth" required="true" rtexprvalue="true" type="java.lang.String" %>

<c:choose>
  <c:when test="${(prefferedWidth+0)<=55.0}">
     <c:set var="imageRepresentation" value="w55" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=80.0}">
     <c:set var="imageRepresentation" value="w80" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=100.0}">
     <c:set var="imageRepresentation" value="w100" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=140.0}">
     <c:set var="imageRepresentation" value="w140" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=220.0}">
     <c:set var="imageRepresentation" value="w220" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=300.0}">
     <c:set var="imageRepresentation" value="w300" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=380.0}">
     <c:set var="imageRepresentation" value="w380" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=460.0}">
     <c:set var="imageRepresentation" value="w460" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=620.0}">
     <c:set var="imageRepresentation" value="w620" scope="page"/>
  </c:when>
  <c:when test="${(prefferedWidth+0)<=700.0}">
     <c:set var="imageRepresentation" value="w700" scope="page"/>
  </c:when>
  <c:otherwise>
     <c:set var="imageRepresentation" value="w940" scope="page"/>
  </c:otherwise>
</c:choose>

<%
  request.setAttribute(var,jspContext.getAttribute("imageRepresentation"));
%>

