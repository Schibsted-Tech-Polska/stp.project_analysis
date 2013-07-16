<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/captchaCommentForm.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  the purpose of this page is to render the HTML form for posting new comment in comments widget
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>

<%-- this JSP page expects the following objects in the request scope, if any of them is missing, then this page will not work --%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>

<%-- find out the parentId of the new comment --%>
<c:set var="parentId" value="${param.parentId}" />

<%-- if param.parentId is not empty, then it can be a child level comment, hence try to find out the parentPosting --%>
<c:if test="${not empty parentId and parentId > 0}">
  <forum:posting id="parentComment" postingId="${parentId}" />
</c:if>

<%-- if no parentPosting, then it can be a top level comment, hence find out the appropiate thread --%>
<c:if test="${empty pageScope.parentComment}">
  <article:hasRelation type="article" includeArticleTypes="posting">
    <relation:articles id="relatedThread" includeArticleTypes="posting">
      <forum:thread id="parentThread" threadId="${relatedThread.id}" />

      <c:if test="${parentThread.forum.id==comments.forumId}">
        <c:set var="parentId" value="${parentThread.id}"/>
      </c:if>
    </relation:articles>
  </article:hasRelation>
</c:if>

<%-- if we have neither appropiate thread nor parent posting, then it must be the first comment --%>
<c:if test="${empty parentId}">
  <c:set var="parentId" value="-1"/>
</c:if>


<c:set var="operation" value="${param.operation}" />
<c:if test="${empty operation}">
  <c:set var="operation" value="comment" />
</c:if>

<c:set var="commentAction" value="${operation=='complaint' ? '/forum/addCaptchaComplaint' : '/forum/addCaptchaComment'}"/>

<script type="text/javascript" src="${resourceUrl}js/formValidator.js"></script>

<c:set var="emailFieldErrorId" value="comment-form-email-error" />
<c:set var="titleFieldErrorId" value="comment-form-title-error" />
<c:set var="bodyFieldErrorId" value="comment-form-body-error" />
<c:set var="captchaFieldErrorId" value="comment-form-captcha-error" />

<fmt:message var="emailFieldErrorMessage" key="comment.form.input.email.error"/>
<fmt:message var="titleFieldErrorMessage" key="comment.form.input.title.error"/>
<fmt:message var="bodyFieldErrorMessage" key="comment.form.input.body.error"/>
<fmt:message var="captchaFieldErrorMessage" key="comment.form.input.captcha.error"/>

<div id="commentsForm">

  <div class="header">
    <h5><fmt:message key="${operation}.form.headline" /></h5>
  </div>

  <div class="content">
    <html:xhtml/>
    <html:form action="${commentAction}" method="post"
               onsubmit="return validateCommentForm(this, '${emailFieldErrorId}', '${emailFieldErrorMessage}', '${bodyFieldErrorId}', '${bodyFieldErrorMessage}', '${titleFieldErrorId}', '${titleFieldErrorMessage}', '${captchaFieldErrorId}', '${captchaFieldErrorMessage}');">
      <fieldset>
        <html:hidden property="com.escenic.context.path.initial" value="/" />
        <html:hidden property="forumId" value="${comments.forumId}" />

        <c:choose>
          <c:when test="${operation=='complaint'}">
            <c:url var="successUrl" value="${article.url}">
              <c:param name="pageNumber" value="${param.pageNumber}" />
              <c:param name="parentId" value="${parentId}" />
            </c:url>
          </c:when>
          <c:otherwise>
            <c:set var="successUrl" value="${article.url}" />
          </c:otherwise>
        </c:choose>

        <html:hidden property="targetUrl" value="${successUrl}" />
        <html:hidden property="errorUrl" value="${article.url}"/>
        <html:hidden property="parentId" value="${parentId}" />
        <html:hidden property="typeName" value="posting" />
        <html:hidden property="field(articleId)" value="${article.id}" />

        <c:if test="${parentId == -1}">
          <html:hidden property="relatedArticleId" value="${article.id}"/>
          <html:hidden property="threadTitle" value="${article.title}"/>
        </c:if>

        <table>
          <tr class="byline">
            <td class="label">
              <label for="comment-form-byline"><fmt:message key="comment.form.input.byline.label"/></label>
            </td>
            <td class="field">
              <html:text property="field(byline)" styleId="comment-form-byline" styleClass="text-field"
                         maxlength="100" value="${param['field(byline)']}"/>
            </td>
          </tr>

          <tr class="email">
            <td class="label">
              <label for="comment-form-email"><fmt:message key="comment.form.input.email.label"/></label>
            </td>
            <td class="field">
              <html:text property="email" styleId="comment-form-email" styleClass="text-field" maxlength="50" value="${param.email}"/>
              <span class="compulsory">*</span>

              <c:set var="emailErrorMessage"><html:errors property="email"/></c:set>
              <p id="${emailFieldErrorId}" class="error">${fn:trim(emailErrorMessage)}</p>
              <c:remove var="emailErrorMessage" scope="page"/>
            </td>
          </tr>

          <c:choose>
            <c:when test="${operation=='complaint' or comments.showTitle=='true'}">
              <tr class="title">
                <td class="label">
                  <label for="comment-form-title"><fmt:message key="comment.form.input.title.label" /></label>
                </td>

                <td class="field">
                  <c:set var="commentTitleValue" value=""/>

                  <c:choose>
                    <c:when test="${not empty param.title}">
                      <c:set var="commentTitleValue" value="${param.title}"/>
                    </c:when>
                    <c:otherwise>
                      <c:if test="${not empty pageScope.parentComment}">
                        <c:set var="parentCommentTitle" value="${parentComment.fields.title}"/>
                        <fmt:message var="commentTitlePrefix"
                                     key="${operation}.form.input.title.prefix"/>

                        <c:set var="commentTitleValue" value="${commentTitlePrefix} ${parentCommentTitle}"/>
                      </c:if>
                    </c:otherwise>
                  </c:choose>

                  <html:text property="title" value="${commentTitleValue}" maxlength="${comments.commentTitleLength}"
                             styleId="comment-form-title" styleClass="text-field" />
                  <span class="compulsory">*</span>

                  <div class="field-status">
                    <c:set var="titleErrorMessage"><html:errors property="title"/></c:set>
                    <div id="${titleFieldErrorId}" class="status-left error">${fn:trim(titleErrorMessage)}</div>
                    <c:remove var="titleErrorMessage" scope="page" />

                    <div id="comment-form-title-length" class="status-right limiter">
                      <span>${comments.commentTitleLength}</span> <fmt:message key="commnet.form.input.text.restriction.message"/>
                    </div>
                  </div>

                  <script type="text/javascript">
                    // <![CDATA[
                    $("#comment-form-title").charCounter(${comments.commentTitleLength}, {
                        container: "#comment-form-title-length span",
                        format: "%1",
                        pulse: false,
                        delay: 100
                      });
                    // ]]>
                  </script>
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <html:hidden property="title" value="${article.title}" />
            </c:otherwise>
          </c:choose>

          <tr class="body">
            <td class="label">
              <label for="comment-form-body"><fmt:message key="comment.form.input.body.label" /></label>
            </td>
            <td class="field">
              <html:textarea property="body" styleId="comment-form-body" value="${param.body}" />
              <span class="compulsory">*</span>

              <div class="field-status">
                <c:set var="bodyErrorMessage"><html:errors property="body"/></c:set>
                <div id="${bodyFieldErrorId}" class="status-left error">${fn:trim(bodyErrorMessage)}</div>
                <c:remove var="bodyErrorMessage" scope="page" />

                <div id="comment-form-body-length" class="status-right limiter">
                  <span>${comments.commentBodyLength}</span> <fmt:message key="commnet.form.input.text.restriction.message"/>
                </div>
              </div>

              <script type="text/javascript">
                // <![CDATA[
                $("#comment-form-body").charCounter(${comments.commentBodyLength}, {
                    container: "#comment-form-body-length span",
                    format: "%1",
                    pulse: false,
                    delay: 100
                  });
                // ]]>
              </script>
            </td>
          </tr>

          <tr class="captcha">
            <td class="label">
              <label for="comment-form-captcha"><fmt:message key="comment.form.input.captcha.label"/></label>
              <html:image page="/escenicCaptcha" alt="captcha" title="captcha" styleClass="captcha-image"/>
            </td>

            <td class="field">
              <input id="comment-form-captcha" class="text-field" type="text" value="" name="captcha"/>
              <span class="compulsory">*</span>

              <c:set var="captchaErrorMessage">${param.captchaErrorMessage}</c:set>
              <p id="${captchaFieldErrorId}" class="error">${fn:trim(captchaErrorMessage)}</p>
              <c:remove var="captchaErrorMessage" scope="page"/>
            </td>
          </tr>
        </table>

        <div class="comment-form-bottom">
          <div class="bottom-left">
            <c:if test="${comments.moderateComments}">
              <p><fmt:message key="comment.form.moderation.message" /></p>
            </c:if>

            <p><a class="terms" href="#commentsForm"><fmt:message key="comment.form.terms.linktext" /></a></p>
          </div>

          <div class="bottom-right">
            <fmt:message var="buttonLabel" key="comment.form.button.submit.label" />
            <html:submit styleClass="submit-button" value="${buttonLabel}" />
          </div>
        </div>
      </fieldset>

      <%-- the following code block is used as a hack to remove struts action errors from the sessionScope --%>
      <c:if test="${not empty sessionScope['org.apache.struts.action.ERROR']}">
        <c:remove var="org.apache.struts.action.ERROR" scope="session" />
      </c:if>

    </html:form>
  </div>
</div>

