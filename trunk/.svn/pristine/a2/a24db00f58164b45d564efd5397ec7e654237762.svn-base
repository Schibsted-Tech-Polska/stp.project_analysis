<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/view/saveBlogPost.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the changePassword view of the contentActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section"%>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- the general controller has already set a HashMap named 'contentActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<div class="${contentActions.wrapperStyleClass}" <c:if test="${not empty contentActions.styleId}">id="${contentActions.styleId}"</c:if>>
  <div class="header">
    <h5><c:out value="${fn:trim(contentActions.headline)}" escapeXml="true"/></h5>
  </div>

  <div class="content">
    <profile:present>
      <section:use uniqueName="${user.userName}">
        <community:user id="currentUser" sectionId="${section.id}"/>
        <c:set target="${contentActions}" property="homeSectionId" value="${currentUser.section.id}" />
      </section:use>

      <html:messages id="errorMeesage" message="true" property="error" bundle="Validation">
        <p class="error"><c:out value="${errorMeesage}" escapeXml="true"/></p>
      </html:messages>

      <html:xhtml/>
      <html:form action="${contentActions.action}"  method="post">
        <html:hidden property="articleType" value="${contentActions.contentTypeName}"/>
        <html:hidden property="homeSectionId" value="${contentActions.homeSectionId}"/>
        <html:hidden property="state" value="${contentActions.state}"/>
        <html:hidden property="image" value=""/>
        <html:hidden property="articleId"/>
        <html:hidden property="errorUrl" value="${contentActions.errorUrl}" />

        <%-- the following custom tag will render all the input fields defined in the given panelName of the contentType --%>
        <wf-community:renderFormFields articleType="${contentActions.contentType}" panelNames="${contentActions.panelNames}"/>

        <div class="bottom">
          <html:submit property="saveStory" styleClass="button">
            <fmt:message key="contentActions.widget.saveBlogPost.submitButton.label" />
          </html:submit>          
        </div>
      </html:form>
    </profile:present>

    <profile:notPresent>
      <h2>
        <wf-community:getLoginUrl var="loginUrl" sectionUniqueName="login"/>
        <fmt:message key="contentActions.widget.saveBlogPost.login.request"/>
        <a href="${loginUrl}"><fmt:message key="contentActions.widget.login.label"/></a>
      </h2>
    </profile:notPresent>
  </div>
</div>


<c:remove var="contentActions" scope="request"/>