<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-blogUserList/src/main/webapp/template/widgets/blogUserList/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create the map that will contain relevant field values --%>
<jsp:useBean id="blogUserList" class="java.util.HashMap" scope="request"/>

<c:set target="${blogUserList}" property="styleClass" value="blogUserList"/>

<%-- read the fields that affect all views--%>
<c:set target="${blogUserList}" property="view" value="default"/>
<c:set target="${blogUserList}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${blogUserList}" property="customStyleClass" value="${fn:trim(widgetContent.fields['customStyleClass'])}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName.value)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${blogUserList}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<%-- set style class name if tabbing is enabled--%>
<c:if test="${not empty requestScope['tabbingEnabled'] and requestScope['tabbingEnabled']=='true'}">
  <c:set target="${blogUserList}" property="tabbingStyleClass" value="tabbedView"/>
</c:if>
