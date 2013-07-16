<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/view/pagetitle.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the pagetitle view of the navigation widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- the controller has already set a HashMap named 'navigation' in the requestScope --%>
<jsp:useBean id="navigation" type="java.util.HashMap" scope="request"/>

<div class="${navigation.wrapperStyleClass}" <c:if test="${not empty navigation.styleId}">id="${navigation.styleId}"</c:if>>
  <div class="navigation_pageTitle">

<c:choose>
  <c:when test="${navigation.pagetitlelinked}">
    <a href="${section.url}" ><h5><c:out value="${navigation.pagetitle}" escapeXml="true"/></h5></a>
  </c:when>
  <c:otherwise>
    <h5><c:out value="${navigation.pagetitle}" escapeXml="true"/></h5>
  </c:otherwise>
</c:choose>

  </div>
</div>

<c:remove var="navigation" scope="request"/>