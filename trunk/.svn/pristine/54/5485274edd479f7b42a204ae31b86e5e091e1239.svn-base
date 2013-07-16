<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-actionLinks/src/main/webapp/template/widgets/actionLinks/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is controller for the default view of actionLinks widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="actionLinks" type="java.util.Map" scope="request" />

<!--read view specific configuration fields-->
<c:set target="${actionLinks}" property="selectedFields" value="${widgetContent.fields.actionLinksFields.value}"/>
<c:set var="profileLinkText" value="${fn:trim(widgetContent.fields.profileLinkText.value)}"/>
<c:if test="${empty profileLinkText}">
  <c:set var="profileLinkText">
    <fmt:message key="actionLinks.widget.profile.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="profileLinkText" value="${profileLinkText}"/>

<c:set var="addStoryLinkText" value="${fn:trim(widgetContent.fields.addStoryLinkText.value)}"/>
<c:if test="${empty addStoryLinkText}">
  <c:set var="addStoryLinkText">
    <fmt:message key="actionLinks.widget.addStory.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="addStoryLinkText" value="${addStoryLinkText}"/>

<c:set var="editStoryLinkText" value="${fn:trim(widgetContent.fields.editStoryLinkText.value)}"/>
<c:if test="${empty editStoryLinkText}">
  <c:set var="editStoryLinkText">
    <fmt:message key="actionLinks.widget.editStory.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="editStoryLinkText" value="${editStoryLinkText}"/>

<c:set var="deleteStoryLinkText" value="${fn:trim(widgetContent.fields.deleteStoryLinkText.value)}"/>
<c:if test="${empty deleteStoryLinkText}">
  <c:set var="deleteStoryLinkText">
    <fmt:message key="actionLinks.widget.deleteStory.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="deleteStoryLinkText" value="${deleteStoryLinkText}"/>

<c:set var="addPictureLinkText" value="${fn:trim(widgetContent.fields.addPictureLinkText.value)}"/>
<c:if test="${empty addPictureLinkText}">
  <c:set var="addPictureLinkText">
    <fmt:message key="actionLinks.widget.addPicture.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="addPictureLinkText" value="${addPictureLinkText}"/>

<c:set var="editPictureLinkText" value="${fn:trim(widgetContent.fields.editPictureLinkText.value)}"/>
<c:if test="${empty editPictureLinkText}">
  <c:set var="editPictureLinkText">
    <fmt:message key="actionLinks.widget.editPicture.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="editPictureLinkText" value="${editPictureLinkText}"/>

<c:set var="deletePictureLinkText" value="${fn:trim(widgetContent.fields.deletePictureLinkText.value)}"/>
<c:if test="${empty deletePictureLinkText}">
  <c:set var="deletePictureLinkText">
    <fmt:message key="actionLinks.widget.deletePicture.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="deletePictureLinkText" value="${deletePictureLinkText}"/>

<c:set var="logoutLinkText" value="${fn:trim(widgetContent.fields.logoutLinkText.value)}"/>
<c:if test="${empty logoutLinkText}">
  <c:set var="logoutLinkText">
    <fmt:message key="actionLinks.widget.logout.linkText"/>
  </c:set>
</c:if>
<c:set target="${actionLinks}" property="logoutLinkText" value="${logoutLinkText}"/>
