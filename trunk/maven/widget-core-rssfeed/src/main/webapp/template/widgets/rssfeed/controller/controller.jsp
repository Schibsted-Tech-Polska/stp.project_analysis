<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-rssfeed/src/main/webapp/template/widgets/rssfeed/controller/controller.jsp#1 $
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="rssfeed" class="java.util.HashMap" scope="request"/>

<c:set target="${rssfeed}" property="view" value="${fn:trim(widgetContent.fields.view.value)}" />
<c:set target="${rssfeed}" property="controller" value="default" />