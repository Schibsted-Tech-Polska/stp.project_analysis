<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-seo/src/main/webapp/template/widgets/seo/controller/default.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<c:if test="${not empty element}">
  <c:set var="keywords" value="${fn:trim(widgetContent.fields.keywords)}"/>
  <c:set var="description" value="${fn:trim(widgetContent.fields.description)}"/>
  <wf-core:evalField id="extractedKeywords" inputFieldValue="${keywords}" />
  <wf-core:evalField id="extractedDescription" inputFieldValue="${description}" />
</c:if>