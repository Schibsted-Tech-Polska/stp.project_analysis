<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-feed/src/main/webapp/template/widgets/feed/view/rssFull.jsp#2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="feed" type="java.util.Map" scope="request"/>

<%-- render the HTML --%>
<util:cache id="feed-cache-full-${widgetContent.id}" expireTime="${feed.updateInterval}m">
  <div class="${feed.wrapperStyleClass}" <c:if test="${not empty feed.styleId}">id="${feed.styleId}"</c:if>>
    <wf-core:getRssFeed id="syndEntryList" sourceUrls="${feed.sourceUrls}" maxArticles="${feed.maxArticles}"/>

    <c:if test="${requestScope.tabbingEnabled!='true'}">
      <div class="header">
        <h5><c:out value="${fn:trim(element.fields.title.value)}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <c:if test="${not empty requestScope.syndEntryList}">
      <div class="content">
          <c:forEach var="syndEntry" items="${requestScope.syndEntryList}" varStatus="loopStatus">
            <wf-core:getStyleClassName id="articleClass" loopStatus="${loopStatus}"/>

            <div class="article ${requestScope.articleClass}">
              <c:if test="${feed.showImage}">
                <wf-core:parseFeedForImage id="feedImageUrl" value="${syndEntry.description.value}"/>
                <c:if test="${not empty requestScope.feedImageUrl}">
                  
                  <a href="${syndEntry.link}"><img src="${requestScope.feedImageUrl}" alt="" width="${feed.imageWidth}" height="${feed.imageHeight}"/></a>
                  <c:remove var="feedImageUrl" scope="request"/>
                </c:if>
              </c:if>
              
              <h4><a href="${syndEntry.link}" onclick="return openLink(this.href,'_blank')"><c:out value="${syndEntry.title}" escapeXml="true"/></a></h4>

              <c:if test="${feed.showSummary}">
                <wf-core:stripHTML id="feedSummary" value="${syndEntry.description.value}" maxLength="${feed.maxCharactersInSummary}"/>
                <p class="feedSummary"><c:out value="${requestScope.feedSummary}" escapeXml="true"/></p>
                <c:remove var="feedSummary" scope="request"/>
              </c:if>
              
              <c:if test="${feed.showAuthor and not empty syndEntry.author}">
                <p class="author">by <c:out value="${syndEntry.author}" escapeXml="true"/></p>
              </c:if>

              <c:if test="${feed.showSource}">
                <wf-core:getRssSource id="feedSource" rssUrl="${syndEntry.link}"/>
                <c:if test="${not empty requestScope.feedSource}">
                  <p class="source">from <a href="http://${requestScope.feedSource}"
                                            onclick="return openLink(this.href,'_blank')"><c:out value="${requestScope.feedSource}" escapeXml="true"/></a></p>
                </c:if>
                <c:remove var="feedSource" scope="request"/>
              </c:if>

              <c:if test="${feed.showDate}">
                <p class="dateline"><fmt:formatDate value="${syndEntry.publishedDate}" pattern="${feed.dateFormat}"/>
                </p>
              </c:if>
            </div>
            <c:remove var="articleClass" scope="request"/>
          </c:forEach>
      </div>
    </c:if>

    <c:remove var="syndEntryList" scope="request"/>
  </div>
</util:cache>

<c:remove var="feed" scope="request"/>