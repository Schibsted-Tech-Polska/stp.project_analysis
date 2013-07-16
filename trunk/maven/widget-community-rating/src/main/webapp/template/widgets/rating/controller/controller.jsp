<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--  This is general controller of the rating widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile"%>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<%--create a hashmap named 'rating' that will contain relevant field values --%>
<jsp:useBean id="rating" class="java.util.HashMap" scope="request" />

<%-- retreive necessary parameters --%>
<c:set target="${rating}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
<c:set target="${rating}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${rating}" property="customStyleClass"
                          value="${fn:trim(widgetContent.fields.customStyleClass)}"/>


<profile:present>
  <section:use uniqueName="${user.userName}">
    <community:user id="currentUser" sectionId="${section.id}"/>
    <c:set target="${rating}" property="user" value="${currentUser}"/>
  </section:use>
</profile:present>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${rating}" property="wrapperStyleClass">widget rating ${rating.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty rating.customStyleClass}"> ${rating.customStyleClass}</c:if></c:set>