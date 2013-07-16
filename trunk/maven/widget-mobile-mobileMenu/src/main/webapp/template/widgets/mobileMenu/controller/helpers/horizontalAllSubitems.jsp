<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileMenu/src/main/webapp/template/widgets/mobileMenu/controller/helpers/horizontalAllSubitems.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the helper controller for the horizontal all subitems view of menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>
<%@ taglib prefix="menu" uri="http://www.escenic.com/taglib/escenic-menu" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="template" uri="http://www.escenic.com/taglib/escenic-template" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="currentDepth" type="java.lang.String" scope="request"/>
<jsp:useBean id="parentMenuItem" type="com.escenic.menu.MenuItem" scope="request"/>
<jsp:useBean id="parentMenuItemId" type="java.lang.String" scope="request"/>
<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="mobileMenu" type="java.util.HashMap" scope="request"/>
<%-- the horizontal view controller has already created an ArrayList named 'horizontalLevelMapsList' in the requestScope --%>
<jsp:useBean id="horizontalLevelMapsList" type="java.util.ArrayList" scope="request"/>

<util:profiler path="/template/widgets/mobileMenu/controller/helpers/horizontalAllSubitems.jsp">
  <c:set var="menuTreeView" value="${mobileMenu.treeView}"/>
  <c:set var="base" value="${mobileMenu.base}"/>

  <collection:createList id="parentMenuItemsList" type="java.util.ArrayList"/>
  <%-- iterate through the generic view 'menu' upto depth ${currentDepth+1} --%>
  <view:iterate id="menuItem" name="menuTreeView" depth="${currentDepth+1}" type="com.escenic.menu.MenuItem">
    <%-- get the relationship between base and the current menu item --%>
    <view:relationships id="baseRelation" name="base"/>
    <%-- get the relationship between parentMenuItem and the current menu item --%>
    <view:relationships id="parentMenuItemRelation" name="parentMenuItem"/>
    <%--render only the submenu items of the currentDepth and the children of currently activeMenuItem --%>
    <c:if test="${menuItem.level == currentDepth and parentMenuItemRelation.child}">
      <jsp:useBean id="currentMenuItem" class="java.util.HashMap"/>
      <c:set target="${currentMenuItem}" property="menuItem" value="${menuItem}"/>
      <c:set target="${currentMenuItem}" property="url" value="${menuItem.URL}"/>
      <c:set target="${currentMenuItem}" property="text" value="${menuItem.text}"/>
      <c:set target="${currentMenuItem}" property="active"
             value="${baseRelation.base || baseRelation.ancestor || baseRelation.parent}"/>
      <collection:add collection="${parentMenuItemsList}" value="${currentMenuItem}"/>
      <c:remove var="currentMenuItem" scope="page"/>
    </c:if>
  </view:iterate>

  <c:if test="${not empty parentMenuItemsList}">
    <jsp:useBean id="horizontalLevelMap" class="java.util.HashMap"/>
    <c:set target="${horizontalLevelMap}" property="styleId" value="subMenu${parentMenuItemId}"/>
    <c:set target="${horizontalLevelMap}" property="styleClass" value="${menu.subMenuStyleClass}"/>
    <c:set target="${horizontalLevelMap}" property="items" value="${parentMenuItemsList}"/>
    <collection:add collection="${horizontalLevelMapsList}" value="${horizontalLevelMap}"/>
    <c:remove var="horizontalLevelMap" scope="page"/>
  </c:if>

  <c:forEach var="currentMenuItem" items="${parentMenuItemsList}" varStatus="menuItemStatus">
    <%--
      call 'activeSubitemsHorizontal.jsp' itself,
      only if menuDepth > currentDepth and the currently active menu item has some children
      in order to render all the sub menu items of the currently active menu recursively
    --%>
    <c:set var="parentMenuItem" value="${currentMenuItem.menuItem}"/>
    <c:if test="${(mobileMenu.depth+0) > (currentDepth+0) and not empty currentMenuItem.menuItem.children}">
      <template:call file="horizontalAllSubitems.jsp">
        <template:parameter key="parentMenuItem" name="parentMenuItem"/>
        <template:parameter key="currentDepth" value="${currentDepth+1}"/>
        <template:parameter key="parentMenuItemId" value="${parentMenuItemId}${menuItemStatus.count}"/>
      </template:call>
    </c:if>
    <c:remove var="parentMenuItem" scope="page"/>
  </c:forEach>
</util:profiler>


