<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsPagination.jsp#1 $
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
  The purpose of this page is to display the pagination for the comments of an article
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="paginationStyleClass" type="java.lang.String" scope="request"/>

<c:if test="${comments.numberOfTopLevelComments > 0}">
  <div class="pagination ${paginationStyleClass}">

      <%-- display pagination only if the number of pages > 1--%>
    <c:if test="${comments.numberOfPages > 1}">
      <div class="pagination-left">
        <c:if test="${comments.currentPageNumber > 1}">
          <span class="page-number first-page">
            <c:set var="pageNumber" value="1" scope="request"/>
            <c:set var="pageLinkText" scope="request">
              <strong>«</strong>
              <fmt:message key="comments.pagination.first.page.linktext"/>
            </c:set>
            <jsp:include page="commentsPageLink.jsp" />
            <c:remove var="pageNumber" scope="request" />
            <c:remove var="pageLinkText" scope="request" />
          </span>

          <span class="page-number previous-page">
            <c:set var="pageNumber" value="${fn:trim(comments.currentPageNumber-1)}" scope="request"/>
            <c:set var="pageLinkText" scope="request">
              <strong>‹</strong>
              <fmt:message key="comments.pagination.previous.page.linktext"/>
            </c:set>
            <jsp:include page="commentsPageLink.jsp" />
            <c:remove var="pageNumber" scope="request" />
            <c:remove var="pageLinkText" scope="request" />
          </span>
        </c:if>

          <%-- call commentsPaginationRange.jsp and get beginPageNumber and endPageNumber for the pagination from the requestScope --%>
        <jsp:include page="commentsPaginationRange.jsp" />        
        <c:set var="beginPageNumber" value="${requestScope.beginPageNumber}" />
        <c:set var="endPageNumber" value="${requestScope.endPageNumber}" />

        <c:forEach var="pageNumber" begin="${beginPageNumber}" end="${endPageNumber}" step="1">
          <c:choose>
            <c:when test="${pageNumber == comments.currentPageNumber}">
              <span class="page-number current-page">${pageNumber}</span>
            </c:when>
            <c:otherwise>
              <span class="page-number">
                <c:set var="pageNumber" value="${fn:trim(pageNumber)}" scope="request"/>
                <c:set var="pageLinkText" value="${fn:trim(pageNumber)}" scope="request" />
                <jsp:include page="commentsPageLink.jsp" />
                <c:remove var="pageNumber" scope="request" />
                <c:remove var="pageLinkText" scope="request" />
              </span>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${comments.currentPageNumber < comments.numberOfPages}">
          <span class="page-number next-page">
            <c:set var="pageNumber" value="${fn:trim(comments.currentPageNumber+1)}" scope="request"/>
            <c:set var="pageLinkText" scope="request">
              <fmt:message key="comments.pagination.next.page.linktext"/>
              <strong>›</strong>
            </c:set>
            <jsp:include page="commentsPageLink.jsp" />
            <c:remove var="pageNumber" scope="request" />
            <c:remove var="pageLinkText" scope="request" />
          </span>

          <span class="page-number last-page">
            <c:set var="pageNumber" value="${fn:trim(comments.numberOfPages)}" scope="request"/>
            <c:set var="pageLinkText" scope="request">
              <fmt:message key="comments.pagination.last.page.linktext"/>
              <strong>»</strong>
            </c:set>
            <jsp:include page="commentsPageLink.jsp" />
            <c:remove var="pageNumber" scope="request" />
            <c:remove var="pageLinkText" scope="request" />
          </span>
        </c:if>
      </div>
    </c:if>

    <div class="pagination-right">
      <fmt:message key="comments.pagination.right.text">
        <fmt:param value="${comments.currentPageNumber}" />
        <fmt:param value="${comments.numberOfPages}" />
      </fmt:message>
    </div>
  </div>
</c:if>