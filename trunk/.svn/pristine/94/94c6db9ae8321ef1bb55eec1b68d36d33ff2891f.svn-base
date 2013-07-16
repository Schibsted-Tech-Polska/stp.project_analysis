<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/menuItem.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the general controller for menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<div class="${menu.wrapperStyleClass}" <c:if test="${not empty menu.styleId}">id="${menu.styleId}"</c:if>>
  <c:if test="${not empty menu.linkText and not empty menu.linkUrl}">
    <ul>
      <li>
        <a href="${menu.linkUrl}">
          <c:out value="${menu.linkText}" escapeXml="true"/>
        </a>
      </li>
    </ul>
  </c:if>
</div>

<c:remove var="menu" scope="request"/>