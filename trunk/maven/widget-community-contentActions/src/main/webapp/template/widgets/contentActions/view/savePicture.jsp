<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/view/savePicture.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<div class="${contentActions.wrapperStyleClass}" <c:if test="${not empty contentActions.styleId}">id="${contentActions.styleId}"</c:if>>
  <div class="header">
    <h5><c:out value="${fn:trim(contentActions['headline'])}"/></h5>
  </div>

  <div class="content">
    <profile:present>
      <section:use uniqueName="${user.userName}">
        <community:user id="currentUser" sectionId="${section.id}"/>
        <c:set target="${contentActions}" property="homeSectionId" value="${currentUser.section.id}" />
      </section:use>

      <html:messages id="errorMeesage" message="true" property="error" bundle="Validation">
        <p class="error"><c:out value="${errorMeesage}"/></p>
      </html:messages>

      <html:xhtml/>
      <html:form enctype="multipart/form-data" action="${contentActions.action}" method="post">
        <fieldset>
          <html:hidden property="articleType" value="${contentActions.contentTypeName}"/>
          <html:hidden property="state" value="${contentActions.state}"/>
          <html:hidden property="homeSectionId" value="${contentActions.homeSectionId}"/>
          <html:hidden property="image" value=""/>
          <html:hidden property="articleId"/>
          <html:hidden property="errorUrl" value="${contentActions.errorUrl}"/>
          <html:hidden property="successUrl" value="${contentActions.successUrl}"/>

          <c:choose>
            <c:when test="${empty requestScope.articleObject}">
              <dl>
                <dt>
                  <label for="picture">
                    <fmt:message key="contentActions.widget.savePicture.selector.label"/>
                  </label>
                </dt>
                <dd>
                  <input type="text" name="filePath" class="filePath" value=""/>
                  <input type="button" value="Browse" class="fileBrowser"/>
                  <html:file property="file" styleId="picture" styleClass="fileUploader" tabindex="1"/>
                </dd>
              </dl>
            </c:when>
            <c:otherwise>
              <article:use articleId="${requestScope.articleObject.id}">
                <c:set var="imageVersion" value="${contentActions.imageVersion}"/>
                <div align="center" class="editImage">
                  <img src="${article.fields.alternates.value[imageVersion].href}"
                     width="${article.fields.alternates.value[imageVersion].width}"
                     height="${article.fields.alternates.value[imageVersion].height}"
                     alt="${article.fields.alttext.value}"
                     align="top"/>
                </div>
              </article:use>
            </c:otherwise>
          </c:choose>

          <dl>
            <dt>
              <label for="pictureTitle">Title</label>
            </dt>
            <dd>
              <html:text property="field(title)" styleId="pictureTitle" styleClass="text-field" tabindex="2"/>
            </dd>
          </dl>

          <dl>
            <dt>
              <label for="pictureCaption">
                <fmt:message key="contentActions.widget.savePicture.caption.label" />
              </label>
            </dt>
            <dd>
              <html:text property="field(caption)" styleId="pictureCaption" styleClass="text-field" tabindex="2"/>
            </dd>
          </dl>

          <dl>
            <dt>
              <label for="pictureCredits">Credits</label>
            </dt>
            <dd>
              <html:text property="field(photographer)" styleId="pictureCredits" styleClass="text-field" tabindex="2"/>
            </dd>
          </dl>

          <dl>
            <dt>
              <label for="pictureDescription">Description</label>
            </dt>
            <dd>
              <html:text property="field(description)" styleId="pictureDescription" styleClass="text-field" tabindex="2"/>
            </dd>
          </dl>
        </fieldset>

        <div class="bottom">
          <html:submit property="uploadPicture" styleClass="button" tabindex="3">
            <fmt:message key="contentActions.widget.savePicture.submitButton.label" />
          </html:submit>
        </div>
      </html:form>
    </profile:present>

    <profile:notPresent>
      <h2>
        <wf-community:getLoginUrl var="loginUrl" sectionUniqueName="login"/>
        <fmt:message key="contentActions.widget.savePicture.login.request" />
        <a href="${loginUrl}"><fmt:message key="contentActions.widget.login.label"/></a>
      </h2>
    </profile:notPresent>
  </div>
</div>

<script type="text/javascript">
  //<![CDATA[
  $(document).ready(function() {
    $("#picture").change(function() {
      var fileName = this.value;
      this.form.filePath.value = fileName;            
      var slashIndex1 = fileName.lastIndexOf("/");
      var slashIndex2 = fileName.lastIndexOf("\\");
      if(slashIndex1!=-1) {
        fileName = fileName.substr(slashIndex1+1);
      }
      else if(slashIndex2!=-1) {
        fileName = fileName.substr(slashIndex2+1);
      }
      this.form.pictureTitle.value = fileName;
    });
  });
  //]]>
</script>

<c:remove var="contentActions" scope="request" />