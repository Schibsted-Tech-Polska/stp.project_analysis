<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/view/helpers/emailPopupBox.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<c:set var="eaeLoggerUrl" value="${section.parameters['eae.logger.url']}"/>

<c:url var="imageUrl" value="${eaeLoggerUrl}">
  <c:param name="rt" value="1"/>
  <c:param name="ctxId" value="${article.homeSection.id}"/>
  <c:param name="pubId" value="${publication.id}"/>
  <c:param name="cat" value=""/>
  <c:param name="meta" value="emailed-${article.articleTypeName}"/>
  <c:param name="objId" value="${article.id}"/>
  <c:param name="type" value="article"/>
  <c:param name="title">
    <c:out value="${article.title}" escapeXml="true"/>
  </c:param>
  <c:param name="url" value="${article.url}"/>
</c:url>

<script type="text/javascript">
  $(document).ready(function() {
    /*This piece of code opens the email form in a popup style*/
    $("#openEmailBox").click(function(event) {
      $("#errorMessage").remove();
      $("#emailFormPageTools").jqpopup_open(this.id);
      event.preventDefault();
    });

    /*The reset button will not clear the error-messages so using this code to do that*/
    $("#emailArticleReset").click(function() {
      $("#errorMessage").remove();
      $("#emailDelivered").remove();
    });

    /*Sending the form through the JQuery Ajax Form plugin*/
    $("#mailForm").ajaxForm({beforeSubmit:validateFields, success:processSuccess});


  });

  /**
   * This method is called by Ajax Form Plugin before submitting the form for validation.
   * @param formData the form data as map
   * @param jqForm the original form
   * @param options the options array if provided.
   * @return true if form is validated or false otherwise
   *
   * */
  function validateFields(formData, jqForm, options) {

    var emailReg = /^([a-zA-Z0-9])+([\.a-zA-Z0-9_-])*@([a-zA-Z0-9])+(\.[a-zA-Z0-9_-]+)+$/;

    $("#errorMessage").remove();

    var emailForm = jqForm[0];
    var receiverEmail = emailForm.mailto.value;
    var firstName = emailForm.firstName.value;

    var emailErrorMessage = "<div id='errorMessage' style='color:red;float:right;margin-top:15px;margin-bottom:10px;'><span><fmt:message key='pageTools.widget.email.box.error.email' /></span></div>"
    if (!receiverEmail || !emailReg.test(receiverEmail)) {
      $("#mailto").before(emailErrorMessage);
      return false;
    }
    if (!firstName) {
      $("#firstName").before(emailErrorMessage);
      return false;
    }
    //todo: add seperate jsp for emial content:
    return true;
  }
  /**
   * This method is called by the Ajax Form Plugin after the response from the server comes back.
   * @param responseText the text which comes from the server.
   * @param statusText the status of the message returned by the server
   * */
  function processSuccess(responseText, statusText) {
    var emailSuccessMessage = "<span id='emailDelivered' style='margin-left: 15px; margin-top: 99px; color: green; font-size: 12px; font-weight: bold;'><fmt:message key='pageTools.widget.email.box.success.message' /></span>";
    $("#emailDelivered").remove();
    $("#emailArticleSend").after(emailSuccessMessage);
    var clientDT = new Date().getTime();
    var loggerImage = "<img style='display:none;' id='loggerEmailImage' src='${imageUrl}&amp;clientDT='" + clientDT + "' alt='' width='1' height='1' />";
    $("#emailArticleSend").after(loggerImage);
    $.jQpopup.close("emailFormPageTools");
  }
</script>


<div id="emailFormPageTools" style="left: 188.5px; top: 2797.57px; display: block;display:none" title="<fmt:message key='pageTools.widget.emial.box.title' />  ">

  <fmt:message var="mailtoToolTip" key="pageTools.widget.email.box.recipients.tooltip"/>
  <fmt:message var="sendText" key="pageTools.widget.email.box.send"/>
  <fmt:message var="sendToolTip" key="pageTools.widget.email.box.send.tooltip"/>
  <fmt:message var="resetText" key="pageTools.widget.email.box.reset"/>
  <fmt:message var="resetToolTip" key="pageTools.widget.email.box.reset.tooltip"/>

  <html:form action="/pageTools/sendMail" method="post" styleId="mailForm">
    <html:hidden property="method" value="sendSimpleMail" styleId="method"/>
    <html:hidden property="mailType" value="text_html" styleId="mailType"/>
    <c:choose>
      <c:when test="${requestScope['com.escenic.context']=='art'}">
        <c:set var="id" value="${article.id}"/>
        <c:set var="linkType" value="art"/>
      </c:when>
      <c:otherwise>
        <c:set var="id" value="${section.id}"/>
        <c:set var="linkType" value="sec"/>
      </c:otherwise>
    </c:choose>
    <html:hidden property="id" styleId="id" value="${id}"/>
    <html:hidden property="linkType" styleId="linkType" value="${linkType}"/>


    <div style="clear:none;padding: 0px;margin:0px;">

      <fieldset>
        <div>
          <span ><fmt:message key="pageTools.widget.email.box.firstname"/></span>
        </div>
        <html:text property="firstName" styleId="firstName" style="margin-bottom:10px;width:275px;" value=""/>
      </fieldset>


      <fieldset>
        <div>
          <span ><fmt:message key="pageTools.widget.email.box.surname"/></span>
        </div>
        <html:text property="surname"styleId="surname"  style="margin-bottom:10px;width:275px;" value=""/>
      </fieldset>

      <fieldset>
        <div>
          <span ><fmt:message key="pageTools.widget.email.box.recipients"/></span>
        </div>
        <html:text property="mailto" styleId="mailto" title="${mailtoToolTip}"  style="margin-bottom:10px;width:275px;" value=""/>
      </fieldset>

      <div class="inputrow">
        <input type="submit"
               id="emailArticleSend"
               style="width:auto;font:bold 10px Arial;text-transform:uppercase;color:#000000;float:right;margin-right: 10px"
               value="${sendText}"
               title="${sendToolTip}"/>
        <input type="reset"
               id="emailArticleReset"
               style="width:auto;font:bold 10px Arial;text-transform:uppercase;color:#000000;float:right;margin-right: 10px"
               value="${resetText}"
               title="${resetToolTip}"/>
      </div>
    </div>
  </html:form>
</div>