<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profile/src/main/webapp/template/widgets/profile/controller/summary.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the summary view of the profile widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="articleextra" uri="http://www.escenic.com/taglib/escenic-articleextra" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%-- the general controller has already set a HashMap named 'profile' in the requestScope --%>
<jsp:useBean id="profile" type="java.util.Map" scope="request"/>

<profile:present>
  <section:use uniqueName="${user.userName}">
    <community:user id="profileUser" sectionId="${section.id}"/>
  </section:use>
</profile:present>
<profile:notPresent>
  <community:user id="profileUser" sectionId="${section.id}"/>
</profile:notPresent>

<c:set target="${profile}" property="user" value="${profileUser}" />
<c:if test="${profile.showAvatar}">
  <c:choose>
    <c:when test="${not empty profileUser.article.relatedElements.profilePictures.items
                          and profileUser.article.relatedElements.profilePictures.items[0].content.articleTypeName == 'avatar'}">
      <c:set target="${profile}" property="avatarImageUrl" value="${profileUser.article.relatedElements.profilePictures.items[0].content.fields.alternates.value[profile.avatarImageVersion].href}" />
    </c:when>
    <c:otherwise>
      <c:set target="${profile}" property="avatarImageUrl" value="${skinUrl}gfx/profile/default-avatar.jpg" />
    </c:otherwise>
  </c:choose>
</c:if>
<article:use articleId="${profileUser.articleId}">
  <articleextra:articleType id="articleType" typeName="${article.articleTypeName}" />

  <jsp:useBean id="fieldMap" class="java.util.LinkedHashMap"/>
  <c:forEach var="panel" items="${articleType.panels}">
    <c:if test="${fn:toLowerCase(panel.name) == 'registration'}">
      <c:forEach var="field" items="${panel.fields}">
        <c:set var="fieldType" value="${field.type.type}" />
        <%-- fieldType: BASIC=1, NUMBER=2, DATE=3, BOOLEAN=4, ENUMERATION=5, HIDDEN=6, CATEGORY=7, SCHEDULE=8 --%>
        <c:if test="${fieldType >=1 and fieldType <=5}">
          <c:set var="fieldValue" value="${fn:trim(article.fields[field.name])}" />
          <c:if test="${not empty fieldValue}">
            <c:set target="${fieldMap}" property="${field.label}" value="${fieldValue}" />
          </c:if>
        </c:if>
      </c:forEach>
    </c:if>
  </c:forEach>

  <c:set target="${profile}" property="fields" value="${fieldMap}" />
</article:use>
<c:remove var="profileUser" scope="request"/>