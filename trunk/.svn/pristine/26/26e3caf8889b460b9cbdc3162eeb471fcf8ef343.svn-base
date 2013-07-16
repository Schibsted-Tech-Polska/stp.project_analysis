<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/vertical.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the vertical view of menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>
<%@ taglib prefix="menu" uri="http://www.escenic.com/taglib/escenic-menu" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="template" uri="http://www.escenic.com/taglib/escenic-template" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the general controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />

<c:set target="${menu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepthVertical)}"/>
<c:set target="${menu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItemsVertical)}"/>

<%-- create a generic view named 'menu' from the give ${menuTreeName} --%>
<menu:use id="menuTreeView" treeName="${menu.treeName}">
  <%-- base is the menu item for current section --%>
  <menu:item id="base"/>

  <c:set target="${menu}" property="treeView" value="${menuTreeView}" />
  <c:set target="${menu}" property="base" value="${base}" />

  <collection:createList id="topMenuItemMapsList" type="java.util.ArrayList"/>
  <%-- iterate through the generic view 'menu', only in the top most level --%>
  <view:iterate id="menuItem" name="menuTreeView" depth="2" type="com.escenic.menu.MenuItem">
    <%-- get the relationship between base and the current menu item --%>
    <view:relationships id="baseRelation" name="base"/>
    <c:if test="${menuItem.level == 1}">
      <jsp:useBean id="menuItemMap" class="java.util.HashMap"/>
      <c:set target="${menuItemMap}" property="menuItem" value="${menuItem}"/>
      <c:set target="${menuItemMap}" property="url" value="${menuItem.URL}"/>
      <c:set target="${menuItemMap}" property="text" value="${menuItem.text}"/>
      <c:set target="${menuItemMap}" property="depth" value="1"/>

      <c:choose>
        <c:when test="${baseRelation.base || baseRelation.ancestor || baseRelation.parent}">
          <c:set target="${menuItemMap}" property="active" value="${true}"/>

          <c:if test="${menu.displayItems=='active' and not empty base and (menu.depth+0) > 1 and not empty menuItem.children}">
            <c:set var="activeMenuItemMap" value="${menuItemMap}" scope="request" />
            <jsp:include page="helpers/verticalActiveSubitems.jsp" />
            <c:remove var="activeMenuItemMap" scope="request"/>
          </c:if>
        </c:when>
        <c:otherwise> <%-- the current menu item is not active --%>
          <c:set target="${menuItemMap}" property="active" value="${false}"/>
        </c:otherwise>
      </c:choose>

      <%--
        if the displayItems is all, then call 'helpers/verticalAllSubitems.jsp'
        in order to render all the sub menu items of the current menu item recursively
      --%>
      <c:if test="${menu.displayItems=='all' and not empty base and (menu.depth+0) > 1 and not empty menuItem.children}">
        <c:set var="parentMenuItemMap" value="${menuItemMap}" scope="request"/>
        <jsp:include page="helpers/verticalAllSubitems.jsp" />
        <c:remove var="parentMenuItemMap" scope="request" />
      </c:if>

      <collection:add collection="${topMenuItemMapsList}" value="${menuItemMap}" />
      <c:remove var="menuItemMap" scope="page" />
    </c:if>
  </view:iterate>

  <c:set target="${menu}" property="items" value="${topMenuItemMapsList}" />
</menu:use>