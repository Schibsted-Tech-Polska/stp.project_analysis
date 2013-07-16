<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/controller/editProfile.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the editProfile view of the profileActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'profileActions' in the requestScope --%>
<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>

<c:if test="${empty profileActions.headline}">
  <c:set target="${profileActions}" property="headline">
    <fmt:message key="profileActions.widget.editProfile.header" />
  </c:set>
</c:if>

<c:set target="${profileActions}" property="action" value="/community/editUserProfile"/>
<c:set target="${profileActions}" property="successUrl" value="${profileActions.editProfileUrl}?profileActions=success"/>
<c:set target="${profileActions}" property="errorUrl" value="${profileActions.editProfileUrl}"/>
<c:set target="${profileActions}" property="panelNames" value="registration, userInfo"/>
<c:set target="${profileActions}" property="excludeFields" value="username, fullname" />