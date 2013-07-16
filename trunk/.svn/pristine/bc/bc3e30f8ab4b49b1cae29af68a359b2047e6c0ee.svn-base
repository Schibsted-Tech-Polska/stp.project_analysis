<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-blogUserList/src/main/webapp/template/widgets/blogUserList/view/default.jsp#2 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="blogUserList" type="java.util.Map" scope="request"/>

<c:set var="allClasses">blogUserList blogs widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id} ${blogUserList['tabbingStyleClass']}<c:if
    test="${not empty blogUserList['customStyleClass']}"> ${blogUserList['customStyleClass']}</c:if></c:set>
<div class="${allClasses}" <c:if test="${not empty blogUserList['styleId']}">id="${blogUserList['styleId']}"</c:if>>

  <div class="header">
    <h5><c:out value="${element.fields.title.value}" escapeXml="true"/></h5>
  </div>

  <c:if test="${blogUserList.showSeeMoreLink}">
    <div class="seeMore">
      <p><a href="${blogUserList.seeMoreLinkedUrl}"><c:out value="${blogUserList.seeMoreLinkLabel}" escapeXml="true"/></a></p>
    </div>
  </c:if>

  <div class="content">
    <c:if test="${not empty blogUserList['attributeMapList']}">
      <c:forEach var="attributeMap" items="${blogUserList['attributeMapList']}" varStatus="status">
        <div class="${status.first?'article first':'article'}">

          <h3><a href="${attributeMap.blogUrl}"><c:out value="${attributeMap.blogName}" escapeXml="true"/></a></h3>

          <c:if test="${blogUserList.showAvatar}">
            <a href="${attributeMap.blogUrl}"><%--
              --%><img src="${attributeMap.avatureImageUrl}"
                       alt="${attributeMap.blogName}"
                       title="${attributeMap.blogName}"
                       width="${blogUserList.avatarSize}"
                       height="${blogUserList.avatarSize}" /><%--
            --%></a>
          </c:if>

          <article:use article="${attributeMap.userArtilces[0]}">
            <h4><a href="${article.url}"><c:out value="${article.fields.title}" escapeXml="true"/></a></h4>

            <c:if test="${blogUserList.showBody}">
              <wf-core:stripHTML id="formattedBody" value="${article.fields.body}" maxLength="${blogUserList.maxBodyChar}"/>
              <p class="postBody"><c:out value="${formattedBody}" escapeXml="true"/></p>
              <c:remove var="formattedBody" scope="request" />
            </c:if>

          </article:use>

          <c:if test="${fn:length(attributeMap.userArtilces)>1}">
            <ul>
              <c:forEach items="${attributeMap['userArtilces']}" var="anArticle" begin="1">
                <article:use article="${anArticle}">
                  <li><a href="${article.url}"><c:out value="${article.fields.title}" escapeXml="true"/></a></li>
                </article:use>
              </c:forEach>
            </ul>
          </c:if>
        </div>
      </c:forEach>
    </c:if>
  </div>
</div>

<c:remove var="blogUserList" scope="request"/>



