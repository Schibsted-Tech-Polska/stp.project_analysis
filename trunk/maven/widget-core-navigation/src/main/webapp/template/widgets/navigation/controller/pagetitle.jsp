<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/controller/pagetitle.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the pagetitle view of navigation widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- the general controller has already set a HashMap named 'navigation' in the requestScope --%>
<jsp:useBean id="navigation" type="java.util.HashMap" scope="request"/>

<c:if test="${empty navigation.pagetitle}">
  <c:set target="${navigation}" property="pagetitle" value="${section.name}"/>
</c:if>



