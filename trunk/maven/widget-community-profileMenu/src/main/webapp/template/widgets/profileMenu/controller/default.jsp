  <%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileMenu/src/main/webapp/template/widgets/profileMenu/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--  This is general controller of the profileMenu widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--use the map named 'profileMenu' containing relevant field values --%>
<jsp:useBean id="profileMenu" type="java.util.Map" scope="request" />

<!--read view specific fields-->
<c:set var="loginLinkText" value="${fn:trim(widgetContent.fields.loginLinkText)}"/>
<c:if test="${empty loginLinkText}">
  <c:set var="loginLinkText">
    <fmt:message key="profileMenu.widget.login.linkText"/>
  </c:set>
</c:if>
<c:set target="${profileMenu}" property="loginLinkText" value="${loginLinkText}"/>

<c:set var="registrationLinkText" value="${fn:trim(widgetContent.fields.registrationLinkText)}"/>
<c:if test="${empty registrationLinkText}">
  <c:set var="registrationLinkText">
    <fmt:message key="profileMenu.widget.registration.linkText"/>
  </c:set>
</c:if>
<c:set target="${profileMenu}" property="registrationLinkText" value="${registrationLinkText}"/>
<c:set target="${profileMenu}" property="welcomeText" value="${fn:trim(widgetContent.fields.welcomeText)}"/>

<c:set var="editProfileLinkText" value="${fn:trim(widgetContent.fields.editProfileLinkText)}"/>
<c:if test="${empty editProfileLinkText}">
  <c:set var="editProfileLinkText">
    <fmt:message key="profileMenu.widget.editProfile.linkText"/>
  </c:set>
</c:if>
<c:set target="${profileMenu}" property="editProfileLinkText" value="${editProfileLinkText}"/>

<c:set var="logoutLinkText" value="${fn:trim(widgetContent.fields.logoutLinkText)}"/>
<c:if test="${empty logoutLinkText}">
  <c:set var="logoutLinkText">
    <fmt:message key="profileMenu.widget.logout.linkText"/>
  </c:set>
</c:if>
<c:set target="${profileMenu}" property="logoutLinkText" value="${logoutLinkText}"/>