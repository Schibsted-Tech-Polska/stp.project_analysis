<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-slideshow/src/main/webapp/template/widgets/slideshow/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- create the map that will contain relevant field values / collections --%>
<jsp:useBean id="slideshow" class="java.util.HashMap" scope="request"/>

<c:set target="${slideshow}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${slideshow}" property="source" value="${fn:trim(widgetContent.fields.source.value)}"/>
<c:set target="${slideshow}" property="groupName" value="${fn:trim(widgetContent.fields.groupName.value)}"/>

<c:set var="pictureArticleTypeName" value="${fn:trim(widgetContent.fields.pictureArticleTypeName.value)}"/>
<c:if test="${empty pictureArticleTypeName}">
  <c:set var="pictureArticleTypeName" value="picture"/>
</c:if>
<c:set target="${slideshow}" property="pictureArticleTypeName" value="${pictureArticleTypeName}"/>

<c:set var="imageRepresentation" value="${fn:trim(widgetContent.fields.imageRepresentation.value)}" />
<c:if test="${empty imageRepresentation}">
  <c:set var="areaWidth" value="${requestScope.elementwidth > 940 ? '940' : requestScope.elementwidth}" />
  <c:set var="areaWidth" value="${empty areaWidth ? '620' : areaWidth}" />
  <c:set var="imageRepresentation" value="w${areaWidth}" />
</c:if>
<c:set target="${slideshow}" property="imageRepresentation" value="${imageRepresentation}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${slideshow}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:set target="${slideshow}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${slideshow}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${slideshow}" property="wrapperStyleClass">widget slideshow ${slideshow.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty slideshow.customStyleClass}"> ${slideshow.customStyleClass}</c:if></c:set>