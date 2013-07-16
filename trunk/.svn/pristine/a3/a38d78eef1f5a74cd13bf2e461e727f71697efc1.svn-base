<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/view/helpers/articleList.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>
<jsp:useBean id="articleAttributeMap" type="java.util.Map" scope="request"/>

<!-- render the first article -->
<c:choose>
  <c:when test="${trailers.view eq 'column'}">
    <jsp:include page="articleInColumnView.jsp"/>
  </c:when>
  <c:when test="${trailers.view eq 'newsletter'}">
    <jsp:include page="articleInNewsletterView.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="articleInRowView.jsp"/>
  </c:otherwise>
</c:choose>


<!-- render other articles, if necessary, in column view -->
<c:if test="${trailers.view eq 'column' and trailers.maxItems > 1}">
  <c:set var="fetchedArticleMapList" value="${articleAttributeMap.fetchedArticleMapList}"/>

  <c:forEach var="articleMap" items="${fetchedArticleMapList}" varStatus="loopStatus">
    <c:set var="articleAttributeMap" value="${articleMap}" scope="request"/>
    <jsp:include page="articleInColumnView.jsp"/>
    <c:remove var="articleAttributeMap" scope="request"/>
  </c:forEach>
</c:if>