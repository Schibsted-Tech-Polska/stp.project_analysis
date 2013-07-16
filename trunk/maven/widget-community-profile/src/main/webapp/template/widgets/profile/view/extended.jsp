<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-profile/src/main/webapp/template/widgets/profile/view/extended.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the extended view of the profile widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- the controller has already set a HashMap named 'profile' in the requestScope --%>
<jsp:useBean id="profile" type="java.util.Map" scope="request"/>

<div class="${profile.wrapperStyleClass}" <c:if test="${not empty profile.styleId}">id="${profile.styleId}"</c:if>>
  <c:set var="profileUser" value="${profile.user}" />
  <c:if test="${profile.showAvatar}">
    <div class="profilePicture">
      <img src="${profile.avatarImageUrl}"
         title="${profileUser.article.fields.firstname}"
         alt="${profileUser.article.fields.firstname}"
         width="${profile.avatarImageWidth}" height="${profile.avatarImageWidth}"
         style="float:left; margin-right:5px;"
        />
    </div>
  </c:if>
  <h1><c:out value="${profileUser.article.fields.firstname} ${profileUser.article.fields.surname}" escapeXml="true"/></h1>

  <c:forEach var="profilePanel" items="${profile.panels}">
    <c:if test="${not empty profilePanel.fields}">
      <c:if test="${not empty profilePanel.label}">
        <h2><c:out value="${profilePanel.label}" escapeXml="true"/></h2>
      </c:if>

      <div class="fields">
        <c:forEach var="profileFieldEntry" items="${profilePanel.fields}">
          <dl>
            <dt><c:out value="${profileFieldEntry.key}" escapeXml="true"/> :</dt>
            <dd><c:out value="${profileFieldEntry.value}" escapeXml="true"/></dd>
          </dl>
        </c:forEach>
      </div>
    </c:if>
  </c:forEach>

  <jsp:include page="helpers/links.jsp" />
</div>

<c:remove var="profile" scope="request" />
