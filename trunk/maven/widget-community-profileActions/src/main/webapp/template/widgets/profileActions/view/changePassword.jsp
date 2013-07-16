<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/changePassword.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the changePassword view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<div class="${profileActions.wrapperStyleClass}" <c:if test="${not empty profileActions.styleId}">id="${profileActions.styleId}"</c:if>>
  <profile:present>
    <c:choose>
      <c:when test="${param.profileActions!='success'}">
        <h1>
          <c:out value="${profileActions.headline}" escapeXml="true"/>
        </h1>
        <c:if test="${profileActions.showProfileLinks}">
          <jsp:include page="helpers/links.jsp"/>
        </c:if>
        <c:set var="globalErrorMessage"><html:errors property="global" /></c:set>
        <c:set var="oldPasswordErrorMessage"><html:errors property="oldPassword" /></c:set>
        <c:set var="passwordErrorMessage"><html:errors property="password" /></c:set>
        <c:set var="confirmPasswordErrorMessage"><html:errors property="confirmPassword" /></c:set>

        <html:xhtml/>
        <html:form action="${profileActions.action}" styleClass="changePassword">
          <fieldset>
            <html:hidden property="successUrl" value="${profileActions.successUrl}"/>
            <html:hidden property="errorUrl" value="${profileActions.errorUrl}"/>

            <dl>
              <dt>
                <label for="oldPassword">
                  <fmt:message key="profileActions.widget.changePassword.oldPassword.label"/>
                </label>
              </dt>
              <dd>
                <html:password property="oldPassword" styleId="oldPassword" tabindex="1" styleClass="text-field"/>

                <c:choose>
                  <c:when test="${not empty fn:trim(globalErrorMessage)}">
                    <p class="error"><c:out value="${fn:trim(globalErrorMessage)}" escapeXml="true"/></p>
                  </c:when>
                  <c:when test="${not empty fn:trim(oldPasswordErrorMessage)}">
                    <p class="error"><c:out value="${fn:trim(oldPasswordErrorMessage)}" escapeXml="true"/></p>
                  </c:when>
                </c:choose>
              </dd>
            </dl>

            <dl>
              <dt>
                <label for="password">
                  <fmt:message key="profileActions.widget.changePassword.newPassword.label"/>
                </label>
              </dt>
              <dd>
                <html:password property="password" styleId="password" tabindex="2" styleClass="text-field"/>
                <c:if test="${not empty fn:trim(passwordErrorMessage)}">
                  <p class="error"><c:out value="${fn:trim(passwordErrorMessage)}" escapeXml="true"/></p>
                </c:if>
              </dd>
            </dl>

            <dl>
              <dt>
                <label for="confirmPassword">
                  <fmt:message key="profileActions.widget.changePassword.confirmPassword.label"/>
                </label>
              </dt>
              <dd>
                <html:password property="confirmPassword" styleId="confirmPassword" tabindex="3" styleClass="text-field"/>
                <c:if test="${not empty fn:trim(confirmPasswordErrorMessage)}">
                  <p class="error"><c:out value="${fn:trim(confirmPasswordErrorMessage)}" escapeXml="true"/></p>
                </c:if>
              </dd>
            </dl>

            <dl>
              <dt>&nbsp;</dt>
              <dd>
                <html:submit tabindex="4" property="changePasswordSubmit" styleClass="button">
                  <fmt:message key="profileActions.widget.changePassword.submitButton.label" />
                </html:submit>
              </dd>
            </dl>
          </fieldset>
        </html:form>
      </c:when>
      <c:otherwise>
        <h1>
          <fmt:message key="profileActions.widget.changePassword.success"/>
        </h1>
      </c:otherwise>
    </c:choose>
  </profile:present>

  <profile:notPresent>
    <h1>
      <fmt:message key="profileActions.widget.notLoggedInUser"/>
    </h1>

    <h4>
      <fmt:message key="profileActions.widget.changePassword.notLoggedInUser">
        <fmt:param>
          <a href="${profileActions.loginUrl}"><fmt:message
              key="profileActions.widget.login.linkText" /></a>
        </fmt:param>
      </fmt:message>
    </h4>
  </profile:notPresent>

</div>

<c:remove var="profileActions" scope="request" />