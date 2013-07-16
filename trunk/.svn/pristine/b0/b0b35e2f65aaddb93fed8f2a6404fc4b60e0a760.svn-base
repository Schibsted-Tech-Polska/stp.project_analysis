<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/editProfile.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the editProfile view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<div class="${profileActions.wrapperStyleClass}" <c:if test="${not empty profileActions.styleId}">id="${profileActions.styleId}"</c:if>>
  <profile:present>
    <c:choose>
      <c:when test="${not empty param.profileActions and param.profileActions eq 'success'}">
        <h1>
          <fmt:message key="profileActions.widget.editProfile.success.message" />
        </h1>
      </c:when>
      <c:otherwise>
        <h1>
          <c:out value="${profileActions.headline}" escapeXml="true"/>
        </h1>

        <section:use uniqueName="${user.userName}">
          <c:set var="homeSectionId" value="${section.id}" scope="request"/>
        </section:use>

        <c:if test="${profileActions.showProfileLinks}">
          <jsp:include page="helpers/links.jsp"/>
        </c:if>
        
        <jsp:include page="helpers/profileForm.jsp"/>
        <c:remove var="homeSectionId" scope="request"/>

      </c:otherwise>
    </c:choose>
  </profile:present>

  <profile:notPresent>
    <h1>
      <fmt:message key="profileActions.widget.notLoggedInUser"/>
    </h1>

    <h4>
      <fmt:message key="profileActions.widget.editProfile.notLoggedInUser">
        <fmt:param>
          <a href="${profileActions.loginUrl}"><fmt:message
              key="profileActions.widget.login.linkText"/></a>
        </fmt:param>
      </fmt:message>
    </h4>
  </profile:notPresent>
</div>

<c:remove var="profileActions" scope="request"/>