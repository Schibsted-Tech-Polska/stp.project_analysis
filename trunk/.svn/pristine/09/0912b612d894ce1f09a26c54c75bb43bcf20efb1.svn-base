<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profile/src/main/webapp/template/widgets/profile/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- constants based on widget framework section naming conventions--%>
<c:set var="profileSectionUniqueName" value="profile" />
<c:set var="editProfileSectionUniqueName" value="editProfile" />
<c:set var="changePasswordSectionUniqueName" value="changePassword" />

<%-- profile articleType name --%>
<c:set var="profileArticleTypeName" value="${section.parameters['usercontent.userProfile.articleTypeName']}" />
<c:if test="${empty profileArticleTypeName}">
  <c:set var="profileArticleTypeName" value="userProfile" />
</c:if>

<%--create the HashMap that will contain relevant field values --%>
<jsp:useBean id="profile" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${profile}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${profile}" property="showAvatar" value="${fn:trim(widgetContent.fields.showAvatar.value)}"/>
<c:set target="${profile}" property="avatarImageVersion" value="${fn:trim(widgetContent.fields.avatarImageVersion.value)}"/>
<c:set target="${profile}" property="avatarImageWidth" value="${fn:substring(profile.avatarImageVersion, 1,fn:length(profile.avatarImageVersion))}"/>
<c:set target="${profile}" property="articleTypeName" value="${profileArticleTypeName}"/>


<c:set target="${profile}" property="sectionUniqueName" value="${profileSectionUniqueName}"/>
<section:use uniqueName="${profileSectionUniqueName}">
  <c:set target="${profile}" property="sectionUrl" value="${section.url}"/>
</section:use>

<c:set target="${profile}" property="logoutUrl" value="${publication.url}community/logoff.do"/>

<section:use uniqueName="${editProfileSectionUniqueName}">
  <c:set target="${profile}" property="editProfileUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${changePasswordSectionUniqueName}">
  <c:set target="${profile}" property="changePasswordUrl" value="${section.url}"/>
</section:use>

<c:set target="${profile}" property="styleId" value="${widgetContent.fields.styleId.value}"/>
<c:set target="${profile}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${profile}" property="wrapperStyleClass">widget profile ${profile.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty profile.customStyleClass}"> ${profile.customStyleClass}</c:if></c:set>