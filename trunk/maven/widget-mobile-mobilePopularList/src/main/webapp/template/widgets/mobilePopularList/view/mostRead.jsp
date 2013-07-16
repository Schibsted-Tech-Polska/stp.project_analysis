<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobilePopularList/src/main/webapp/template/widgets/mobilePopularList/view/mostRead.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- The purpose of this JSP page is to render the mostRead view of popularList widget. --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<%-- the controller has already set a HashMap named 'mobilePopularList' in the requestScope --%>
<jsp:useBean id="mobilePopularList" type="java.util.HashMap" scope="request"/>

<c:set var="popularListItems" value="${mobilePopularList.items}"/>

<c:if test="${not empty popularListItems}">
  <dxw:simplelist cssClass="${mobilePopularList.wrapperStyleClass}" itemId="${mobilePopularList.styleId}">
    <c:forEach var="popularListItem" items="${popularListItems}">
      <c:choose>
        <c:when test="${mobilePopularList.showCount=='true'}">
          <dxw:simplelistItem href="${popularListItem.url}" title="${popularListItem.title}">
            <jsp:attribute name="postFragment">
              <dxf:span cssClass="popularListPostFragment">(<c:out value="${popularListItem.count}" escapeXml="true"/>)</dxf:span>
			       </jsp:attribute>
          </dxw:simplelistItem>
        </c:when>
        <c:otherwise>
          <dxw:simplelistItem href="${popularListItem.url}" title="${popularListItem.title}"/>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </dxw:simplelist>
</c:if>

<c:remove var="mobilePopularList" scope="request"/>
