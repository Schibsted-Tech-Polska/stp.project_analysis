<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/searchResult.jsp#1 $
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
  The purpose of this page is to display the search results page by page
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="search" class="java.util.HashMap" scope="request"/>

<div class="${search.wrapperStyleClass}" <c:if test="${not empty search.styleId}">id="${search.styleId}"</c:if> >

<div id="search-result" >
    <c:choose>

      <c:when test="${not empty search.resultPage}">
        <c:set var="resultCount" value="${search.resultCount + 0 }"/>
        <c:set var="pageLength" value="${search.pageLength + 0}"/>
        <c:set var="currentPageNumber" value="${search.currentPageNumber + 0}"/>
        <c:set var="searchString" value="${search.searchString}"/>

        <div class="heading">
          <div class="heading-left">
            <p>
              <fmt:message key="search.widget.results.label">
                <fmt:param value="${(currentPageNumber-1) * pageLength + 1}"/>
                <fmt:param value="${resultCount < currentPageNumber * pageLength ? resultCount : currentPageNumber * pageLength}"/>
                <fmt:param value="${resultCount}"/>
              </fmt:message>

              <c:if test="${not empty searchString}">
                &nbsp;<fmt:message key="search.widget.for"/>&nbsp;<strong><c:out value="${searchString}"/></strong>
              </c:if>
            </p>
          </div>

          <div class="heading-right">
            <p>
              <a href="#" onclick="$('#advanced-search').toggle('normal');">
                <fmt:message key="search.widget.form.advanced.linktext"/>
              </a>
            </p>
          </div>

        </div>

        <%-- display pagination at top --%>
        <jsp:include page="helpers/pagination.jsp" />

        <%-- display search result items for this page --%>
        <c:forEach var="resultItem" items="${search.resultPage}" varStatus="status">
          <c:set var="searchItemId" value="${resultItem.documentId}" scope="request" />
          <c:set var="firstItemStyleClass" value="${status.first ? 'first' : ''}" scope="request"/>
          <jsp:include page="helpers/searchItem.jsp" />
          <c:remove var="searchItemId" scope="request" />
          <c:remove var="firstItemStyleClass" scope="request" />
        </c:forEach>

        <%-- display pagination at bottom --%>
        <jsp:include page="helpers/pagination.jsp" />
      </c:when>

      <c:otherwise>
        <div class="heading emmpty-result">
          <div class="heading-left">
            <h3>
              <fmt:message key="search.widget.results.yourSearch.text"/>
              <c:if test="${not empty searchString}">
                <fmt:message key="search.widget.for"/> <strong>${searchString}</strong> -
              </c:if>
              <fmt:message key="search.widget.results.didNotMatch.text"/>
            </h3>

            <h5><fmt:message key="search.widget.results.suggestions.text"/></h5>

            <ul>
              <li><fmt:message key="search.widget.results.suggestions.first.text"/></li>
              <li><fmt:message key="search.widget.results.suggestions.second.text"/></li>
              <li><fmt:message key="search.widget.results.suggestions.third.text"/></li>
            </ul>
          </div>

          <div class="heading-right">
            <p><a href="#" onclick="$('#advanced-search').toggle('normal');"><fmt:message key="search.widget.form.advanced.linktext"/></a></p>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>
