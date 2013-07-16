<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/postings.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${forum.postingsSource == 'thread' and requestScope['com.escenic.context'] == 'art' and article.articleTypeName == 'posting'}">
    <jsp:include page="helpers/articlePostings.jsp" />
  </c:when>
  <c:when test="${forum.postingsSource == 'latest'}">
    <jsp:include page="helpers/sectionPostings.jsp" />
  </c:when>
</c:choose>

<c:remove var="forum" scope="request" /> 