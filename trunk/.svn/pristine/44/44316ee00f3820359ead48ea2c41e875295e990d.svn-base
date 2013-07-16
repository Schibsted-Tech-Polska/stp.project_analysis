<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/view/breadcrumb.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the breadcrumb widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the controller has already set a HashMap named 'breadcrumb' in the requestScope --%>
<jsp:useBean id="navigation" type="java.util.HashMap" scope="request"/>

<c:set var="breadcrumbItems" value="${navigation.items}"/>

<c:if test="${not empty breadcrumbItems}">
  <div class="${navigation.wrapperStyleClass}" <c:if test="${not empty navigation.styleId}">id="${navigation.styleId}"</c:if>>
    <c:forEach var="breadcrumbItem" items="${breadcrumbItems}">
      <c:choose>
        <c:when test="${breadcrumbItem.active == true}">
          <c:choose>
            <c:when test="${requestScope['com.escenic.context']=='art'}">
              <a href="${breadcrumbItem.url}"><c:out value="${breadcrumbItem.text}" escapeXml="true"/> </a>
              <c:if test="${breadcrumb.displayArticleTitle}">
                / <c:out value="${article.title}" escapeXml="true"/>
              </c:if>
            </c:when>
            <c:otherwise>
              <c:out value="${breadcrumbItem.text}" escapeXml="true"/>
            </c:otherwise>
          </c:choose>
        </c:when>
        <c:otherwise>
          <a href="${breadcrumbItem.url}"><c:out value="${breadcrumbItem.text}" escapeXml="true"/> </a>
          /
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
</c:if>

<c:remove var="navigation" scope="request" />