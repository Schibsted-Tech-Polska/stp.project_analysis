<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/simpleForm.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- The purpose of this page is to display a siample search box. --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>


<%-- the controller has already set a HashMap named 'search' in the requestScope --%>
<jsp:useBean id="search" type="java.util.HashMap" scope="request"/>

<div class="${search.wrapperStyleClass}" <c:if test="${not empty search.styleId}">id="${search.styleId}"</c:if> >

  <div class="simpleSearch">
    <html:xhtml/>

    <html:form action="/search/simple" method="get">
      <fieldset>
        <html:hidden property="successUrl" value="${search.successUrl}"/>
        <html:hidden property="errorUrl" value="${search.errorUrl}" />
        <html:hidden property="publicationId" value="${search.publicationId}" />
        <html:hidden property="sortString" value="${search.sortString}"/>
        <html:hidden property="includeSectionId" value="${search.includeSectionId}"/>
        <html:hidden property="includeSubSections" value="${search.includeSubSections}" />

        <c:forTokens var="articleType" items="${search.articleTypes}" delims=",">
          <html:hidden property="articleType" value="${fn:trim(articleType)}"/>
        </c:forTokens>

        <html:hidden property="pageLength" value="${search.pageLength}"/>
        <html:hidden property="searchEngineName" value="${search.searchEngineName}"/>

        <html:text styleClass="field" property="searchString" value="${search.searchString}" />

        <c:set var="searchButtonLabel">
          <fmt:message key="search.widget.form.submit.button.label"/>
        </c:set>

        <c:set var="searchButtonTitle">
          <fmt:message key="search.widget.form.submit.button.title"/>
        </c:set>

        <html:submit styleClass="button" title="${searchButtonTitle}">
          <c:out value="${searchButtonLabel}" escapeXml="true"/>
        </html:submit>
      </fieldset>
    </html:form>
  </div>

</div>

<c:remove var="search" scope="request" />

