
<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/controller/saveBlogPost.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the changePassword view of the contentActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="articleextra" uri="http://www.escenic.com/taglib/escenic-articleextra" %>

<%-- the general controller has already set a HashMap named 'contentActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${empty requestScope.articleObject}">
    <c:set target="${contentActions}" property="action" value="/community/addBlogPost" />
    <c:set target="${contentActions}" property="headline">
      <fmt:message key="contentActions.widget.saveBlogPost.add.headline"/>
    </c:set>
  </c:when>
  <c:otherwise>
    <c:set target="${contentActions}" property="action" value="/community/editBlogPost" />
    <c:set target="${contentActions}" property="headline">
      <fmt:message key="contentActions.widget.saveBlogPost.edit.headline"/>
    </c:set>    
  </c:otherwise>
</c:choose>

<c:set target="${contentActions}" property="panelNames" value="default" />
<c:set target="${contentActions}" property="contentTypeName" value="blogPost" />

<articleextra:articleType id="contentType" typeName="${contentActions.contentTypeName}" />
<c:set target="${contentActions}" property="contentType" value="${contentType}" />
<c:set target="${contentActions}" property="state" value="published" />
<c:set target="${contentActions}" property="errorUrl" value="${section.url}" />


