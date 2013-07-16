<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userActivity/src/main/webapp/template/widgets/userActivity/view/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>

<jsp:useBean id="userActivity" type="java.util.HashMap" scope="request"/>

<%-- View specific content fields --%>
<c:if test="${not empty userActivity.attributeMapList}">
  <c:set var="allClasses">userActivity ${userActivity['tabbingStyleClass']} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if
      test="${not empty userActivity['customStyleClass']}"> ${userActivity['customStyleClass']}</c:if></c:set>

  <div class="${allClasses}" <c:if test="${not empty userActivity['styleId']}">id="${userActivity['styleId']}"</c:if>>
    <div class="header">
      <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
    </div>

    <div class="content">
      <c:forEach items="${userActivity.attributeMapList}" var="attributeMap" varStatus="status">
        <div class="${status.first?'article first':'article'}">
          <c:if test="${userActivity.showAvatar}">
            <a href="${attributeMap.blogUrl}"><%--
              --%><img src="${attributeMap.avatureImageUrl}"
                   alt="${attributeMap.username}"
                   title="${attributeMap.username}"
                   width="${userActivity.avatarSize}"
                   height="${userActivity.avatarSize}" /><%--
            --%></a>
          </c:if>

          <p class="title">
            <a href="${attributeMap.blogUrl}">${attributeMap.username}</a>
            <c:out value="${attributeMap.actionText}" escapeXml="true"/>
            <a href="${attributeMap.articleUrl}"><c:out value="${attributeMap.articleTitle}" escapeXml="true"/></a>
          </p>

          <c:if test="${userActivity.showSummary}">
            <p class="summary"><c:out value="${attributeMap.articleSummary}" escapeXml="true"/></p>
          </c:if>

          <p class="dateline"><c:out value="${attributeMap.dateSting}" escapeXml="true"/></p>
        </div>
      </c:forEach>
    </div>
  </div>

</c:if>


<c:remove var="userActivity" scope="request"/>
