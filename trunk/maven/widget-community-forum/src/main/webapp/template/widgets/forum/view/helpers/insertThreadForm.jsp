<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/insertThreadForm.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this jsp renders the threads view of forum widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<%-- the controller has already set a hashmap named 'forum' in the requestScope --%>
<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<%-- required parameters list --%>
<c:set var="formContainerId" value="${param.formContainerId}" />
<c:set var="formContainerStyle" value="${param.formContainerStyle}" />
<c:set var="forumId" value="${param.forumId}" />
<c:set var="successUrl" value="${param.successUrl}" />
<c:set var="errorUrl" value="${param.errorUrl}" />

<c:set var="titleFieldErrorId" value="title-error-${formContainerId}" />
<c:set var="bodyFieldErrorId" value="body-error-${formContainerId}" />

<fmt:message var="titleFieldErrorMessage" key="forum.widget.thread.form.input.title.empty"/>
<fmt:message var="bodyFieldErrorMessage" key="forum.widget.thread.form.input.body.empty"/>

<div id="${formContainerId}" class="forumForm" style="${formContainerStyle}">
  <h3>
    <fmt:message key="forum.widget.thread.form.new.headline" />
  </h3>

  <html:xhtml/>
  <html:form action="/community/addThread" method="post"
             onsubmit="return validatePostingForm(this, '${bodyFieldErrorId}', '${bodyFieldErrorMessage}', '${titleFieldErrorId}', '${titleFieldErrorMessage}');">

    <html:hidden property="forumId" value="${forumId}"/>
    <html:hidden property="email" value="${sessionScope.user.email}" />
    <html:hidden property="typeName" value="posting"/>

    <html:hidden property="field(byline)"
                 value="${sessionScope.user.firstName} ${sessionScope.user.surName}" />
    <html:hidden property="field(userId)" value="${sessionScope.user.id}" />

    <html:hidden property="targetUrl" value="${successUrl}"/>
    <html:hidden property="errorUrl" value="${errorUrl}"/>

    <fieldset>
      <dl>
        <dt>
          <label for="title-${formContainerId}">
            <fmt:message key="forum.widget.thread.form.title.field.label" />
          </label>
        </dt>
        <dd>
          <html:text property="title" tabindex="1" styleId="title-${formContainerId}" styleClass="text-field title-field"/>

          <div class="field-status">
            <div id="${titleFieldErrorId}" class="status-left error">&nbsp;</div>

            <div id="limiter-title-${formContainerId}" class="status-right limiter">
              <span><c:out value="${forum.threadTitleLength}"/></span> <fmt:message key="forum.widget.posting.form.input.text.restriction.message"/>
            </div>
          </div>

          <script type="text/javascript">
            // <![CDATA[
            $("#title-${formContainerId}").charCounter(${forum.threadTitleLength}, {
                container: "#limiter-title-${formContainerId} span",
                format: "%1",
                pulse: false,
                delay: 100
              });
            // ]]>
          </script>
        </dd>
      </dl>

      <dl>
        <dt>
          <label for="body-${formContainerId}">
            <fmt:message key="forum.widget.thread.form.body.field.label" />
          </label>
        </dt>
        <dd>
          <html:textarea property="body" tabindex="2" styleId="body-${formContainerId}" styleClass="body-field"/>

          <div class="field-status">
            <div id="${bodyFieldErrorId}" class="status-left error">&nbsp;</div>

            <div id="limiter-body-${formContainerId}" class="status-right limiter">
              <span><c:out value="${forum.threadBodyLength}"/></span> <fmt:message key="forum.widget.posting.form.input.text.restriction.message"/>
            </div>
          </div>

          <script type="text/javascript">
            // <![CDATA[
            $("#body-${formContainerId}").charCounter(${forum.threadBodyLength}, {
                container: "#limiter-body-${formContainerId} span",
                format: "%1",
                pulse: false,
                delay: 100
              });
            // ]]>
          </script>
        </dd>
      </dl>
    </fieldset>

    <div class="buttons">
      <html:submit property="insertThreadSubmit" tabindex="3" styleClass="button">
        <fmt:message key="forum.widget.thread.form.submit.button.label" />
      </html:submit>

      <button tabindex="4" onclick="$('#${formContainerId}').slideUp('slow'); return false;">
        <fmt:message key="forum.widget.thread.form.cancel.button.label" />
      </button>
    </div>
  </html:form>
</div>