<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/master-config.jsp#1 $
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

<div id="master-config" class="container">
  <div id="master-config-area">
    <c:set var="currentAreaName" value="master-config-area" scope="request" />

    <c:set var="area" value="master-config-area" scope="request" />
    <jsp:include page="getitems.jsp" />
    <c:remove var="area" scope="request" />

    <c:set var="elementwidth" value="960" scope="request"/>

    <c:set var="level" value="0" scope="request" />
    <jsp:include page="showitems.jsp" />
    <c:remove var="level" scope="request" />
    <c:remove var="currentAreaName" scope="request"/>
  </div>
</div>
