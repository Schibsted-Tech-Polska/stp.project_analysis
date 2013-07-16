<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/controller/controller.jsp#1 $
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
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- constants based on widget framework section naming conventions--%>
<c:set var="profileSectionUniqueName" value="profile" />
<c:set var="loginSectionUniqueName" value="login" />
<c:set var="registrationSectionUniqueName" value="registration" />
<c:set var="editProfileSectionUniqueName" value="editProfile" />
<c:set var="resetPasswordSectionUniqueName" value="resetPassword" />
<c:set var="deleteProfileSectionUniqueName" value="deleteProfile" />
<c:set var="changePasswordSectionUniqueName" value="changePassword" />
<c:set var="uploadProfilePictureSectionUniqueName" value="uploadProfilePicture" />

<%-- profile articleType name --%>
<c:set var="profileArticleTypeName" value="${section.parameters['usercontent.userProfile.articleTypeName']}" />
<c:if test="${empty profileArticleTypeName}">
  <c:set var="profileArticleTypeName" value="userProfile" />
</c:if>

<%--create the HashMap that will contain relevant field values --%>
<jsp:useBean id="profileActions" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<c:set target="${profileActions}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${profileActions}" property="showProfileLinks" value="${fn:trim(widgetContent.fields.showProfileLinks.value)}"/>
<c:set target="${profileActions}" property="headline" value="${fn:trim(element.fields.title.value)}"/>
<c:set target="${profileActions}" property="articleTypeName" value="${profileArticleTypeName}"/>
<c:set target="${profileActions}" property="sectionUniqueName" value="${profileSectionUniqueName}"/>
<section:use uniqueName="${profileSectionUniqueName}">
  <c:set target="${profileActions}" property="sectionUrl" value="${section.url}"/>
</section:use>

<wf-community:getLoginUrl var="loginUrl" sectionUniqueName="${loginSectionUniqueName}" />
<c:set target="${profileActions}" property="loginUrl" value="${loginUrl}"/>

<c:set target="${profileActions}" property="logoutUrl" value="${publication.url}community/logoff.do"/>

<section:use uniqueName="${registrationSectionUniqueName}">
  <c:set target="${profileActions}" property="registrationUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${editProfileSectionUniqueName}">
  <c:set target="${profileActions}" property="editProfileUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${resetPasswordSectionUniqueName}">
  <c:set target="${profileActions}" property="resetPasswordUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${changePasswordSectionUniqueName}">
  <c:set target="${profileActions}" property="changePasswordUrl" value="${section.url}"/>
</section:use>
<section:use uniqueName="${uploadProfilePictureSectionUniqueName}">
  <c:set target="${profileActions}" property="uploadProfilePictureUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${deleteProfileSectionUniqueName}">
  <c:set target="${profileActions}" property="deleteProfileUrl" value="${section.url}"/>
</section:use>

<c:set target="${profileActions}" property="styleId" value="${widgetContent.fields.styleId.value}"/>
<c:set target="${profileActions}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${profileActions}" property="wrapperStyleClass">widget profileActions ${profileActions.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty profileActions.customStyleClass}"> ${profileActions.customStyleClass}</c:if></c:set>