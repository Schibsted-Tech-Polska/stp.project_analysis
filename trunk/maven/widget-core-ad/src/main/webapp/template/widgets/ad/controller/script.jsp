<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-ad/src/main/webapp/template/widgets/ad/controller/script.jsp#1 $
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- declare the map that contains necessary field values--%>
<jsp:useBean id="ad" type="java.util.Map" scope="request"/>
<c:set target="${ad}" property="code" value="${fn:trim(widgetContent.fields.code.value)}"/>
