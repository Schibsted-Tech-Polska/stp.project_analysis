<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMap/src/main/webapp/template/widgets/mobileMap/controller/default.jsp#1 $
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

<jsp:useBean id="mobileMap" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${mobileMap.source == 'deskedMaps'}">
    <jsp:include page="helpers/deskedMaps.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="helpers/relatedMaps.jsp"/>
  </c:otherwise>
</c:choose>
