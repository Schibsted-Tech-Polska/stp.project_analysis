<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/controller/menuNode.jsp#1 $
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

<c:set target="${menu}" property="depth" value="${fn:trim(widgetContent.fields.menuDepthMenuNode)}"/>
<c:set target="${menu}" property="displayItems" value="${fn:trim(widgetContent.fields.displayItemsMenuNode)}"/>

<c:set target="${menu}" property="selectedNode" value="${widgetContent.fields.menuNode.value}" />
<c:set target="${menu}" property="label" value="${widgetContent.fields.label.value}" />

<%-- create a generic view named 'menu' from the give ${menuTreeName} --%>

<menu:use id="menuTreeView" treeName="${menu.treeName}">
  <menu:item id="base"/>

  <c:set target="${menu}" property="treeView" value="${menuTreeView}" />
  <c:set target="${menu}" property="base" value="${base}" />

  <jsp:useBean id="menuNodeMap" class="java.util.HashMap"/>

  <c:set var="nodeFound" value="${false}" />

  <view:iterate id="node" name="menuTreeView" type="com.escenic.menu.MenuItem">
    <view:relationships id="baseRelation" name="base"/>

    <c:if test="${not nodeFound}">
      <c:choose>
        <c:when test="${menu.selectedNode eq 'current' and baseRelation.base}">
          <c:set var="menuNode" value="${node}"/>
          <c:set var="nodeFound" value="${true}" />
        </c:when>
        <c:when test="${menu.selectedNode eq 'parent' and baseRelation.parent}">
          <c:set var="menuNode" value="${node}"/>
          <c:set var="nodeFound" value="${true}" />
        </c:when>
        <c:when test="${menu.selectedNode eq 'next' and (baseRelation.sibling or baseRelation.base)}">
          <%-- found a candidate, only store it when we didn't already find one --%>
          <c:if test="${empty menuNode}">
            <c:set var="menuNode" value="${node}"/>
          </c:if>

          <%-- if we found the base node after we found the candidate, empty it since that one is not the next --%>
          <c:if test="${baseRelation.base}">
            <c:set var="menuNode" value="${null}"/>
          </c:if>

          <%-- if we are at the end of the list, stop searching --%>
          <c:if test="${baseRelation.lastChild}">
            <c:set var="nodeFound" value="${true}" />
          </c:if>
        </c:when>
        <c:when test="${menu.selectedNode eq 'previous' and baseRelation.sibling or baseRelation.base}">
          <%-- when we reach the base node, we are done searching --%>
          <c:if test="${baseRelation.base}">
            <c:set var="nodeFound" value="${true}" />
          </c:if>

          <%-- found a candidate, store it, if this would be the second we found, overwrite it --%>
          <c:if test="${not nodeFound}">
            <c:set var="menuNode" value="${node}"/>
          </c:if>
        </c:when>
      </c:choose>
    </c:if>
  </view:iterate>

  <c:if test="${not empty menuNode}">
    <c:set target="${menuNodeMap}" property="menuNode" value="${menuNode}"/>
    <c:set target="${menuNodeMap}" property="url" value="${menuNode.URL}"/>
    <c:set target="${menuNodeMap}" property="text" value="${menuNode.text}"/>
  </c:if>

  <c:set target="${menu}" property="menuNode" value="${menuNodeMap}" />
</menu:use>
