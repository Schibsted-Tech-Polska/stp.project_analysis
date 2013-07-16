<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileActions/src/main/webapp/template/widgets/profileActions/view/helpers/links.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<jsp:useBean id="profileActions" type="java.util.Map" scope="request"/>
<jsp:useBean id="homeSectionId" type="java.lang.Integer" scope="request"/>

<community:user id="currentUser" sectionId="${homeSectionId}"/>

<div class="links">
  <ul>
    <li class="first">
      <a href="${currentUser.section.url}">
        <fmt:message key="profileActions.widget.viewProfile.linkText"/>
      </a>
    </li>
    <li>
      <a href="${profileActions.changePasswordUrl}">
        <fmt:message key="profileActions.widget.changePassword.header"/>
      </a>
    </li>
    <li>
      <a href="${profileActions.uploadProfilePictureUrl}">
        <fmt:message key="profileActions.widget.uploadProfilePicture.header"/>
      </a>
    </li>
    <li>
      <a href="${profileActions.deleteProfileUrl}">
        <fmt:message key="profileActions.widget.deleteProfile.header"/>
      </a>
    </li>
  </ul>
</div>