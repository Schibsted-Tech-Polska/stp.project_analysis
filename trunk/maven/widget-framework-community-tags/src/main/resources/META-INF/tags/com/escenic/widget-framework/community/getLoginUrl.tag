<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getLoginUrl.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="sectionUniqueName" required="false" %>
<%--
  Returns: the login url with redirectionUrl as a parameter.
  Attribute:
    loginSectionUniqueName: section unique name of the loginSection, optional, default value: login
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<c:set var="registrationSectionUniqueName" value="registration" />
<c:set var="resetPasswordSectionUniqueName" value="resetPassword" />

<c:choose>
  <c:when test="${not empty fn:trim(sectionUniqueName)}">
    <c:set var="loginSectionUniqueName" value="${fn:trim(sectionUniqueName)}" />
  </c:when>
  <c:otherwise>
    <c:set var="loginSectionUniqueName" value="login" />    
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${section.uniqueName == registrationSectionUniqueName or
                  section.uniqueName == resetPasswordSectionUniqueName}">
    <c:set var="redirectionUrl" value="${publication.url}" />
  </c:when>
  <c:otherwise>
    <c:set var="redirectionUrl" value="${requestScope['com.escenic.context']=='art' ? article.url : section.url}" />
    
    <c:if test="${not empty param}">
      <c:url var="redirectionUrl" value="${redirectionUrl}">
        <c:forEach var="p" items="${param}">
          <c:param name="${p.key}" value="${p.value}" />
        </c:forEach>
      </c:url>
    </c:if>
  </c:otherwise>
</c:choose>

<section:use uniqueName="${loginSectionUniqueName}">
  <c:url var="loginUrl" value="${section.url}">
    <c:param name="redirectionUrl" value="${redirectionUrl}" />
  </c:url>
</section:use>

<%
  request.setAttribute(var, jspContext.getAttribute("loginUrl"));
%>