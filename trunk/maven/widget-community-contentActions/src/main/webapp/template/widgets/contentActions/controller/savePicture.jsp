<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/controller/savePicture.jsp#1 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- the general controller has already set a HashMap named 'contentActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${not empty requestScope.articleObject}">
    <c:set target="${contentActions}" property="action" value="/community/editPicture"/>
    <c:set target="${contentActions}" property="headline">
      <fmt:message key="contentActions.widget.savePicture.edit.headline"/>
    </c:set>
  </c:when>
  <c:otherwise>
    <c:set target="${contentActions}" property="action" value="/community/addPicture"/>
    <c:set target="${contentActions}" property="headline">
      <fmt:message key="contentActions.widget.savePicture.add.headline"/>
    </c:set>
  </c:otherwise>
</c:choose>

<c:set target="${contentActions}" property="contentTypeName" value="picture"/>
<c:set target="${contentActions}" property="state" value="published"/>
<section:use uniqueName="archivePictures">
  <c:set target="${contentActions}" property="successUrl" value="${section.url}" />
</section:use>
<c:set target="${contentActions}" property="errorUrl" value="${section.url}"/>
<c:set target="${contentActions}" property="imageVersion" value="w460"/>




