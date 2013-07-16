<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/submenu.jsp#1 $
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

<c:set target="${menu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepthSubmenu)}"/>
<c:set target="${menu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItemsSubmenu)}"/>

<c:set var="selectedLevels" value="${widgetContent.fields.submenuItems.value}" />

<%-- figure out what level to start and end --%>
<c:set target="${menu}" property="levelStart" value="${fn:split(selectedLevels, ',')[0]}" />
<c:set target="${menu}" property="levelEnd" value="${fn:split(selectedLevels, ',')[1]}" />

<%-- should ancestors be displayed? --%>
<c:set target="${menu}" property="showAncestors" value="${widgetContent.fields.showAncestors.value}"/>

<%-- create a generic view named 'menu' from the give ${menuTreeName} --%>
<menu:use id="menuTreeView" treeName="${menu.treeName}">
  <%-- base is the menu item for current section --%>
  <menu:item id="base"/>

  <c:set target="${menu}" property="treeView" value="${menuTreeView}" />
  <c:set target="${menu}" property="base" value="${base}" />
  <c:set target="${menu}" property="depth" value="${base.level+menu.levelEnd}"/>

  <%-- create collection for the menu items --%>
  <collection:createList id="topMenuItemMapsList" type="java.util.ArrayList"/>

  <%-- create collection for the ancestors --%>
  <c:if test="${menu.showAncestors}">
    <collection:createList id="ancestorMapsList" type="java.util.ArrayList"/>
  </c:if>

  <%-- iterate through the generic view 'menu', only in the top most level --%>
  <view:iterate id="menuItem" name="menuTreeView" type="com.escenic.menu.MenuItem">
    <jsp:useBean id="menuItemMap" class="java.util.HashMap"/>
    <%-- get the relationship between base and the current menu item --%>
    <view:relationships id="baseRelation" name="base"/>

    <%-- check if there's a parent to the current item to include otherwise skip the parent --%>
    <c:choose>
      <c:when test="${base.level+menu.levelStart == 0}">
        <c:set var="rootLevel" value="1"/>
      </c:when>
      <c:otherwise>
        <c:set var="rootLevel" value="${base.level+menu.levelStart}"/>
      </c:otherwise>
    </c:choose>

    <c:if test="${menu.showAncestors and menuItem.level < rootLevel and (baseRelation.ancestor or baseRelation.parent or baseRelation.base)}">
      <c:set target="${menuItemMap}" property="menuItem" value="${menuItem}"/>
      <c:set target="${menuItemMap}" property="url" value="${menuItem.URL}"/>
      <c:set target="${menuItemMap}" property="text" value="${menuItem.text}"/>
      <c:set target="${menuItemMap}" property="depth" value="${menuItem.level}"/>
      <c:set target="${menuItemMap}" property="active" value="${true}"/>
      <c:set target="${menuItemMap}" property="current" value="${false}"/>
      <collection:add collection="${ancestorMapsList}" value="${menuItemMap}" />
    </c:if>

    <c:if test="${not empty base and not empty baseRelation and menuItem.level == rootLevel and (baseRelation.descendant or baseRelation.ancestor or baseRelation.sibling or baseRelation.base)}">
      <c:set target="${menuItemMap}" property="menuItem" value="${menuItem}"/>
      <c:set target="${menuItemMap}" property="url" value="${menuItem.URL}"/>
      <c:set target="${menuItemMap}" property="text" value="${menuItem.text}"/>
      <c:set target="${menuItemMap}" property="depth" value="${menuItem.level}"/>
      <c:choose>
        <c:when test="${baseRelation.base}">
          <c:set target="${menuItemMap}" property="current" value="${true}"/>
        </c:when>
        <c:otherwise>
          <c:set target="${menuItemMap}" property="current" value="${false}"/>
        </c:otherwise>
      </c:choose>
      <c:choose>
        <c:when test="${baseRelation.base || baseRelation.ancestor || baseRelation.parent}">
          <c:set target="${menuItemMap}" property="active" value="${true}"/>
          <c:if test="${not empty base and not empty menuItem.children and (menu.depth+0) > menuItem.level}">
            <c:set var="activeMenuItemMap" value="${menuItemMap}" scope="request" />
            <jsp:include page="helpers/verticalActiveSubitems.jsp" />
            <c:remove var="activeMenuItemMap" scope="request"/>
          </c:if>
        </c:when>
        <c:otherwise> <%-- the current menu item is not active --%>
          <c:set target="${menuItemMap}" property="active" value="${false}"/>
        </c:otherwise>
      </c:choose>
      <collection:add collection="${topMenuItemMapsList}" value="${menuItemMap}" />
    </c:if>
    <c:remove var="menuItemMap" scope="page" />
  </view:iterate>

  <c:set target="${menu}" property="items" value="${topMenuItemMapsList}" />

  <c:if test="${menu.showAncestors}">
    <c:set target="${menu}" property="ancestors" value="${ancestorMapsList}" />
  </c:if>
</menu:use>