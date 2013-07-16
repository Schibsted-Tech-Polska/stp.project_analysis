<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/view/rssHeadline.jsp#2 $
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
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="feed" type="java.util.Map" scope="request"/>

<%-- render the HTML --%>
<util:cache id="feed-cache-headlines-${widgetContent.id}" expireTime="${feed.updateInterval}">
  <div class="${feed.wrapperStyleClass}" <c:if test="${not empty feed.styleId}">id="${feed.styleId}"</c:if>>
    <wf-core:getRssFeed id="syndEntryList" sourceUrls="${feed.sourceUrls}" maxArticles="${feed.maxArticles}"/>

    <c:if test="${requestScope.tabbingEnabled!='true'}">
      <div class="header">
        <h5><c:out value="${fn:trim(element.fields.title.value)}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <c:if test="${not empty requestScope.syndEntryList}">
      <div class="content">
        <ul>
          <c:forEach var="syndEntry" items="${requestScope.syndEntryList}">
            <li><a href="<c:out value="${syndEntry.link}"/>" onclick="return openLink(this.href,'_blank')"><c:out value="${syndEntry.title}" escapeXml="true"/></a></li>
          </c:forEach>
        </ul>
      </div>
    </c:if>

    <c:remove var="syndEntryList" scope="request"/>
  </div>
</util:cache>

<c:remove var="feed" scope="request"/>