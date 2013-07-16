<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/helpers/pagination.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  The purpose of this page is to display the pagination for search results
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<c:set var="resultPage" value="${requestScope['com.escenic.search.ResultPage']}"/>
<jsp:useBean id="resultPage" type="com.escenic.search.ResultPage" scope="page"/>

<c:set var="resultCount">
  <jsp:getProperty name="resultPage" property="totalHits"/>
</c:set>

<c:set var="currentPageNumber">
  <jsp:getProperty name="resultPage" property="pageNumber"/>
</c:set>

<c:set var="numberOfPages">
  <jsp:getProperty name="resultPage" property="numberOfPages"/>
</c:set>

<c:set var="numberOfPageLinks" value="5"/>


<div class="pagination">
  <%-- display pagination only if the number of pages > 1--%>
  <c:if test="${numberOfPages > 1}">
    <div class="pagination-left">
      <c:if test="${currentPageNumber > 1}">
        <span class="page-number first-page">
          <c:set var="pageNumber" value="1" scope="request"/>
          <c:set var="pageLinkText" scope="request">
            <strong>«</strong>
            <fmt:message key="search.widget.results.pagination.first.text"/>
          </c:set>
          <jsp:include page="pageLink.jsp"/>
          <c:remove var="pageNumber" scope="request"/>
          <c:remove var="pageLinkText" scope="request"/>
        </span>

        <span class="page-number previous-page">
          <c:set var="pageNumber" value="${currentPageNumber-1}" scope="request"/>
          <c:set var="pageLinkText" scope="request">
            <strong>‹</strong>
            <fmt:message key="search.widget.results.pagination.previous.text"/>
          </c:set>
          <jsp:include page="pageLink.jsp"/>
          <c:remove var="pageNumber" scope="request"/>
          <c:remove var="pageLinkText" scope="request"/>
        </span>
      </c:if>

      <%-- call wf-core:getPaginationRange tag and get beginPageNumber and endPageNumber for the pagination from the requestScope --%>
      <wf-core:getPaginationRange numberOfPages="${numberOfPages}"
                                    currentPageNumber="${currentPageNumber}"
                                    numberOfPageLinks="${numberOfPageLinks}" />
      <c:set var="beginPageNumber" value="${requestScope.beginPageNumber}"/>
      <c:set var="endPageNumber" value="${requestScope.endPageNumber}"/>

      <c:forEach var="pageNumber" begin="${beginPageNumber}" end="${endPageNumber}" step="1">
        <c:choose>
          <c:when test="${pageNumber == currentPageNumber}">
            <span class="page-number current-page">${pageNumber}</span>
          </c:when>
          <c:otherwise>
            <span class="page-number">
              <c:set var="pageNumber" value="${pageNumber}" scope="request"/>
              <c:set var="pageLinkText" value="${pageNumber}" scope="request" />
              <jsp:include page="pageLink.jsp"/>
              <c:remove var="pageNumber" scope="request"/>
              <c:remove var="pageLinkText" scope="request"/>
            </span>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <c:if test="${currentPageNumber < numberOfPages}">
        <span class="page-number next-page">
          <c:set var="pageNumber" value="${currentPageNumber+1}" scope="request"/>
          <c:set var="pageLinkText" scope="request">
            <fmt:message key="search.widget.results.pagination.next.text"/>
            <strong>›</strong>
          </c:set>
          <jsp:include page="pageLink.jsp"/>
          <c:remove var="pageNumber" scope="request"/>
          <c:remove var="pageLinkText" scope="request"/>
        </span>

        <span class="page-number last-page">
          <c:set var="pageNumber" value="${numberOfPages}" scope="request"/>
          <c:set var="pageLinkText" scope="request">
            <fmt:message key="search.widget.results.pagination.last.text"/>
            <strong>»</strong>            
          </c:set>
          <jsp:include page="pageLink.jsp"/>
          <c:remove var="pageNumber" scope="request"/>
          <c:remove var="pageLinkText" scope="request"/>
        </span>
      </c:if>
    </div>
  </c:if>

  <div class="pagination-right">
    <fmt:message key="search.widget.results.pagination.page.text"/> <strong><c:out value="${currentPageNumber}" escapeXml="true"/></strong> <fmt:message key="search.widget.of"/> <strong><c:out value="${numberOfPages}" escapeXml="false"/></strong>
  </div>
</div>
