<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/newsletter.jsp#3 $
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


<table class="${stories.wrapperStyleClass}" cellpadding="0" cellspacing="0" border="0" width="100%">
  <c:if test="${stories.showSectionTitle and stories.selectSectionName=='current'}">
    <tr>
      <td>
        <h5 style="margin:5px 0 0 0;"><c:out value="${stories.sectionName}" escapeXml="true"/></h5>
      </td>
    </tr>
  </c:if>
  <c:forEach var="item" begin="${stories.begin}" end="${stories.end}" items="${stories.articles}"
             varStatus="status">

    <tr>
      <c:choose>
      <c:when test="${status.first}">
      <td>
        </c:when>
        <c:otherwise>
      <td style="margin:2px 0 0 0;border-top:1px dashed #D9D9D9;">
        </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${stories.source eq 'automatic'}">
            <c:set var="articleUrl">
              <c:choose>
                <c:when test="${stories.linkBehaviour eq 'sectionPage'}">
                  <c:out value="${item.homeSection.url}"/>
                </c:when>
                <c:otherwise>
                  <c:out value="${item.url}"/>
                </c:otherwise>
              </c:choose>
            </c:set>
            <c:set var="cArticle" value="${item}"/>
            <c:if test="${empty teaserOption}">
              <c:set var="teaserOption" value="default"/>
            </c:if>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${cArticle.id}"/>
          </c:when>
          <c:otherwise>
            <c:set var="articleUrl">
              <c:choose>
                <c:when test="${stories.linkBehaviour eq 'sectionPage'}">
                  <c:out value="${item.content.homeSection.url}"/>
                </c:when>
                <c:otherwise>
                  <c:out value="${item.content.url}" escapeXml="true"/>
                </c:otherwise>
              </c:choose>
            </c:set>
            <c:set var="articleSummary" value="${item}"/>
            <c:set var="cArticle" value="${item.content}"/>
            <c:set var="teaserOption" value="${articleSummary.options.teaserOptions}"/>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"/>
          </c:otherwise>
        </c:choose>

        <c:if test="${stories.showSectionTitle and status.first and stories.selectSectionName=='first'}">
          <h5 style="margin:0;"><c:out value="${cArticle.homeSection.name}" escapeXml="true"/></h5>
        </c:if>

        <c:set var="firstArticleStyleClass" value="${status.first ? 'first' : ''}"/>

        <h${stories.headingSize}
            style="margin:5px 0px 5px 0px;font-size:12px;font-family:Georgia,Arial,Verdana,Helvetica,sans-serif;text-decoration:underline;color:#004E8C;">
          <a href="${articleUrl}">
            <c:choose>
              <c:when test="${stories.source eq 'automatic'}">
                <wf-core:handleLineBreaks var="modifiedTitle" value="${cArticle.fields.title.value}"/>
                <c:out value="${modifiedTitle}" escapeXml="false"/>
              </c:when>
              <c:otherwise>
                <wf-core:handleLineBreaks var="modifiedTitle" value="${articleSummary.fields.title.value}"/>
                <c:out value="${modifiedTitle}" escapeXml="false"/>
              </c:otherwise>
            </c:choose>
          </a>
        </h${stories.headingSize}>

        <c:choose>
          <c:when test="${stories.source eq 'automatic'}">
            <c:set var="intro" value="${cArticle.fields.leadtext.value}"/>
          </c:when>
          <c:otherwise>
            <c:set var="intro" value="${articleSummary.fields.leadtext.value}"/>
          </c:otherwise>
        </c:choose>
        <c:if test="${not empty intro}">
          <c:if test="${not empty stories.maxCharacters and fn:length(intro) > stories.maxCharacters}">
            <c:set var="intro" value="${fn:substring(intro, 0, stories.maxCharacters)}"/>
            <c:set var="intro" value="${intro}..."/>
          </c:if>
          <p style="margin:0;display:inline;font-size:10px;">
            <table>
              <c:choose>
                <c:when test="${stories.imagePosition eq 'left'}">
                  <tr>
                    <td valign="top" align="left">
                      <c:set var="storyUrl" value="${articleUrl}" scope="request"/>
                      <jsp:include page="helpers/picture.jsp"/>
                      <c:remove var="storyUrl" scope="request"/>
                    </td>
                    <td>
                       <c:out value="${intro}" escapeXml="true"/>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${stories.imagePosition eq 'right'}">
                  <tr>
                    <td align="left" valign="top">
                        <c:out value="${intro}" escapeXml="true"/>
                    </td>
                    <td valign="top" align="right">
                      <c:set var="storyUrl" value="${articleUrl}" scope="request"/>
                      <jsp:include page="helpers/picture.jsp"/>
                      <c:remove var="storyUrl" scope="request"/>
                    </td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td>
                      <c:set var="storyUrl" value="${articleUrl}" scope="request"/>
                      <jsp:include page="helpers/picture.jsp"/>
                      <c:remove var="storyUrl" scope="request"/>
                    </td>
                  </tr>
                  <tr>
                    <td>
                       <c:out value="${intro}" escapeXml="true"/>
                    </td>
                  </tr>
                </c:otherwise>
              </c:choose>

            </table>
          </p>
        </c:if>

        <c:if test="${not empty stories.readMore}">
          <p style="margin:0;"><a href="${articleUrl}"><c:out value="${stories.readMore}" escapeXml="true"/></a></p>
        </c:if>

        <c:if test="${stories.showComments}">
          <article:use articleId="${cArticle.id}">
            <wf-core:countArticleComments var="numOfComments" articleId="${article.id}"/>
            <c:set var="commentsListingUrl" value="${cArticle.url}#commentsList"/>

            <fmt:message var="commentsLinkText" key="stories.widget.comment.count">
              <fmt:param value="${numOfComments}"/>
            </fmt:message>

            <p style="margin:0;">
              <a href="${commentsListingUrl}"><c:out value="${commentsLinkText}" escapeXml="true"/></a>
            </p>
            <c:remove var="numOfComments" scope="request"/>
          </article:use>
        </c:if>

      </td>
    </tr>

    <c:remove var="cArticle"/>
    <c:remove var="teaserImageMap"/>
  </c:forEach>

</table>

<c:remove var="stories" scope="request"/>

