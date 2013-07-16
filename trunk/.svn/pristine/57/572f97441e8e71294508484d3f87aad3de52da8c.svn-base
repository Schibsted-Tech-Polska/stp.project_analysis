<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/getparentitems.jsp#1 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>


<c:if test="${parent.uniqueName != 'ece_frontpage'}">
  <section:use uniqueName="config.section.${parent.uniqueName}">
    <wf-core:getPresentationPool var="parentPool" section="${section}"/>
    <c:if test="${not empty parentPool.rootElement.areas[area].items}">
      <c:set var="items" value="${parentPool.rootElement.areas[area].items}" scope="request"/>
    </c:if>
  </section:use>
</c:if>

<c:if test="${not empty parent.parent and parent.uniqueName != 'config.mobile'}">
  <c:set var="parent" value="${parent.parent}" scope="request"/>
  <jsp:include page="getparentitems.jsp"/>
</c:if>
