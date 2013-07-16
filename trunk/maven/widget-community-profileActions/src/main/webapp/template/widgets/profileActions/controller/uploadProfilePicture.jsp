<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/controller/uploadProfilePicture.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the uploadProfilePicture view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- the general controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<c:set target="${profileActions}" property="action" value="/community/addProfilePicture"/>

<c:if test="${empty profileActions.headline}">
  <c:set target="${profileActions}" property="headline">
    <fmt:message key="profileActions.widget.uploadProfilePicture.header"/>
  </c:set>
</c:if>

<c:set target="${profileActions}" property="contentTypeName" value="picture"/>
<c:set target="${profileActions}" property="state" value="published"/>
<c:set target="${profileActions}" property="errorUrl" value="${section.url}"/>
<c:set target="${profileActions}" property="imageVersion" value="w460"/>

<section:use uniqueName="uploadProfilePicture">
  <c:set target="${profileActions}" property="successUrl" value="${section.url}?profileActions=success"/>
</section:use>