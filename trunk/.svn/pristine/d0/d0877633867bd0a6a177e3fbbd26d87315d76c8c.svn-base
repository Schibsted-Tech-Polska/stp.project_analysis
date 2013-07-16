<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStoryContent/src/main/webapp/template/widgets/mobileStoryContent/view/section.jsp#3 $
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

<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>

<%-- declare the map that contains necessary field values--%>
<jsp:useBean id="mobileStoryContent" type="java.util.Map" scope="request"/>

<%-- render the chosen fields--%>
<c:if test="${not empty mobileStoryContent.selectedFields}">
  <dxf:div cssClass="${mobileStoryContent.wrapperStyleClass}" id="${mobileStoryContent.styleId}">
    <c:forEach var="currentField" items="${mobileStoryContent.selectedFields}">
      <c:choose>
        <c:when test="${currentField eq 'title'}">
          <c:if test="${not empty mobileStoryContent.title}">
            <dxf:h1><c:out value="${mobileStoryContent.title}" escapeXml="false"/></dxf:h1>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'subtitle'}">
          <c:if test="${not empty mobileStoryContent.subtitle}">
            <dxf:h3><c:out value="${mobileStoryContent.subtitle}" escapeXml="false"/></dxf:h3>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'byline'}">
          <dxf:p cssClass="${currentField}">
            <c:out value="${mobileStoryContent.bylinePrefix}" escapeXml="true" />&nbsp;<dxf:span cssClass="authorName"><c:out value="${mobileStoryContent.byline}" escapeXml="false"/></dxf:span>
          </dxf:p>
        </c:when>
        <c:when test="${currentField eq 'dateline'}">
          <dxf:p cssClass="${currentField}">
            <dxf:span cssClass="label"><fmt:message key="mobileStoryContent.widget.published.label"/></dxf:span> <c:out value="${mobileStoryContent.publishedDate}" escapeXml="true"/>
            <dxf:span cssClass="label"><fmt:message key="mobileStoryContent.widget.updated.label"/></dxf:span> <c:out value="${mobileStoryContent.lastModifiedDate}" escapeXml="true"/>
          </dxf:p>
        </c:when>
        <c:when test="${currentField eq 'leadtext'}">
          <c:if test="${not empty mobileStoryContent.leadtext}">
            <dxf:h5><c:out value="${mobileStoryContent.leadtext}" escapeXml="false"/></dxf:h5>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'quote'}">
          <c:if test="${not empty mobileStoryContent.quote}">
            <dxf:div cssClass="${currentField}">
              <dxf:div><dxf:p><c:out value="${mobileStoryContent.quote}" escapeXml="true" /></dxf:p></dxf:div>
            </dxf:div>
          </c:if>
        </c:when>
        <c:when test="${currentField eq 'body'}">
          <article:use article="${currentArticle}">
            <c:if test="${not empty fn:trim(article.fields.body.value)}">
              <dxf:div cssClass="${currentField}">
                <jsp:include page="helpers/renderBody.jsp" />
              </dxf:div>
            </c:if>
          </article:use>
        </c:when>
        <c:when test="${currentField eq 'map'}">
          <c:if test="${not empty mobileStoryContent.geocode}">
            <jsp:include page="helpers/geomap.jsp"/>            
          </c:if>
        </c:when>
      </c:choose>
    </c:forEach>
  </dxf:div>
</c:if>

<c:remove var="mobileStoryContent" scope="request"/>
