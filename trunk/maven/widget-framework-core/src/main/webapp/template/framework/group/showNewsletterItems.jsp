<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/showNewsletterItems.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the page expects the following attributes in the requestScope --%>
<jsp:useBean id="level" type="java.lang.String" scope="request" />

<c:choose>
  <c:when test="${not empty section.parameters['nesting.limit']}">
    <c:set var="nestingLimit" value="${section.parameters['nesting.limit']}"/>
  </c:when>
  <c:otherwise>
    <c:set var="nestingLimit" value="10"/>
  </c:otherwise>
</c:choose>