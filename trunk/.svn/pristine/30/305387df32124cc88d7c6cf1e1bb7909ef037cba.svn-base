<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-popularList/src/main/webapp/template/widgets/popularList/view/mostEmailed.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- The purpose of this JSP page is to render the mostEmailed view of popularList widget. --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'popularList' in the requestScope --%>
<jsp:useBean id="popularList" type="java.util.HashMap" scope="request"/>

<c:set var="popularListItems" value="${popularList.items}"/>

<c:if test="${not empty popularListItems}">
  <div class="${popularList.wrapperStyleClass}" <c:if test="${not empty popularList.styleId}">id="${popularList.styleId}"</c:if>>
    <c:if test="${popularList.tabbingEnabled!='true'}">
      <div class="header">
        <h5>
          <c:out value="${popularList.headline}" escapeXml="true"/>
        </h5>
      </div>
    </c:if>

    <div class="content">
      <c:forEach var="popularListItem" items="${popularListItems}" varStatus="status">

        <c:set var="firstStyle" value="${status.first ? ' first' : ''}"/>
        <c:set var="lastStyle" value="${status.last ? ' last' : ''}"/>

        <c:if test="${fn:contains(popularList.customStyleClass,'thumbnailList')}">
          <c:set var="articleDivWidth" value="${fn:substring(popularList.imageVersion,1,fn:length(popularList.imageVersion))}"/>
        </c:if>

        <div class="article ${firstStyle} ${lastStyle}" <c:if test="${not empty articleDivWidth}">style="width:${articleDivWidth}px;" </c:if> >
          <!-- image -->
          <c:if test="${popularList.showRelatedPicture=='true' and not empty popularListItem.teaserImageUrl}">
            <c:choose>
              <c:when test="${popularListItem.isVideo == 'true'}">
                <div class="relatedPic">
                  <a class="relatedPic" href="${popularListItem.url}"><img class="relatedPic ${popularListItem.inpageImageClass}"
                                                                     src="${popularListItem.teaserImageUrl}"
                                                                     alt="${popularListItem.teaserImageAltText}"
                                                                     width="${popularListItem.teaserImageWidth}"
                                                                     height="${popularListItem.teaserImageHeight}"
                                                                     title="${popularListItem.teaserImageTitle}" /></a>
                  <a class="play" href="${popularListItem.url}">
                    <div class="play">&nbsp;</div>
                  </a>
                </div>

              </c:when>
              <c:otherwise>
                <a class="relatedPic" href="${popularListItem.url}"><img class="relatedPic ${popularListItem.inpageImageClass}"
                                                                     src="${popularListItem.teaserImageUrl}"
                                                                     alt="${popularListItem.teaserImageAltText}"
                                                                     width="${popularListItem.teaserImageWidth}"
                                                                     height="${popularListItem.teaserImageHeight}"
                                                                     title="${popularListItem.teaserImageTitle}" /></a>
              </c:otherwise>
            </c:choose>
          </c:if>

          <!-- style classes necessary for setting height -->
          <c:if test="${popularList.showLeadtext == 'true'}">
            <c:set var="styleClassForLeadtext" value="leadtext" />
          </c:if>
          <c:if test="${popularList.showCommentCount == 'true'}">
            <c:set var="styleClassForCommentCount" value="comment" />
          </c:if>

          <div class="info title ${styleClassForLeadtext} ${styleClassForCommentCount}">
            <!-- title -->
            <h4>
              <a href="${popularListItem.url}" class="${popularListItem.inpageTitleClass}">${popularListItem.title}</a>
              <!-- comments -->
              <c:if test="${popularList.showCount=='true'}">
                (<c:out value="${popularListItem.count}" escapeXml="true"/>)
              </c:if>
            </h4>

            <!-- leadtext -->
            <c:if test="${popularList.showLeadtext == 'true' and not empty popularListItem.leadtext}">
              <p class="leadtext ${popularListItem.inpageLeadtextClass}"><c:out value="${popularListItem.leadtext}" escapeXml="true"/></p>
            </c:if>

            <c:if test="${popularList.showCommentCount and not empty popularListItem.commentsLinkText}">
              <p class="comments">
                <a href="${popularListItem.commentsLinkUrl}"><c:out value="${popularListItem.commentsLinkText}" escapeXml="true"/></a>
              </p>
            </c:if>
          </div>

        </div>
      </c:forEach>
    </div>
  </div>
</c:if>

<c:remove var="popularList" scope="request" />