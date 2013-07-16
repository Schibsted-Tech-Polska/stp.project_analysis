<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/helpers/horizontalActiveSubitems.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the helper controller for the horizontal active subitems view of menu widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>
<%@ taglib prefix="menu" uri="http://www.escenic.com/taglib/escenic-menu" %>
<%@ taglib prefix="template" uri="http://www.escenic.com/taglib/escenic-template" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="currentDepth" type="java.lang.String" scope="request"/>
<jsp:useBean id="activeMenuItem" type="com.escenic.menu.MenuItem" scope="request"/>
<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request" />
<%-- the horizontal view controller has already created an ArrayList named 'horizontalLevelMapsList' in the requestScope --%>
<jsp:useBean id="horizontalLevelMapsList" type="java.util.ArrayList" scope="request" />

<util:profiler path="/template/widgets/menu/controller/helpers/horizontalActiveSubitems.jsp">
  <c:set var="menuTreeView" value="${menu.treeView}" />
  <c:set var="base" value="${menu.base}" />

  <collection:createList id="menuItemsList" type="java.util.ArrayList"/>  
  <%-- iterate through the generic view 'menu' upto depth ${currentDepth+1} --%>
  <view:iterate id="menuItem" name="menuTreeView" depth="${currentDepth+1}" type="com.escenic.menu.MenuItem">
    <%-- get the relationship between base and the current menu item --%>
    <view:relationships id="baseRelation" name="base"/>
    <%-- get the relationship between activeMenuItem and the current menu item --%>
    <view:relationships id="activeRelation" name="activeMenuItem" />
    <%--render only the submenu items of the currentDepth and the children of currently activeMenuItem --%>
    <c:if test="${menuItem.level == currentDepth and activeRelation.child}">
      <jsp:useBean id="currentMenuItem" class="java.util.HashMap"/>
      <c:set target="${currentMenuItem}" property="menuItem" value="${menuItem}"/>
      <c:set target="${currentMenuItem}" property="url" value="${menuItem.URL}"/>
      <c:set target="${currentMenuItem}" property="text" value="${menuItem.text}"/>


      <c:choose>
        <c:when test="${baseRelation.base || baseRelation.ancestor || baseRelation.parent}">
          <c:set var="currentActiveMenuItem" value="${menuItem}" />
          <c:set target="${currentMenuItem}" property="active" value="${true}"/>
        </c:when>
        <c:otherwise>
          <c:set target="${currentMenuItem}" property="active" value="${false}"/>
        </c:otherwise>
      </c:choose>
      <collection:add collection="${menuItemsList}" value="${currentMenuItem}" />
      <c:remove var="currentMenuItem" scope="page" />
    </c:if>
  </view:iterate>

  <c:if test="${not empty menuItemsList}">
    <jsp:useBean id="horizontalLevelMap" class="java.util.HashMap" />
    <c:set target="${horizontalLevelMap}" property="styleClass" value="${menu.subMenuStyleClass}" />
    <c:set target="${horizontalLevelMap}" property="items" value="${menuItemsList}"/>
    <collection:add collection="${horizontalLevelMapsList}" value="${horizontalLevelMap}"/>
    <c:remove var="horizontalLevelMap" scope="page"/>
  </c:if>

  <%--
    call 'horizontalActiveSubitems.jsp' itself,
    only if menuDepth > currentDepth and the currently active menu item has some children
    in order to render all the sub menu items of the currently active menu recursively
  --%>
  <c:if test="${(menu.depth+0) > (currentDepth+0) and not empty currentActiveMenuItem.children}">
    <template:call file="horizontalActiveSubitems.jsp">
      <template:parameter key="activeMenuItem" name="currentActiveMenuItem" />
      <template:parameter key="currentDepth" value="${currentDepth+1}"/>
      <template:parameter key="horizontalLevelMapsList" name="horizontalLevelMapsList" />
    </template:call>
  </c:if>
</util:profiler>

