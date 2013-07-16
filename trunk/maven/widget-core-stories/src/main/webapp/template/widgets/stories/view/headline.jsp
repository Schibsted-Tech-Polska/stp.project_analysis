<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/headline.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
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


<jsp:useBean id="stories" type="java.util.HashMap" scope="request"/>

<div class="${stories.wrapperStyleClass} ${stories.inpageDnDAreaClass}" <c:if test="${not empty stories.styleId}">id="${stories.styleId}"</c:if>>
  <c:if test="${stories.showSectionTitle and stories.selectSectionName=='current'}">
    <div class="header">
      <h5><c:out value="${stories.sectionName}" escapeXml="true"/></h5>
    </div>
  </c:if>
  <c:forEach var="item" begin="${stories.begin}" end="${stories.end}" items="${stories.articles}"
             varStatus="status">

    <c:choose>
      <c:when test="${stories.source eq 'automatic'}">
        <c:set var="articleUrl">
          <c:choose>
            <c:when test="${stories.linkBehaviour eq 'sectionPage'}">
              <c:out value="${item.homeSection.url}" escapeXml="true"/>
            </c:when>
            <c:otherwise>
              <c:out value="${item.url}" escapeXml="true"/>
            </c:otherwise>
          </c:choose>
        </c:set>
        <c:set var="cArticle" value="${item}"/>
        <c:if test="${empty teaserOption}">
          <c:set var="teaserOption" value="default"/>
        </c:if>
      </c:when>
      <c:otherwise>
        <c:set var="articleUrl">
          <c:choose>
            <c:when test="${stories.linkBehaviour eq 'sectionPage'}">
              <c:out value="${item.content.homeSection.url}" escapeXml="true"/>
            </c:when>
            <c:otherwise>
              <c:out value="${item.content.url}" escapeXml="true"/>
            </c:otherwise>
          </c:choose>
        </c:set>
        <c:set var="cArticle" value="${item.content}"/>
        <c:set var="articleSummary" value="${item}"/>
        <c:set var="teaserOption" value="${articleSummary.options.teaserOptions}"/>
        <c:set var="inpageDnDSummaryClass" value="${articleSummary.options.inpageClasses}" />
      </c:otherwise>
    </c:choose>

    <c:if test="${stories.showSectionTitle and status.first and stories.selectSectionName=='first'}">
      <div class="header">
        <h5><c:out value="${cArticle.homeSection.name}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <c:set var="firstArticleStyleClass" value="${status.first ? 'first' : ''}"/>

    <div class="article ${cArticle.articleTypeName} ${firstArticleStyleClass} ${teaserOption} ${inpageDnDSummaryClass}">
    <%--<div class="article ${firstArticleStyleClass}">--%>
      <div class="media ${cArticle.articleTypeName}">
         <h${stories.headingSize} class="${teaserOption}">
          <c:choose>
            <c:when test="${stories.source eq 'automatic'}">
              <wf-core:handleLineBreaks var="modifiedTitle" value="${cArticle.fields.title.value}"/>
              <c:set var="inpageTitleClass" value="${cArticle.fields.title.options.inpageClasses}"/>
            </c:when>
            <c:otherwise>
              <wf-core:handleLineBreaks var="modifiedTitle" value="${articleSummary.fields.title.value}"/>
              <c:set var="inpageTitleClass" value="${articleSummary.fields.title.options.inpageClasses}"/>
            </c:otherwise>
          </c:choose>

          <a href="${articleUrl}" class="${inpageTitleClass}">
            <c:out value="${modifiedTitle}" escapeXml="false"/>
          </a>

          <c:remove var="modifiedTitle" scope="request" />

          <c:if test="${stories.showComments}">
            <wf-core:countArticleComments var="numOfComments" articleId="${cArticle.id}"/>
            <c:choose>
              <c:when test="${numOfComments>0}">
                <c:set var="commentsListingUrl" value="${cArticle.url}#commentsList"/>
              </c:when>
              <c:otherwise>
                <c:set var="commentsListingUrl" value="${cArticle.url}#commentsForm"/>
              </c:otherwise>
            </c:choose>

            (<a href="${commentsListingUrl}"><fmt:message key="stories.widget.comment.count">
                    <fmt:param value="${numOfComments}"/>
            </fmt:message></a>)

            <c:remove var="numOfComments" scope="request"/>
          </c:if>
        </h${stories.headingSize}>
      </div>
    </div>
    <c:remove var="cArticle"/>
  </c:forEach>
</div>

<c:remove var="stories" scope="request"/>