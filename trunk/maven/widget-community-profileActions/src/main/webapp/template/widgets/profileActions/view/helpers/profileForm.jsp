<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/helpers/profileForm.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render profile form for registration/editProfile view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="template"  uri="http://www.escenic.com/taglib/escenic-template"%>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util"%>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section"%>
<%@ taglib prefix="articleextra" uri="http://www.escenic.com/taglib/escenic-articleextra" %>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- the controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>
<jsp:useBean id="homeSectionId" type="java.lang.Integer" scope="request"/>

<logic:messagesPresent message="true" property="error">
  <p class="error"><fmt:message key="errors.generic"/></p>
</logic:messagesPresent>

<c:set var="state" value="published"/>

<articleextra:articleType id="articleType" typeName="${profileActions.articleTypeName}"/>

<html:xhtml/>
<html:form styleClass="${profileActions.view}" action="${profileActions.action}" method="post" onsubmit="setFullName(this);return true;">

    <div>
        <html:hidden property="articleType" value="${profileActions.articleTypeName}"/>
        <html:hidden property="homeSectionId" value="${homeSectionId}"/>
        <html:hidden property="state" value="${state}"/>
        <html:hidden property="image" value=""/>
        <html:hidden property="articleId"/>
        <html:hidden property="successUrl" value="${profileActions.successUrl}"/>
        <html:hidden property="errorUrl" value="${profileActions.errorUrl}"/>
    </div>
  <wf-community:renderFormFields articleType="${articleType}" panelNames="${profileActions.panelNames}"
                              excludeFields="${profileActions.excludeFields}"/>

  <c:if test="${profileActions.showCaptcha}">
    <fieldset class="CAPTCHA">
      <dl>
        <dt>
          <label for="captcha">
            <fmt:message key="profileActions.widget.registration.captcha.label"/>
          </label>
        </dt>
        <dd>
          <input type="text" name="jcaptcha_response" class="text-field" id="captcha"/>
          <span class='compulsory'>*</span>
          <html:messages id="errorMeesage" message="true" property="CAPTCHA" bundle="Validation">
            <p class="error" id="errorfield(CAPTCHA)"><c:out value="${errorMeesage}" escapeXml="true"/></p>
          </html:messages>

          <p class="captchaImage">
            <html:image src='${pageContext.request.contextPath}/community/jCaptcha.do' style="cursor:default;" onclick="return false;"/>
          </p>
        </dd>
      </dl>
    </fieldset>
  </c:if>

  <fieldset class="fieldsubmit">
    <dl>
      <dt>&nbsp;</dt>
      <dd>
        <html:submit styleClass="button" property="saveProfile">
          <fmt:message key="profileActions.widget.editProfile.submitButton.label" />
        </html:submit>

        <html:cancel styleClass="button" onclick="window.location='${publication.url}';return false;">
          <fmt:message key="profileActions.widget.editProfile.cancelButton.label" />          
        </html:cancel>
      </dd>
    </dl>
  </fieldset>  
</html:form>

<script type="text/javascript">
  <![CDATA[   
      function setFullName(form) {
        if (form['field(FULLNAME)'] != null && form['field(FIRSTNAME)'] != null && form['field(SURNAME)'] != null) {
          form['field(FULLNAME)'].value = form['field(SURNAME)'].value + ' ' + form['field(FIRSTNAME)'].value;
        }
      }
   ]]>
</script>