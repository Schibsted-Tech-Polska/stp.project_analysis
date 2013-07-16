<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profile/src/main/webapp/template/widgets/profile/view/helpers/links.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render profile editing links for profile widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- the controller has already set a HashMap named 'profile' in the requestScope --%>
<jsp:useBean id="profile" type="java.util.Map" scope="request"/>

<c:set var="profileUser" value="${profile.user}" />

<profile:present>
  <community:user id="currentUser" />
  
  <c:if test="${currentUser.id == profileUser.id}">
    <div class="links">
      <ul>
        <li class="first">
          <fmt:message var="editProfileLinkText" key="profileActions.widget.editProfile.header"/>
          <wf-community:getEditProfileLink linkText="${editProfileLinkText}" />
        </li>

        <li>
          <a href="${profile.changePasswordUrl}"><fmt:message
              key="profileActions.widget.changePassword.header" /></a>
        </li>
        
        <li>
          <a href="${profile.logoutUrl}"><fmt:message
              key="profileActions.widget.logout.header" /></a>
        </li>
      </ul>
    </div>
  </c:if>
</profile:present>