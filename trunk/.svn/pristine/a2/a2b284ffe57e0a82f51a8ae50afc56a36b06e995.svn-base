<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-master/src/main/webapp/template/widgets/master/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the default view of master widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'master' in the requestScope --%>
<jsp:useBean id="master" type="java.util.HashMap" scope="request"/>

<section:use uniqueName="${master.masterSectionUniqueName}">
  <c:set var="masterConfigSection" value="${section}" />
</section:use>

<c:if test="${not empty masterConfigSection}">
  <wf-core:getPresentationPool var="masterConfigPool" section="${masterConfigSection}" />
  <c:set var="masterConfigSectionPool" value="${masterConfigPool}" />
  <c:remove var="masterConfigPool" scope="request" />
</c:if>

<c:set var="areaName" value="master-config-area" />
<c:if test="${(not empty masterConfigSectionPool) and (not empty masterConfigSectionPool.rootElement.areas[areaName].items)}">
  <c:set target="${master}" property="items" value="${masterConfigSectionPool.rootElement.areas[areaName].items}"/>
</c:if>

<c:remove var="areaName" scope="page" />
<c:remove var="masterConfigSection" scope="page" />
<c:remove var="masterConfigSectionPool" scope="page" />