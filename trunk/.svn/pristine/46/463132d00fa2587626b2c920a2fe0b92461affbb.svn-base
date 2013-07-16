<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/simple.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the simple view of list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.Map" scope="request"/>

<div class="${list.wrapperStyleClass} ${list.inpageDnDAreaClass}" <c:if test="${not empty list.styleId}">id="${list.styleId}"</c:if>>
  <!-- show the header conditionally -->
  <c:if test="${requestScope.tabbingEnabled!='true' and not empty list.attributeMapList}">
    <div class="header">
      <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
    </div>
  </c:if>

  <c:if test="${not empty list.attributeMapList}">
    <div class="content">
      <ul>
        <c:forEach var="attributeMap" items="${list.attributeMapList}">
          <li>
            <a href="${attributeMap.url}" class="${attributeMap.inpageTitleClass} ${attributeMap.inpageDnDSummaryClass}">
              <c:out value="${attributeMap.title}" escapeXml="true"/>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:if>
</div>

<c:remove var="list" scope="request"/>
