<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/view/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- the purpose of this page is to render the default view of the dateline widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the controller has already set a HashMap named 'dateline' in the requestScope --%>
<jsp:useBean id="dateline" type="java.util.HashMap" scope="request"/>

<div class="${dateline.wrapperStyleClass}" <c:if test="${not empty dateline.styleId}">id="${dateline.styleId}"</c:if>>
  <ul>
    <li class="current first">
      <c:out value="${dateline.currentDate}" escapeXml="true"/>
    </li>
    <li class="modified">
      <fmt:message key="dateline.widget.default.lastModifiedDate.prefix">
        <fmt:param value="${dateline.lastModifiedDate}"/>
      </fmt:message>
    </li>
  </ul>
</div>

<c:remove var="dateline" scope="request" />