<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/controller/searchResult.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This is the general controller of search widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a map that will contain relevant field values --%>
<jsp:useBean id="search" class="java.util.HashMap" scope="request"/>


<c:set var="resultPage" value="${requestScope['com.escenic.search.ResultPage']}"/>
<jsp:useBean id="resultPage" type="com.escenic.search.ResultPage" scope="page"/>

<c:if test="${not empty resultPage}">
  <c:set var="resultCount">
    <jsp:getProperty name="resultPage" property="totalHits" />
  </c:set>

  <c:set var="pageLength">
    <jsp:getProperty name="resultPage" property="pageLength" />
  </c:set>

  <c:set var="currentPageNumber">
    <jsp:getProperty name="resultPage" property="pageNumber"/>
  </c:set>
</c:if>

<c:set var="searchString" value="${param.searchString}" />

<c:set target="${search}" property="resultPage" value="${resultPage}"/>
<c:set target="${search}" property="resultCount" value="${resultCount}"/>
<c:set target="${search}" property="pageLength" value="${pageLength}"/>
<c:set target="${search}" property="currentPageNumber" value="${currentPageNumber}"/>
<c:set target="${search}" property="searchString" value="${searchString}"/>

<c:set target="${search}" property="showLeadText" value="${fn:trim(widgetContent.fields.showLeadTextResult.value)}"/>
<c:set target="${search}" property="showImage" value="${fn:trim(widgetContent.fields.showImageResult.value)}"/>
<c:set target="${search}" property="showPublishedDate" value="${fn:trim(widgetContent.fields.showPublishedDateResult.value)}"/>
<c:set target="${search}" property="showLastModifiedDate" value="${fn:trim(widgetContent.fields.showLastModifiedDateResult.value)}"/>

<c:set var="imageVersionResult" value="${fn:trim(widgetContent.fields.imageVersionResult.value)}"/>
<c:if test="${empty imageVersionResult}">
  <c:set var="imageVersionResult" value="w80"/>
</c:if>
<c:set target="${search}" property="imageVersion" value="${imageVersionResult}"/>

<c:set var="dateFormatResult" value="${fn:trim(widgetContent.fields.dateFormatResult)}"/>
<c:if test="${empty dateFormatResult}">
  <c:set var="dateFormatResult" value="dd MM yyyy"/>
</c:if>
<c:set target="${search}" property="dateFormat" value="${dateFormatResult}"/>