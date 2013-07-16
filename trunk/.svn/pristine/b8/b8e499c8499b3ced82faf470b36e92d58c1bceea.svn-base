<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/menuNode.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render vertical menu, both active only and all subitems menu --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<div class="${menu.wrapperStyleClass}" <c:if test="${not empty menu.styleId}">id="${menu.styleId}"</c:if>>
  <c:if test="${not empty menu.menuNode}">
    <ul>
      <li>
        <a href="${menu.menuNode.url}">
          <c:choose>
            <c:when test="${not empty menu.label}">
              <c:out value="${menu.label}" escapeXml="true"/>
            </c:when>
            <c:otherwise>
              <c:out value="${menu.menuNode.text}" escapeXml="true"/>
            </c:otherwise>
          </c:choose>
        </a>
      </li>
    </ul>
  </c:if>
  <c:if test="${empty menu.menuNode}">
    &nbsp;
  </c:if>
</div>
<c:remove var="menu" scope="request"/>