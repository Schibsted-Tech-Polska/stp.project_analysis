<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/controller/breadcrumb.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the default view of breadcrumb widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>
<%@ taglib prefix="menu" uri="http://www.escenic.com/taglib/escenic-menu" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the general controller has already set a HashMap named 'navigation' in the requestScope --%>
<jsp:useBean id="navigation" type="java.util.HashMap" scope="request"/>

<collection:createList id="breadcrumbItems" type="java.util.ArrayList"/>

<menu:use id="menu" treeName="${navigation.menuName}">
  <menu:item id="base"/>
  <view:iterate id="menuItem" name="menu">
    <view:relationships id="relation" name="base"/>
    <c:if test="${relation.base or relation.ancestor or menuItem.section.uniqueName == 'ece_frontpage'}">
      <jsp:useBean id="breadcrumbItem" class="java.util.HashMap" />
      <c:set target="${breadcrumbItem}" property="active" value="${relation.base}"/>
      <c:set target="${breadcrumbItem}" property="url" value="${menuItem.URL}"/>
      <c:set target="${breadcrumbItem}" property="text" value="${menuItem.text}"/>
      <collection:add collection="${breadcrumbItems}" value="${breadcrumbItem}" />
      <c:remove var="breadcrumbItem" scope="page" />
    </c:if>
  </view:iterate>
</menu:use>


<c:set target="${navigation}" property="items" value="${breadcrumbItems}"/>