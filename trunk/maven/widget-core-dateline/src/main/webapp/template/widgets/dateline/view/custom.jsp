<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/view/custom.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- the purpose of this page is to render the custom view of the dateline widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- the controller has already set a HashMap named 'dateline' in the requestScope --%>
<jsp:useBean id="dateline" type="java.util.HashMap" scope="request"/>

<c:set var="dateEntries" value="${dateline.dateEntries}"/>

<%-- if dateEntries is not empty, then we will iterate through the items of dateEntries and display them --%>
<c:if test="${not empty dateEntries}">
    <div class="${dateline.wrapperStyleClass}" <c:if test="${not empty dateline.styleId}">id="${dateline.styleId}"</c:if>>
    <ul>
    <%-- iterate through the complex fields of array dateEntries and display them --%>
      <c:forEach var="dateEntry" items="${dateEntries}" varStatus="status">
        <%-- if the date is the first or last one, we will use special style class named 'first' and 'last' respectively --%>
        <c:set var="datelineStyleClass" value="${status.first ? 'first' : ''}" />

        <li class="${dateEntry.type} ${datelineStyleClass}">
          <c:if test="${not empty dateEntry.prefix}"><c:out value="${dateEntry.prefix}" escapeXml="true"/></c:if>
          <c:out value="${dateEntry.value}" escapeXml="true"/>
        </li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<c:remove var="dateline" scope="request" />