<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/list.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ tag language="java" dynamic-attributes="listItemParams" %>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ attribute name="collection" required="true" type="java.util.List" %>
<%@ attribute name="pageNo" required="true" %>
<%@ attribute name="itemTemplateType" required="true" %>
<%@ attribute name="itemTemplatePath" %>

<template:call file="../../../framework/list/listGenerator.jsp">
  <template:parameter key="collection" name="collection"/>
  <template:parameter key="pageNo" name="pageNo"/>
  <template:parameter key="pageSize" value="6"/>
  <template:parameter key="navSize" value="15"/>
  <template:parameter key="itemTemplateType" value="${itemTemplateType}"/>
  <template:parameter key="itemTemplatePath" value="${itemTemplatePath}"/>
  <c:if test="${not empty listItemParams && fn:length(listItemParams) > 0}">
    <c:forEach var="listItemParam" items="${listItemParams}">
      <template:parameter key="${listItemParam.key}" value="${listItemParam.value}"/>
    </c:forEach>
  </c:if>
</template:call>