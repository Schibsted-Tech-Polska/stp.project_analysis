<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/reportAbuseForm.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:set var="divId" value="${param.divId}" scope="request" />
<c:set var="forumId" value="${param.forumId}" scope="request" />
<c:set var="email" value="${param.email}" scope="request" />
<c:set var="parentId" value="${param.parentId}" scope="request" />
<c:set var="targetUrl" value="${param.targetUrl}" scope="request" />
<c:set var="errorUrl" value="${param.errorUrl}" scope="request" />
<c:set var="cancelUrl" value="${param.cancelUrl}" scope="request" />
<c:set var="title" value="${param.title}" scope="request" />
<c:set var="keepHidden" value="${param.keepHidden}" scope="request" />

<div id="${divId}" class="postingForm complaintForm" <c:if test="${keepHidden == 'true'}">style="display: none;"</c:if>>

  <c:set var="bodyFieldErrorId" value="complaint-body-error-${widgetContent.id}-${parentId}" />
  <fmt:message var="bodyFieldErrorMessage" key="forum.widget.complaint.form.input.body.empty"/>
  
  <html:xhtml/>
  <html:form action="/forum/addAuthenticatedComplaint" method="post"
             onsubmit="return validatePostingForm(this, '${bodyFieldErrorId}', '${bodyFieldErrorMessage}');">

    <html:hidden property="forumId" value="${forumId}"/>
    <html:hidden property="email" value="${email}"/>
    <html:hidden property="typeName" value="posting"/>
    <html:hidden property="parentId" value="${parentId}"/>
    <html:hidden property="targetUrl" value="${targetUrl}"/>
    <html:hidden property="errorUrl" value="${errorUrl}"/>
    <html:hidden property="cancelUrl" value="${cancelUrl}"/>

    <fmt:message var="complaintPrefix" key="complaint.form.input.title.prefix" />
    <html:hidden property="title" value="${complaintPrefix} ${title}" />

    <fieldset>
      <dl>
        <dt>
          <label for="forum-postings-report-body-${widgetContent.id}-${parentId}">
            <fmt:message key="forum.widget.postings.form.report.headline" />
          </label>
        </dt>
        <dd>
          <html:textarea property="body" tabindex="1" styleId="forum-postings-report-body-${widgetContent.id}-${parentId}" />

          <div class="field-status">
            <div id="${bodyFieldErrorId}" class="status-left error">&nbsp;</div>

            <div id="forum-postings-report-body-length-${widgetContent.id}-${parentId}" class="status-right limiter">
              <span><c:out value="${forum.maxBodyLength}"/></span> <fmt:message key="forum.widget.posting.form.input.text.restriction.message"/>
            </div>
          </div>

          <script type="text/javascript">
            // <![CDATA[
            $("#forum-postings-report-body-${widgetContent.id}-${parentId}").charCounter(${forum.maxBodyLength}, {
                container: "#forum-postings-report-body-length-${widgetContent.id}-${parentId} span",
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
      <html:submit property="insertComplaintSubmit" tabindex="2" styleClass="button">
        <fmt:message key="forum.widget.postings.form.report.submit.label" />
      </html:submit>
    </div>
  </html:form>
</div>

