<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/horizontal.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render horizontal menu, both active only and all subitems menu --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />
<c:if test="${not empty menu.levels}">
  <div class="${menu.wrapperStyleClass}" <c:if test="${not empty menu.styleId}">id="${menu.styleId}"</c:if>>
    <c:forEach var="menuLevel" items="${menu.levels}">
      <ul <c:if test="${not empty menuLevel.styleId}">id="${menuLevel.styleId}"</c:if>
          <c:if test="${not empty menuLevel.styleClass}">class="${menuLevel.styleClass}"</c:if> >

        <c:forEach var="menuLevelItem" items="${menuLevel.items}">
          <li>
            <a href="${menuLevelItem.url}" <c:if test="${menuLevelItem.active}">class="${menu.activeMenuStyleClass}"</c:if> >
              <span><c:out value="${menuLevelItem.text}" escapeXml="true"/> </span>
            </a>
          </li>
        </c:forEach>

      </ul>
    </c:forEach>
  </div>
</c:if>
<c:remove var="menu" scope="request"/>