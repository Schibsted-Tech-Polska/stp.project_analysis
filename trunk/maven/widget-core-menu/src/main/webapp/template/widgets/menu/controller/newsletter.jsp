<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the horizontal view of menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>
<%@ taglib prefix="menu" uri="http://www.escenic.com/taglib/escenic-menu" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the general controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<c:set target="${menu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepthNewsletter)}"/>
<c:set target="${menu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItemsNewsletter)}"/>

<%-- create a generic view named 'menu' from the given ${menu.treeName} --%>
<menu:use id="menuTreeView" treeName="${menu.treeName}">
  <%-- base is the menu item for current section --%>
  <menu:item id="base"/>

  <c:set target="${menu}" property="treeView" value="${menuTreeView}" />
  <c:set target="${menu}" property="base" value="${base}" />
  <collection:createList id="horizontalLevelMapsList" type="java.util.ArrayList" toScope="request" />

  <collection:createList id="topMenuItemsList" type="java.util.ArrayList"/>
  <%-- iterate through the generic view 'menu', only in the top most level --%>
  <view:iterate id="menuItem" name="menuTreeView" depth="2" type="com.escenic.menu.MenuItem">
    <%-- get the relationship between base and the current menu item --%>
    <view:relationships id="baseRelation" name="base"/>
    <c:if test="${menuItem.level == 1}">
      <jsp:useBean id="currentMenuItem" class="java.util.HashMap"/>
      <c:set target="${currentMenuItem}" property="menuItem" value="${menuItem}"/>
      <c:set target="${currentMenuItem}" property="url" value="${menuItem.URL}"/>
      <c:set target="${currentMenuItem}" property="text" value="${menuItem.text}"/>

      <c:choose>
        <c:when test="${baseRelation.base || baseRelation.ancestor || baseRelation.parent}"> <%-- the current menu item is active --%>
          <c:set var="activeMenuItem" value="${menuItem}" />
          <c:set target="${currentMenuItem}" property="active" value="${true}"/>
        </c:when>
        <c:otherwise> <%-- the current menu item is not active --%>
          <c:set target="${currentMenuItem}" property="active" value="${false}"/>
        </c:otherwise>
      </c:choose>

      <collection:add collection="${topMenuItemsList}" value="${currentMenuItem}" />
      <c:remove var="currentMenuItem" scope="page" />
    </c:if>
  </view:iterate>

  <c:if test="${not empty topMenuItemsList}">
    <jsp:useBean id="horizontalLevelMap" class="java.util.HashMap" />
    <c:if test="${menu.displayItems=='all'}">
      <c:set target="${horizontalLevelMap}" property="styleId" value="" />
    </c:if>
    <c:set target="${horizontalLevelMap}" property="styleClass" value="" />
    <c:set target="${horizontalLevelMap}" property="items" value="${topMenuItemsList}" />
    <collection:add collection="${horizontalLevelMapsList}" value="${horizontalLevelMap}" />
  </c:if>

  <c:choose>
    <c:when test="${menu.displayItems=='all'}">
      <%-- it's all-subitems menu, hence display all the subitems of all menu items --%>
      <c:forEach var="topMenuItem" items="${topMenuItemsList}" varStatus="menuItemStatus">
        <%-- calling 'helpers/horizontalAllSubitems.jsp' to render all the sub menu items of the current top menu item recursively --%>
        <c:if test="${not empty base and (menu.depth+0) > 1 and not empty topMenuItem.menuItem.children}">
          <c:set var="parentMenuItem" value="${topMenuItem.menuItem}" scope="request"/>
          <c:set var="parentMenuItemId" value="${fn:trim(menuItemStatus.count)}" scope="request"/>
          <c:set var="currentDepth" value="2" scope="request"/>
          <jsp:include page="helpers/horizontalAllSubitems.jsp" />
          <c:remove var="parentMenuItem" scope="request" />
          <c:remove var="parentMenuItemId" scope="request" />
          <c:remove var="currentDepth" scope="request" />
        </c:if>
      </c:forEach>
    </c:when>
    <c:otherwise><%-- it's active-subitems menu, hence display only the subitems of the active menu item --%>
      <%-- calling 'helpers/horizontalActiveSubitems.jsp' to render all the sub menu items of the currently active menu recursively --%>
      <c:if test="${not empty base and (menu.depth+0) > 1 and not empty activeMenuItem.children}">
        <c:set var="activeMenuItem" value="${activeMenuItem}" scope="request"/>
        <c:set var="currentDepth" value="2" scope="request"/>
        <jsp:include page="helpers/horizontalActiveSubitems.jsp" />
        <c:remove var="activeMenuItem" scope="request" />
        <c:remove var="currentDepth" scope="request" />
      </c:if>
    </c:otherwise>
  </c:choose>

  <c:set target="${menu}" property="levels" value="${horizontalLevelMapsList}" />
  <c:remove var="horizontalLevelMapsList" scope="request" />
</menu:use>