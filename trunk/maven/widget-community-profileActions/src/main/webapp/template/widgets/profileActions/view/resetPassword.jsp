<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/resetPassword.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the resetPassword view of the profileActions widget --%>
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
  <profile:notPresent>
    <c:choose>
      <c:when test="${param.profileActions!='success'}">
        <h1>
          <c:out value="${profileActions.headline}" escapeXml="true"/>
        </h1>

        <h4>
          <fmt:message key="profileActions.widget.resetPassword.meesgae" />
        </h4>

        <html:xhtml/>
        <html:form action="${profileActions.action}" styleClass="resetPassword">
          <fieldset>
            <html:hidden property="successUrl" value="${profileActions.successUrl}"/>
            <html:hidden property="errorUrl" value="${profileActions.errorUrl}"/>

            <c:set var="globalErrorMessage"><html:errors property="error" /></c:set>
            <c:set var="usernameErrorMessage"><html:errors property="userName" /></c:set>

            <dl>
              <dt>
                <label for="userName">
                  <fmt:message key="profileActions.widget.resetPassword.username.label" />
                </label>
              </dt>
              <dd>
                <html:text tabindex="1" property="userName" styleId="userName" styleClass="text-field"/>

                <c:choose>
                  <c:when test="${not empty fn:trim(globalErrorMessage)}">
                    <p class="error"><c:out value="${fn:trim(globalErrorMessage)}" escapeXml="true"/></p>
                  </c:when>
                  <c:when test="${not empty fn:trim(usernameErrorMessage)}">
                    <p class="error"><c:out value="${fn:trim(usernameErrorMessage)}" escapeXml="true"/></p>
                  </c:when>
                </c:choose>
              </dd>
            </dl>
            <dl>
              <dt>&nbsp;</dt>
              <dd>
                <html:submit tabindex="2" property="resetPasswordSubmit" styleClass="button">
                  <fmt:message key="profileActions.widget.resetPassword.submitButton.label" />
                </html:submit>
              </dd>
            </dl>
          </fieldset>
        </html:form>

        <div class="links">
          <ul>
            <li class="first">
              <a href="${profileActions.loginUrl}">
                <fmt:message key="profileActions.widget.login.header" />
              </a>
            </li>
            <li>
              <fmt:message key="profileActions.widget.noAccount.label" />
              <a href="${profileActions.registrationUrl}"><fmt:message
                  key="profileActions.widget.noAccount.linkText"/></a>
            </li>
          </ul>
        </div>        
      </c:when>
      <c:otherwise>
        <h1>
          <fmt:message key="profileActions.widget.resetPassword.success" />
        </h1>
      </c:otherwise>
    </c:choose>

  </profile:notPresent>

  <profile:present>
    <section:use uniqueName="${user.userName}">
      <community:user id="currentUser" sectionId="${section.id}" />
    </section:use>
    <h1>
      <fmt:message key="profileActions.widget.loggedInUser">
        <fmt:param>
          <a href="${currentUser.section.url}"><c:out value="${currentUser.article.fields.username}" escapeXml="true"/></a>
        </fmt:param>
      </fmt:message>
    </h1>
    <c:if test="${profileActions.showProfileLinks}">
      <jsp:include page="helpers/links.jsp"/>
    </c:if>
    <h4>
      <fmt:message var="logoutLinkText" key="profileActions.widget.logout.linkText" />

      <fmt:message key="profileActions.widget.resetPassword.loggedInUser">
        <fmt:param>
          <a href="${profileActions.logoutUrl}"><c:out value="${logoutLinkText}" escapeXml="true"/></a>
        </fmt:param>
      </fmt:message>
    </h4>
  </profile:present>

</div>

<c:remove var="profileActions" scope="request" />