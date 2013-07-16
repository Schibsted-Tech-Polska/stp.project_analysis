<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/controller/helpers/imageVersionInRowView.jsp#1 $
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

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>
<jsp:useBean id="articleAttributeMap" type="java.util.Map" scope="request"/>

<%--choose image version --%>
<c:choose>
  <c:when test="${empty trailers.imageVersion}">
    <c:choose>
      <c:when test="${trailers.trailerWidthRow eq '140px'}">
        <c:choose>
          <c:when test="${not trailers.showTitleRow and not trailers.showIntroRow}">
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w140"/>
          </c:when>
          <c:otherwise>
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w55"/>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:when test="${trailers.trailerWidthRow eq '220px'}">
        <c:choose>
          <c:when test="${not trailers.showTitleRow and not trailers.showIntroRow}">
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w220"/>
          </c:when>
          <c:otherwise>
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w80"/>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:when test="${trailers.trailerWidthRow eq '300px'}">
        <c:choose>
          <c:when test="${not trailers.showTitleRow and not trailers.showIntroRow}">
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w300"/>
          </c:when>
          <c:otherwise>
            <c:set target="${articleAttributeMap}" property="imageVersion" value="w140"/>
          </c:otherwise>
        </c:choose>
      </c:when>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:set target="${articleAttributeMap}" property="imageVersion" value="${trailers.imageVersion}"/>
  </c:otherwise>
</c:choose>