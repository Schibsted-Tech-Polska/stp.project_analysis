<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileMenu/src/main/webapp/template/widgets/profileMenu/controller/controller.jsp#1 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- constants based on widget framework section naming conventions--%>
<c:set var="loginSectionUniqueName" value="login" />
<c:set var="registrationSectionUniqueName" value="registration" />
<c:set var="editProfileSectionUniqueName" value="editProfile" />

<%--create a hashmap named 'profileMenu' that will contain relevant field values --%>
<jsp:useBean id="profileMenu" class="java.util.HashMap" scope="request" />

<%-- retreive necessary parameters --%>
<c:set target="${profileMenu}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${profileMenu}" property="showAvatar" value="${fn:trim(widgetContent.fields.showAvatar)}" />
<c:set target="${profileMenu}" property="avatarImageVersion" value="${fn:trim(widgetContent.fields.avatarImageVersion)}" />
<c:set target="${profileMenu}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
<c:set target="${profileMenu}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>

<wf-community:getLoginUrl var="loginUrl" sectionUniqueName="${loginSectionUniqueName}" />
<c:set target="${profileMenu}" property="loginUrl" value="${loginUrl}"/>

<section:use uniqueName="${registrationSectionUniqueName}">
  <c:set target="${profileMenu}" property="registrationUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${editProfileSectionUniqueName}">
  <c:set target="${profileMenu}" property="editProfileUrl" value="${section.url}"/>
</section:use>

<c:set target="${profileMenu}" property="logoutUrl" value="${publication.url}community/logoff.do"/>

<profile:present>
  <section:use uniqueName="${user.userName}">
    <community:user id="currentUser" sectionId="${section.id}"/>
    <c:set target="${profileMenu}" property="username" value="${currentUser.article.fields.username}"/>
    <c:set target="${profileMenu}" property="userProfileUrl" value="${currentUser.section.url}"/>
  </section:use>
  <c:if test="${profileMenu.showAvatar == true and
                  not empty currentUser.article.relatedElements.profilePictures.items
                  and currentUser.article.relatedElements.profilePictures.items[0].content.articleTypeName == 'avatar'}">
    <c:set target="${profileMenu}" property="avatarPicture" value="${currentUser.article.relatedElements.profilePictures.items[0].content}"/>
  </c:if>
</profile:present>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${profileMenu}" property="wrapperStyleClass">widget profileMenu ${profileMenu.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty profileMenu.customStyleClass}"> ${profileMenu.customStyleClass}</c:if></c:set>