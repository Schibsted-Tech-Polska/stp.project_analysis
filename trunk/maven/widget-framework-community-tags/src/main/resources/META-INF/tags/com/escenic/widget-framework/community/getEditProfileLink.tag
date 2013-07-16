<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getEditProfileLink.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--The purpose of this tag is to create an edit profile link --%>
<%@ tag language="java" body-content="empty" pageEncoding="UTF-8"%>
<%@ attribute name="linkText" required="false" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>


<c:set var="editProfileFormId" value="editProfileForm"/>

<profile:present>
  <section:use uniqueName="${user.userName}">
    <c:set var="sectionId" value="${section.id}"/>
  </section:use>

  <community:user id="userProfile" sectionId="${sectionId}"/>
  <c:if test="${not empty userProfile.article}">
    <html:form action="/community/loadUserProfileForm" styleId="${editProfileFormId}" style="float: left;">
      <html:hidden property="articleId" value="${userProfile.articleId}"/>
      <html:hidden property="publicationId" value="${publication.id}"/>
      <html:hidden property="successUrl" value="${publication.url}profile/editProfile/"/>
      <html:hidden property="errorUrl" value="${publication.url}profile/editProfile/"/>
    </html:form>

    <c:choose>
      <c:when test="${not empty fn:trim(linkText)}">
        <c:set var="editProfileLinkText" value="${fn:trim(linkText)}" />
      </c:when>
      <c:otherwise>
        <c:set var="editProfileLinkText">
          <fmt:message key="profileActions.widget.editProfile.link.text"/>
        </c:set>
      </c:otherwise>
    </c:choose>

    <a href="#" onclick="$('#${editProfileFormId}').submit(); return false;"><c:out value="${editProfileLinkText}" escapeXml="true"/></a>
  </c:if>
</profile:present>
