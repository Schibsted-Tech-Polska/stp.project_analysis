<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/view/helpers/prevNextArrowsMarkup.jsp#1 $
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

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>
<c:set var="uniqueId" value="${requestScope.uniqueId}"/>

<c:choose>
  <c:when test="${carousel.prevNexArrowPosition == 'horizontal'}">
    <c:set var="prevButtonStyle" value="leftPrevNextButton"/>
    <c:set var="nextButtonStyle" value="rightPrevNextButton"/>
  </c:when>
  <c:otherwise>
    <c:set var="prevButtonStyle" value="topPrevNextButton"/>
    <c:set var="nextButtonStyle" value="bottomPrevNextButton"/>
  </c:otherwise>
</c:choose>

<div id="prevCarouselItemButton_${uniqueId}" class="prevNextButton  ${prevButtonStyle}"> </div>
<div id="nextCarouselItemButton_${uniqueId}" class="prevNextButton ${nextButtonStyle}"> </div>