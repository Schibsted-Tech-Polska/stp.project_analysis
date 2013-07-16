<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/helpers/pageLink.jsp#2 $
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
  The purpose of this page is to display link of a search page
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>

<%--
  this JSP page expects two objects in the request scope 'pageNumber' and 'pageLinkText'
  if any of them is missing, then this page will not work
--%>
<c:set var="pageNumber" value="${requestScope.pageNumber}" />
<c:set var="pageLinkText" value="${requestScope.pageLinkText}" />

<c:set var="resultPage" value="${requestScope['com.escenic.search.ResultPage']}"/>
<bean:define id="pageUrl" name="resultPage" property="url[${pageNumber}]"/>

<c:url var="contextPath" value="/"/>
<c:url var="pageLink" value="/${fn:substringAfter(pageUrl,contextPath)}">
  <c:forEach var="p" items="${param}">
    <c:if test="${p.key != 'pageNumber'}">
      <c:param name="${p.key}" value="${p.value}"/>
    </c:if>
  </c:forEach>
</c:url>

<a href="${pageLink}"><c:out value="${fn:trim(pageLinkText)}" escapeXml="true"/></a>
