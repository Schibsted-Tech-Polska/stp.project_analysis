<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/deleteProfile.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the deleteProfile view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<div class="${profileActions.wrapperStyleClass}" <c:if test="${not empty profileActions.styleId}">id="${profileActions.styleId}"</c:if>>
  <profile:present>
    <h1>
      <c:out value="${profileActions.headline}" escapeXml="true"/>
    </h1>
    <c:if test="${profileActions.showProfileLinks}">
      <jsp:include page="helpers/links.jsp"/>
    </c:if>   
    <h2>
      <fmt:message key="profileActions.widget.deleteProfile.confirm" />
    </h2>

    <h5>
      <fmt:message key="profileActions.widget.deleteProfile.warning"/>
    </h5>

    <section:use uniqueName="${user.userName}">
      <community:user id="currentUser" sectionId="${section.id}"/>
    </section:use>

    <html:form action="${profileActions.action}" styleClass="${profileActions.view}">
      <html:hidden property="articleId" value="${currentUser.article.id}"/>
      <html:hidden property="homeSectionId" value="${currentUser.section.id}"/>
      <html:hidden property="successUrl" value="${profileActions.successUrl}"/>
      <html:hidden property="errorUrl" value="${profileActions.errorUrl}"/>

      <p class="buttons">
        <html:submit styleClass="button" tabindex="1" property="deleteProfileSubmit">
          <fmt:message key="profileActions.widget.deleteProfile.submitButton.label" />
        </html:submit>

        <html:cancel styleClass="button"  tabindex="2" onclick="window.location='${publication.url}';return false;">
          <fmt:message key="profileActions.widget.deleteProfile.cancelButton.label" />
        </html:cancel>
      </p>
    </html:form>
  </profile:present>

  <profile:notPresent>
    <c:choose>
      <c:when test="${not empty param.profileActions and param.profileActions eq 'success'}">
        <h1><fmt:message key="profileActions.widget.deleteProfile.success.message"/></h1>
      </c:when>
      <c:otherwise>
        <h1>
          <fmt:message key="profileActions.widget.notLoggedInUser"/>
        </h1>

        <h4>
          <fmt:message key="profileActions.widget.deleteProfile.notLoggedInUser">
            <fmt:param>
              <a href="${profileActions.loginUrl}"><fmt:message
                  key="profileActions.widget.login.linkText"/></a>
            </fmt:param>
          </fmt:message>
        </h4>
      </c:otherwise>
    </c:choose>
  </profile:notPresent>
</div>

<c:remove var="profileActions" scope="request" />