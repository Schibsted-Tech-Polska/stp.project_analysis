<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/comments.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the comments view of list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request"/>
<div class="${list.wrapperStyleClass}" <c:if test="${not empty list.styleId}">id="${list.styleId}"</c:if>>
  <%-- show the header conditionally --%>
  <c:if test="${requestScope.tabbingEnabled!='true' and not empty list.commentsList}">
    <div class="header">
      <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
    </div>
  </c:if>

  <c:if test="${not empty list.commentsList}">
    <div class="content">
      <c:forEach var="commentMap" items="${list.commentsList}">
        <div class="article ${commentMap.articleClass}">
          <h4>
            <c:choose>
              <c:when test="${not empty commentMap.articleUrl}">
                <a href="${commentMap.articleUrl}"><c:out value="${commentMap.title}" escapeXml="true"/></a>
              </c:when>
              <c:otherwise>
                <a href="#"><c:out value="${commentMap.title}" escapeXml="true"/></a>
              </c:otherwise>
            </c:choose>
          </h4>

          <c:if test="${list.showBody}">
            <p><c:out value="${commentMap.body}" escapeXml="true"/></p>
          </c:if>

          <c:if test="${list.showAuthor or list.showDate}">
            <p class="dateline">
              <c:if test="${list.showAuthor}">
                <c:out value="${list.commentAuthorPrefix}" />
                <a href="${commentMap.authorUrl}"><c:out value="${commentMap.authorName}" escapeXml="true"/></a>
              </c:if>

              <c:if test="${list.showDate}">
                <c:out value="${list.commentDatePrefix}" escapeXml="true"/>
                <c:out value="${commentMap.publishedDate}" escapeXml="true"/>
              </c:if>
            </p>
          </c:if>

          <c:if test="${list.showCommentCount and not empty commentMap.commentsLinkUrl}">
            <p class="comments">
              <a href="${commentMap.commentsLinkUrl}"><c:out value="${commentMap.commentsLinkText}" escapeXml="true"/></a>
            </p>
          </c:if>
        </div>
      </c:forEach>
    </div>
  </c:if>
</div>

<c:remove var="list" scope="request"/>
