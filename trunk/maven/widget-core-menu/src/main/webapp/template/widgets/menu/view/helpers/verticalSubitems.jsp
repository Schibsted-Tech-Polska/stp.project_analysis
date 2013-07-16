<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/helpers/verticalSubitems.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the subitems of vertical menu recursively --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" uri="http://www.escenic.com/taglib/escenic-template" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- this JSP page expects the following object in the request scope if it is missing, then this page will not work --%>
<jsp:useBean id="menuItem" type="java.util.HashMap" scope="request"/>

<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<util:profiler path="/template/widgets/menu/view/helpers/verticalSubitems.jsp">
  <c:if test="${not empty menuItem.submenuItems}">
    <ul class="${menu.subMenuStyleClass}">
      <c:forEach var="menuSubItem" items="${menuItem.submenuItems}">
        <li>
          <a href="${menuSubItem.url}" <c:if test="${menuSubItem.active}">class="${menu.activeMenuStyleClass} <c:if test="${menuSubItem.current}">current</c:if>"</c:if> >
              <span><c:out value="${menuSubItem.text}" escapeXml="true"/> </span>
          </a>

            <%-- conditional recursive call --%>
          <c:if test="${not empty menuSubItem.submenuItems}">
            <template:call file="verticalSubitems.jsp">
              <template:parameter key="menuItem" name="menuSubItem" />
            </template:call>
          </c:if>
        </li>
      </c:forEach>
    </ul>
  </c:if>
</util:profiler>