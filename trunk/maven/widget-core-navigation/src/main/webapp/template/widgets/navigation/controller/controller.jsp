<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  This JSP page is the entry point of the Navigation widget. It just delegates to a view JSP page with necessary parameters
  which eventually renders all the HTML for the Navigation widget.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a hashmap named 'navigation' that will contain relevant field values --%>
<jsp:useBean id="navigation" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${navigation}" property="styleClass" value="navigation"/>

<%-- retreive necessary parameters --%>
<c:set target="${navigation}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${navigation}" property="menuName" value="${fn:trim(widgetContent.fields.menuName)}"/>
<c:set target="${navigation}" property="displayArticleTitle" value="${fn:trim(widgetContent.fields.displayArticleTitle)}"/>
<c:set target="${navigation}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${navigation}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set target="${navigation}" property="pagetitle" value="${fn:trim(widgetContent.fields.pagetitle)}"/>
<c:set target="${navigation}" property="pagetitlelinked" value="${fn:trim(widgetContent.fields.pagetitlelinked)}"/>
<c:set target="${navigation}" property="sectionheader" value="${fn:trim(widgetContent.fields.sectionheader)}"/>
<c:set target="${navigation}" property="sectionuniquename" value="${fn:trim(widgetContent.fields.sectionuniquename)}"/>
<c:set target="${navigation}" property="sectionheaderlink" value="${fn:trim(widgetContent.fields.sectionheaderlink)}"/>
<c:set target="${navigation}" property="sectionlinktext" value="${fn:trim(widgetContent.fields.sectionlinktext)}"/>
<c:set target="${navigation}" property="updateInterval" value="${fn:trim(widgetContent.fields.updateInterval.value)}" />
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${navigation}" property="wrapperStyleClass">widget navigation ${navigation.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty navigation.customStyleClass}"> ${navigation.customStyleClass}</c:if></c:set>