<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileAd/src/main/webapp/template/widgets/mobileAd/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="mobileAd" type="java.util.HashMap" scope="request"/>

<c:choose>
  <c:when test="${not empty widgetContent.relatedElements.adImage.items}">
    <c:set property="renderImage" target="${mobileAd}" value="true"/>
    <c:set property="adImage" target="${mobileAd}" value="${widgetContent.relatedElements.adImage.items[0]}"/>
    <%--todo: add field to widget for link title--%>
    <c:set property="aTitle" target="${mobileAd}" value="${mobileAd.adImage.content.fields.alttext.value}"/>
  </c:when>
  <c:otherwise>
    <c:set property="renderImage" target="${mobileAd}" value="false"/>
    <c:set property="aTitle" target="${mobileAd}" value="${publication.name}"/>
    <c:set property="aText" target="${mobileAd}" value="${publication.name}"/>
  </c:otherwise>
</c:choose>



