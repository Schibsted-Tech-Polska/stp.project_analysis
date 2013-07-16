<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/list.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/10/04 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="loopStatus" type="javax.servlet.jsp.jstl.core.LoopTagStatus" required="true" rtexprvalue="true" %>

<c:choose>
  <c:when test="${loopStatus.first}">
    <c:set var="articleClass" value="first" />
  </c:when>
  <c:when test="${loopStatus.last}">
    <c:set var="articleClass" value="last" />
  </c:when>
</c:choose>

<%
  request.setAttribute(id, jspContext.getAttribute("articleClass"));
%>