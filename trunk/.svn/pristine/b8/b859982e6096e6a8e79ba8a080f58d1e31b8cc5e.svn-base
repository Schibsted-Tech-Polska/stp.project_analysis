  <%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profileMenu/src/main/webapp/template/widgets/profileMenu/view/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the profileMenu widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  <%-- the controller has already set a Map named 'profileMenu' in the requestScope --%>
<jsp:useBean id="profileMenu" type="java.util.Map" scope="request"/>

<div class="${profileMenu.wrapperStyleClass}" <c:if test="${not empty profileMenu.styleId}">id="${profileMenu.styleId}"</c:if>>
  <c:if test="${profileMenu.showAvatar == true}">
    <div class="profilePicture">
      <c:choose>
        <c:when test="${not empty profileMenu.avatarPicture}">
          <c:set var="imageVersion" value="${profileMenu.avatarImageVersion}" />
          <img src="${profileMenu.avatarPicture.fields.alternates.value[imageVersion].href}"
               title="${fn:trim(profileMenu.avatarPicture.fields.caption.value)}"
               alt="${fn:trim(profileMenu.avatarPicture.fields.alttext.value)}"
               width="${profileMenu.avatarPicture.fields.alternates.value[imageVersion].width}"
               height="${profileMenu.avatarPicture.fields.alternates.value[imageVersion].height}"/>
        </c:when>
        <c:otherwise>
          <c:set var="avatarSize" value="${fn:substringAfter(profileMenu.avatarImageVersion, 'w')}" />
          <img src="${skinUrl}gfx/profileMenu/default-avatar.jpg" width="${avatarSize}" height="${avatarSize}"
               alt="" class="default-avatar" />
        </c:otherwise>
      </c:choose>
    </div>
  </c:if>
  <profile:present>
    <ul>
      <li class="first">
        <c:out value="${profileMenu.welcomeText}" escapeXml="true"/>
        <a href="${profileMenu.userProfileUrl}"><c:out value="${profileMenu.username}" escapeXml="true"/></a>
      </li>
      <li>
        <wf-community:getEditProfileLink linkText="${profileMenu.editProfileLinkText}" />
      </li>
      <li>
        <a href="${profileMenu.logoutUrl}"><c:out value="${profileMenu.logoutLinkText}" escapeXml="true"/></a>
      </li>
    </ul>
  </profile:present>


  <profile:notPresent>
    <ul>
      <li class="first">
        <a href="${profileMenu.loginUrl}"><c:out value="${profileMenu.loginLinkText}" escapeXml="true"/></a>
      </li>
      <li>
        <a href="${profileMenu.registrationUrl}"><c:out value="${profileMenu.registrationLinkText}" escapeXml="true"/></a>
      </li>
    </ul>
  </profile:notPresent>
</div>

<c:remove var="profileMenu" scope="request" />