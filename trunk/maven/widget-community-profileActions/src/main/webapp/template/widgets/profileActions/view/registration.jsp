<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/registration.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the registration view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<div class="${profileActions.wrapperStyleClass}" <c:if test="${not empty profileActions.styleId}">id="${profileActions.styleId}"</c:if>>
  <profile:notPresent>
    <c:choose>
      <c:when test="${not empty param.profileActions and param.profileActions eq 'success'}">
        <h1>
          <fmt:message key="profileActions.widget.registration.success.message"/>
        </h1>

        <h2>
          <fmt:message key="profileActions.widget.registration.check.email.message"/>
        </h2>
      </c:when>
      <c:otherwise>
        <h1><c:out value="${profileActions.headline}" escapeXml="true"/></h1>

        <div class="links">
          <ul>
            <li class="first">
              <fmt:message key="profileActions.widget.hasAccount.label"/>
              <a href="${profileActions.loginUrl}"><fmt:message
                  key="profileActions.widget.hasAccount.linkText"/></a>
            </li>
            <li>
              <a href="${profileActions.resetPasswordUrl}"><fmt:message
                  key="profileActions.widget.resetPassword.header"/></a>
            </li>
          </ul>
        </div>

        <section:use uniqueName="${profileActions.sectionUniqueName}">
          <c:set var="homeSectionId" value="${section.id}" scope="request"/>
        </section:use>
        <jsp:include page="helpers/profileForm.jsp"/>
        <c:remove var="homeSectionId" scope="request"/>
      </c:otherwise>
    </c:choose>
  </profile:notPresent>

  <profile:present>
    <section:use uniqueName="${user.userName}">
      <community:user id="currentUser" sectionId="${section.id}"/>       
    </section:use>
    <h1>
      <fmt:message key="profileActions.widget.loggedInUser">
        <fmt:param>
          <a href="${currentUser.section.url}"><c:out value="${currentUser.article.fields.username}" escapeXml="true"/></a>
        </fmt:param>
      </fmt:message>
    </h1>

    <h4>
      <fmt:message var="logoutLinkText" key="profileActions.widget.logout.linkText" />

      <fmt:message key="profileActions.widget.registration.loggedInUser">
        <fmt:param>
          <a href="${profileActions.logoutUrl}"><c:out value="${logoutLinkText}" escapeXml="true"/></a>
        </fmt:param>
      </fmt:message>
    </h4>
  </profile:present>
</div>

<c:remove var="profileActions" scope="request" />