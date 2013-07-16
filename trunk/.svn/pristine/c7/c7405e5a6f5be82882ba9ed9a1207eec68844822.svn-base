<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/uploadProfilePicture.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the uploadProfilePicture view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<div class="${profileActions.wrapperStyleClass}" <c:if test="${not empty profileActions['styleId']}">id="${profileActions['styleId']}"</c:if>>

  <profile:present>
    <c:choose>
      <c:when test="${not empty param['profileActions'] and param['profileActions'] == 'success'}">
        <fmt:message key="profileActions.widget.uploadProfilePicture.success.message"/>
      </c:when>
      <c:otherwise>
        <h2><c:out value="${profileActions['headline']}" escapeXml="true"/></h2>

        <section:use uniqueName="${user.userName}">
          <c:set var="homeSectionId" value="${section.id}" scope="request"/>
        </section:use>

        <c:if test="${profileActions.showProfileLinks}">
          <jsp:include page="helpers/links.jsp"/>
        </c:if>

        <c:remove var="homeSectionId" scope="request"/>
        <section:use uniqueName="${user.userName}">
          <community:user id="currentUser" sectionId="${section.id}"/>
          <c:set target="${profileActions}" property="homeSectionId" value="${currentUser.section.id}"/>
        </section:use>

        <html:messages id="errorMeesage" message="true" property="error" bundle="Validation">
          <p class="error"><c:out value="${errorMeesage}" escapeXml="true"/></p>
        </html:messages>

        <html:xhtml/>
        <html:form enctype="multipart/form-data" action="${profileActions['action']}" method="post"
                   styleClass="profilePictureForm borderContainer">
          <fieldset>
            <html:hidden property="articleType" value="${profileActions['contentTypeName']}"/>
            <html:hidden property="state" value="${profileActions['state']}"/>
            <html:hidden property="homeSectionId" value="${profileActions['homeSectionId']}"/>
            <html:hidden property="image" value=""/>
            <html:hidden property="articleId"/>
            <html:hidden property="successUrl" value="${profileActions['successUrl']}"/>
            <html:hidden property="errorUrl" value="${profileActions['errorUrl']}"/>

            <html:hidden property="field(title)" value="${user.userName}"/>
            <html:hidden property="field(caption)"
                         value="${currentUser.article.fields['firstname']} ${currentUser.article.fields['surname']}"/>
            <html:hidden property="field(photographer)" value=""/>
            <html:hidden property="field(description)"
                         value="${currentUser.article.fields['firstname']} ${currentUser.article.fields['surname']}"/>

            <dl>
              <dt>
                <label for="picture">
                  <fmt:message key="profileActions.widget.uploadProfilePicture.selector.label"/>
                </label>
              </dt>
              <dd>
                <html:file property="file" styleId="picture" styleClass="fileUploader" tabindex="1" size="75"/>
                <p class="fileUploaderMessage">
                  <fmt:message key="profileActions.widget.uploadProfilePicture.selector.sizeLimitMessage"/>
                </p>
              </dd>
            </dl>
          </fieldset>

          <div class="bottom">
            <html:submit property="uploadPicture" styleClass="button" tabindex="2">
              <fmt:message key="profileActions.widget.uploadProfilePicture.submitButton.label"/>
            </html:submit>
          </div>
        </html:form>
      </c:otherwise>
    </c:choose>
  </profile:present>

  <profile:notPresent>
    <h2>
      <wf-community:getLoginUrl var="loginUrl" sectionUniqueName="login"/>
      <fmt:message key="profileActions.widget.uploadProfilePicture.login.request" />
      <a href="${loginUrl}"><fmt:message key="profileActions.widget.login.linkText"/></a>
    </h2>
  </profile:notPresent>
</div>

<c:remove var="profileActions" scope="request" />