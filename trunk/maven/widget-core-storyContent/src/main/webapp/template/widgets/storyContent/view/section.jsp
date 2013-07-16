<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/view/section.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
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
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- declare the map that contains necessary field values--%>
<jsp:useBean id="storyContent" type="java.util.Map" scope="request"/>

<%-- render the chosen fields--%>
<c:if test="${not empty storyContent.selectedFields}">
  <div class="${storyContent.wrapperStyleClass}" <c:if test="${not empty storyContent.styleId}">id="${storyContent.styleId}"</c:if>>
    <c:forEach var="currentField" items="${storyContent.selectedFields}">
      <c:choose>
        <c:when test="${currentField eq 'title'}">
          <c:if test="${not empty storyContent.title}">
            <h1 class="${storyContent.inpageTitleClass}"><c:out value="${storyContent.title}" escapeXml="false"/></h1>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'subtitle'}">
          <c:if test="${not empty storyContent.subtitle}">
            <h3 class="${storyContent.inpageSubtitleClass}"><c:out value="${storyContent.subtitle}" escapeXml="false"/></h3>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'byline'}">
          <p class="${currentField}">
            <c:out value="${storyContent.bylinePrefix}" />&nbsp;<span class="authorName"><c:out value="${storyContent.byline}" escapeXml="true"/></span>
          </p>
        </c:when>
        <c:when test="${currentField eq 'dateline'}">
          <p class="${currentField}">
            <span class="label"><fmt:message key="storyContent.widget.published.label"/></span> ${storyContent.publishedDate}
            <span class="label"><fmt:message key="storyContent.widget.updated.label"/></span> ${storyContent.lastModifiedDate}
          </p>
        </c:when>
        <c:when test="${currentField eq 'leadtext'}">
          <c:if test="${not empty storyContent.leadtext}">
            <h5 class="${storyContent.inpageLeadtextClass}"><c:out value="${storyContent.leadtext}" escapeXml="false"/></h5>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'quote'}">
          <c:if test="${not empty storyContent.quote}">
            <div class="${currentField}">
              <div><p class="${storyContent.inpageQuoteClass}"><c:out value="${storyContent.quote}" escapeXml="true"/></p></div>
            </div>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'body'}">
          <article:use article="${currentArticle}">
            <c:if test="${not empty fn:trim(article.fields.body.value)}">
              <div class="${currentField} ${article.fields.body.options.inpageClasses}">
                <jsp:include page="helpers/renderBody.jsp" />
              </div>
            </c:if>
          </article:use>
        </c:when>
      </c:choose>
    </c:forEach>
  </div>
</c:if>

<c:remove var="storyContent" scope="request"/>