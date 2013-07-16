<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMenu/src/main/webapp/template/widgets/mobileMenu/view/horizontal.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="mobileMenu" type="java.util.HashMap" scope="request"/>

<c:if test="${not empty mobileMenu.levels}">
  <dxw:menu itemId="${mobileMenu.styleId}" cssClass="${mobileMenu.wrapperStyleClass}">
    <c:forEach var="menuLevel" items="${mobileMenu.levels}">
      <c:forEach var="menuLevelItem" items="${menuLevel.items}">
        <c:set var="menuItemClass" value="${menuLevelItem.active?'active':'inactive'}" scope="page"/>
        <dxw:menuItem href="${menuLevelItem.url}" title="${menuLevelItem.text}" cssClass="${menuItemClass}"/>
        <c:remove var="menuItemClass" scope="page"/>
      </c:forEach>
    </c:forEach>
    <c:choose>
      <c:when test="${ not empty mobileSubMenu.articles}">
        <dxw:menuButton submenuId="submenu" text="${mobileSubMenu.moreText}"
                        textSelected="${mobileSubMenu.lessText}"/>
      </c:when>
      <c:when test="${not empty mobileSubMenu.subMenuName and not empty mobileSubMenu.items}">
        <dxw:menuButton submenuId="submenu" text="${mobileSubMenu.moreText}"
                        textSelected="${mobileSubMenu.lessText}"/>
      </c:when>
    </c:choose>
  </dxw:menu>
  <c:choose>
    <c:when test="${ not empty mobileSubMenu.articles}">
      <c:forEach var="articleItem" items="${articleMenuList}">
        <wf-core:handleLineBreaks var="modifiedTitle" value="${articleItem.fields.title.value}"/>
        <c:set var="intro" value="${articleItem.fields.leadtext.value}"/>
        <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${articleItem.id}" imageVersion="w460"/>
        <jsp:useBean id="teaserImageMap" type="java.util.HashMap" scope="request"/>
        <c:set var="imageUrl" value="${teaserImageMap.url}" scope="request"/>
        <dxw:article title="${modifiedTitle}" image="${imageUrl}" href="${articleItem.url}" imageSize="30"
                     imageAlign="left" ingress="${intro}"/>
      </c:forEach>
    </c:when>
    <c:when test="${not empty mobileSubMenu.subMenuName and not empty mobileSubMenu.items}">
      <dxw:submenu>
        <dxw:simplelist itemId="submenu" cssClass="submenu">
          <c:forEach var="menuLevelItem" items="${mobileSubMenu.items}">
            <dxw:simplelistItem href="${menuLevelItem.url}" title="${menuLevelItem.text}"
                                cssClass="${menuLevel.styleClass}"/>
          </c:forEach>
        </dxw:simplelist>
      </dxw:submenu>
    </c:when>
  </c:choose>
</c:if>
<c:remove var="mobileMenu" scope="request"/>
<c:remove var="mobileSubMenu" scope="request"/>

