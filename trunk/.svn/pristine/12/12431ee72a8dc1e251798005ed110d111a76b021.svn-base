<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/index.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This JSP page is the entry point of the Menu widget. --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<c:set var="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set var="updateInterval" value="${fn:trim(widgetContent.fields.updateInterval.value)}" />
<c:if test="${empty updateInterval}">
  <c:set var="updateInterval" value="60"/>
</c:if>

<util:cache id="menu-cache-${view}-view-${widgetContent.id}" expireTime="${updateInterval}m" includeSection="${true}">
  <wf-core:view widgetName="menu"/>
</util:cache>


