<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getEditPictureLink.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--The purpose of this tag is to create an edit picture link --%>
<%@ tag language="java" body-content="empty" pageEncoding="UTF-8"%>
<%@ attribute name="linkText" required="false" rtexprvalue="true" %>
<%@ attribute name="articleId" required="false" rtexprvalue="true" %>
<%@ attribute name="article" required="false" rtexprvalue="true" %>
<%@ attribute name="styleId" required="false" rtexprvalue="true" %>
<%@ attribute name="styleClass" required="false" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="auth" uri="http://www.escenic.com/taglib/escenic-auth" %>

<profile:present>
  <c:set var="editPictureSectionUniqueName" value="savePicture" />

  <section:use uniqueName="${user.userName}">
    <c:set var="sectionId" value="${section.id}" />
    <community:user id="currentUser" sectionId="${section.id}"/>
    <c:set var="homeSectionId" value="${currentUser.section.id}"/>
    <c:set var="homeSectionUrl" value="${currentUser.section.url}"/>
  </section:use>

  <c:if test="${requestScope['com.escenic.context']=='art' and article.articleTypeName eq 'picture' }">
    <c:set var="artId" value="${article.id}"/>
  </c:if>
  <c:if test="${not empty article}">
    <c:set var="artId" value="${article.id}"/>
  </c:if>
  <c:if test="${not empty articleId}">
    <c:set var="artId" value="${articleId}"/>
  </c:if>

  <c:if test="${not empty artId}">
     <article:use articleId="${artId}">
        <c:if test="${ article.articleTypeName eq 'picture'}">
            <auth:hasRole role="SECTION OWNER" sectionId="${sectionId}" userId="${currentUser.id}">
            <section:use uniqueName="${editPictureSectionUniqueName}">
              <c:set var="editPictureSectionUrl" value="${section.url}"/>
            </section:use>
            <c:set var="formId" value="loadPictureForm${articleId}"/>
            <html:form styleId="${formId}" action="/community/loadPictureForm">
              <html:hidden property="articleId" value="${article.id}"/>
              <html:hidden property="homeSectionId" value="${homeSectionId}"/>
              <html:hidden property="successUrl" value="${editPictureSectionUrl}"/>
              <html:hidden property="errorUrl" value="${article.url}"/>
            </html:form>

            <c:choose>
              <c:when test="${not empty fn:trim(linkText)}">
                <c:set var="editPictureLinkText" value="${fn:trim(linkText)}" />
              </c:when>
              <c:otherwise>
                <c:set var="editPictureLinkText">
                  <fmt:message key="actionLinks.widget.editPicture.linkText"/>
                </c:set>
              </c:otherwise>
            </c:choose>
            <a href="#" <c:if test="${not empty fn:trim(styleId)}"> id='${fn:trim(styleId)}'</c:if>
                <c:if test="${not empty fn:trim(styleClass)}"> class='${fn:trim(styleClass)}'</c:if>
               onclick="$('#${formId}').submit(); return false;"><c:out value="${editPictureLinkText}" escapeXml="true"/></a>
          </auth:hasRole>
         </c:if>
      </article:use>
  </c:if>
</profile:present>