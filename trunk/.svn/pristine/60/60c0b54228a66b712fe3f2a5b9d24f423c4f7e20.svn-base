<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentsPageLink.jsp#2 $
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
  The purpose of this page is to display link of a comments page of an article with given pageNumber and  pageLinkText
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
  this JSP page expects two objects in the request scope 'pageNumber' and 'pageLinkText'
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="pageNumber" type="java.lang.String" scope="request" />
<jsp:useBean id="pageLinkText" type="java.lang.String" scope="request" />

<c:url var="pageUrl" value="${article.url}">
  <c:param name="pageNumber" value="${pageNumber}"/>
</c:url>

<a href="${pageUrl}#commentsList"><c:out value="${fn:trim(pageLinkText)}" escapeXml="true"/></a>