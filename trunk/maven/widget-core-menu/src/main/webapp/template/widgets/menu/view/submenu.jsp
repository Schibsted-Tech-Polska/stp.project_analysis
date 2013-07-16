<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/submenu.jsp#2 $
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

<c:if test="${not empty menu.items}">
  <div class="${menu.wrapperStyleClass}" <c:if test="${not empty menu.styleId}">id="${menu.styleId}"</c:if>>
    <c:if test="${not empty menu.menuTitle}">
      <h4><c:out value="${menu.menuTitle}" escapeXml="true"/> </h4>
    </c:if>
    <c:if test="${menu.showAncestors and not empty menu.ancestors}">
      <ul class="ancestors">
        <c:forEach var="menuItem" items="${menu.ancestors}">
          <li>
            <a href="${menuItem.url}" <c:if test="${menuItem.active}">class="${menu.activeMenuStyleClass}"</c:if> >
              <span><c:out value="${menuItem.text}" escapeXml="true"/> </span>
            </a>
          </li>
        </c:forEach>
      </ul>
    </c:if>
    <ul>
      <c:forEach var="menuItem" items="${menu.items}">
        <li>
          <a href="${menuItem.url}" <c:if test="${menuItem.active}">class="${menu.activeMenuStyleClass} <c:if test="${menuItem.current}">current</c:if>"</c:if> >
            <span><c:out value="${menuItem.text}" escapeXml="true"/> </span>
          </a>
          <c:if test="${not empty menuItem.submenuItems}">
            <c:set var="menuItem" value="${menuItem}" scope="request"/>
            <jsp:include page="helpers/verticalSubitems.jsp"/>
            <c:remove var="menuItem" scope="request"/>
          </c:if>
        </li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<c:remove var="menu" scope="request"/>