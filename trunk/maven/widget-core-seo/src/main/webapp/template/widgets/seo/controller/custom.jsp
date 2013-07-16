<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-seo/src/main/webapp/template/widgets/seo/controller/custom.jsp#1 $
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

<jsp:useBean id="seo" type="java.util.HashMap" scope="request"/>

<c:set target="${seo}" property="metadata" value="${widgetContent.fields.meta.value}" />

