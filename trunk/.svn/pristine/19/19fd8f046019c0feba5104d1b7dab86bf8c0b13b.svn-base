<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.HashMap" %>
<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/renderFormFields.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
 This tag returns the value of field determined by key
--%>

<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articleSummary" type="neo.xredsys.presentation.PresentationElement" required="false" rtexprvalue="true" %>
<%@ attribute name="articleContent" type="neo.xredsys.presentation.PresentationArticle" required="false" rtexprvalue="true" %>
<%@ attribute name="articleId" required="false" rtexprvalue="true" %>
<%@ attribute name="key" required="true" rtexprvalue="true" %>

<c:set var="returnValue" value=""/>

<c:choose>
  <c:when test="${key == 'title'}">

    <c:choose>
      <c:when test="${not empty articleSummary}">
        <c:choose>
          <c:when test="${not empty articleSummary.fields.caption.value}">
            <c:set var="title" value="${articleSummary.fields.caption.value}"/>
            <c:set var="inpageTitleClass" value="${articleSummary.fields.caption.options.inpageClasses}"/>
          </c:when>
          <c:when test="${not empty articleSummary.fields.title.value}">
            <c:set var="title" value="${articleSummary.fields.title.value}"/>
            <c:set var="inpageTitleClass" value="${articleSummary.fields.title.options.inpageClasses}"/>
          </c:when>
          <c:otherwise>
            <c:set var="title" value="${articleSummary.content.title}"/>
            <c:set var="inpageTitleClass" value=""/>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:when test="${not empty articleContent}">
        <c:choose>
          <c:when test="${not empty articleContent.fields.caption.value}">
            <c:set var="title" value="${articleContent.fields.caption.value}"/>
            <c:set var="inpageTitleClass" value="${articleContent.fields.caption.options.inpageClasses}"/>
          </c:when>
          <c:when test="${not empty articleContent.fields.title.value}">
            <c:set var="title" value="${articleContent.fields.title.value}"/>
            <c:set var="inpageTitleClass" value="${articleContent.fields.title.options.inpageClasses}"/>
          </c:when>
          <c:otherwise>
            <c:set var="title" value="${articleContent.title}"/>
            <c:set var="inpageTitleClass" value=""/>
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:when test="${not empty articleId}">
        <article:use articleId="${articleId}">
          <c:choose>
            <c:when test="${not empty article.fields.caption.value}">
              <c:set var="title" value="${article.fields.caption.value}"/>
              <c:set var="inpageTitleClass" value="${article.fields.caption.options.inpageClasses}"/>
            </c:when>
            <c:when test="${not empty article.fields.title.value}">
              <c:set var="title" value="${article.fields.title.value}"/>
              <c:set var="inpageTitleClass" value="${article.fields.title.options.inpageClasses}"/>
            </c:when>
            <c:otherwise>
              <c:set var="title" value="${article.title}"/>
              <c:set var="inpageTitleClass" value=""/>
            </c:otherwise>
          </c:choose>
        </article:use>
      </c:when>
    </c:choose>
    <c:set var="returnFieldValue" value="${title}"/>
    <c:set var="returnStyleClassValue" value="${inpageTitleClass}"/>
  </c:when>

  <c:when test="${key == 'leadtext'}">
    <c:choose>
      <c:when test="${not empty articleSummary}">
        <wf-core:isVideoArticle var="tempIsVideo" articleSummary="${articleSummary}" />
        <c:set var="isVideo" value="${requestScope.tempIsVideo}" />
        <c:remove var="tempIsVideo" scope="request" />
        <c:choose>
          <c:when test="${not empty articleSummary.fields.leadtext.value}">
            <c:set var="leadtext" value="${articleSummary.fields.leadtext.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleSummary.fields.leadtext.options.inpageClasses}"/>
          </c:when>
          <c:when test="${articleSummary.content.articleTypeName == 'picture'}">
            <c:set var="leadtext" value="${articleSummary.content.fields.description.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleSummary.content.fields.description.options.inpageClasses}"/>
          </c:when>
          <c:when test="${isVideo == 'true'}">
            <c:set var="leadtext" value="${articleSummary.content.fields.body.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleSummary.content.fields.body.options.inpageClasses}"/>
          </c:when>
          <c:when test="${articleSummary.content.articleTypeName == 'blogPost'}">
            <wf-core:stripHTML id="tempLeadtext" value="${articleSummary.content.fields.body.value}"/>
            <c:set var="leadtext" value="${requestScope.tempLeadtext}"/>
            <c:remove var="tempLeadtext" scope="request"/>
            <c:set var="inpageLeadtextClass" value=""/>
          </c:when>
        </c:choose>
      </c:when>
      <c:when test="${not empty articleContent}">
        <wf-core:isVideoArticle var="tempIsVideo" articleContent="${articleContent}"/>
        <c:set var="isVideo" value="${requestScope.tempIsVideo}"/>
        <c:remove var="tempIsVideo" scope="request"/>
        <c:choose>
          <c:when test="${not empty articleContent.fields.leadtext.value}">
            <c:set var="leadtext" value="${articleContent.fields.leadtext.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleContent.fields.leadtext.options.inpageClasses}"/>
          </c:when>
          <c:when test="${articleContent.articleTypeName == 'picture'}">
            <c:set var="leadtext" value="${articleContent.fields.description.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleContent.fields.description.options.inpageClasses}"/>
          </c:when>
          <c:when test="${isVideo == 'true'}">
            <c:set var="leadtext" value="${articleContent.fields.body.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleContent.fields.body.options.inpageClasses}"/>
          </c:when>
          <c:when test="${articleContent.articleTypeName == 'blogPost'}">
            <wf-core:stripHTML id="tempLeadtext" value="${articleContent.fields.body.value}"/>
            <c:set var="leadtext" value="${requestScope.tempLeadtext}"/>
            <c:remove var="tempLeadtext" scope="request"/>
            <c:set var="inpageLeadtextClass" value=""/>
          </c:when>
        </c:choose>
      </c:when>
      <c:when test="${not empty articleId}">
        <article:use articleId="${articleId}">
          <wf-core:isVideoArticle var="tempIsVideo" articleContent="${article}"/>
          <c:set var="isVideo" value="${requestScope.tempIsVideo}"/>
          <c:remove var="tempIsVideo" scope="request"/>
          <c:choose>
            <c:when test="${not empty article.fields.leadtext.value}">
              <c:set var="leadtext" value="${article.fields.leadtext.value}"/>
            </c:when>
            <c:when test="${article.articleTypeName == 'picture'}">
              <c:set var="leadtext" value="${article.fields.description.value}"/>
            </c:when>
            <c:when test="${isVideo == 'true'}">
              <c:set var="leadtext" value="${article.fields.body.value}"/>
            </c:when>
            <c:when test="${article.articleTypeName == 'blogPost'}">
              <wf-core:stripHTML id="tempLeadtext" value="${article.fields.body.value}"/>
              <c:set var="leadtext" value="${requestScope.tempLeadtext}"/>
              <c:remove var="tempLeadtext" scope="request"/>
              <c:set var="inpageLeadtextClass" value=""/>
            </c:when>
          </c:choose>
        </article:use>
      </c:when>
    </c:choose>

    <c:set var="returnFieldValue" value="${leadtext}"/>
    <c:set var="returnStyleClassValue" value="${inpageLeadtextClass}"/>
  </c:when>

</c:choose>

<%
  Map<String, Object> resultMap = new HashMap<String, Object>();
  resultMap.put("fieldValue", jspContext.getAttribute("returnFieldValue"));
  resultMap.put("inpageStyleClass", jspContext.getAttribute("returnStyleClassValue"));
  request.setAttribute(var, resultMap);
%>