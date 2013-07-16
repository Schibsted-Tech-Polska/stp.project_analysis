<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/custom.jsp#3 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
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

        <c:choose>
          <c:when test="${stories.enableSlideshow}">
            <wf-core:getTeaserImageMapList var="teaserImageMapList" articleId="${cArticle.id}"
                                             imageVersion="${stories.imageVersion}"/>
          </c:when>
          <c:otherwise>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${cArticle.id}"/>
          </c:otherwise>
        </c:choose>
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
        <c:set var="articleSummary" value="${item}"/>
        <c:set var="cArticle" value="${item.content}"/>
        <c:set var="teaserOption" value="${articleSummary.options.teaserOptions}"/>
        <c:set var="inpageDnDSummaryClass" value="${articleSummary.options.inpageClasses}" />
        <c:choose>
          <c:when test="${stories.enableSlideshow}">
            <wf-core:getTeaserImageMapList var="teaserImageMapList" articleSummary="${articleSummary}"
                                             imageVersion="${stories.imageVersion}"/>
          </c:when>
          <c:otherwise>
            <wf-core:getTeaserImageMap var="teaserImageMap" articleSummary="${articleSummary}"/>
          </c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>

    <c:if test="${stories.showSectionTitle and status.first and stories.selectSectionName=='first'}">
      <div class="header">
        <h5><c:out value="${cArticle.homeSection.name}" escapeXml="true"/></h5>
      </div>
    </c:if>

    <c:set var="firstArticleStyleClass" value="${status.first ? 'first' : ''}"/>

    <div class="article ${cArticle.articleTypeName} ${firstArticleStyleClass} ${teaserOption} ${inpageDnDSummaryClass}">

      <c:if test="${stories.showSectionName}">
        <div class="media ${cArticle.articleTypeName}">
          <h6>
             <c:out value="${stories.sectionNamePrefix}" escapeXml="true"/>
            <c:choose>
              <c:when test="${stories.sectionNameLink}">
                <a href="${cArticle.homeSection.url}"><c:out value="${cArticle.homeSection.name}" escapeXml="true"/></a>
              </c:when>
              <c:otherwise>
                <c:out value="${cArticle.homeSection.name}" escapeXml="true"/>
              </c:otherwise>
            </c:choose>
          </h6>
        </div>
      </c:if>
      <div class="text">
        <c:set var="showImage" value="${stories.enableSlideshow!=true and stories.showImage and
                                        not empty requestScope.teaserImageMap.imageArticle}"/>


        <c:set var="storyArticle" value="${cArticle}" scope="request"/>
        <c:choose>
          <c:when test="${stories.enableSlideshow}">
            <c:choose>
              <c:when test="${fn:length(teaserImageMapList)==1}">
                <c:set var="teaserImageMap" value="${teaserImageMapList[0]}" scope="request"/>
                <jsp:include page="helpers/topPicture.jsp"/>
                <c:remove var="teaserImageMap" scope="request"/>
              </c:when>
              <c:when test="${fn:length(teaserImageMapList)>1}">
                <jsp:include page="helpers/slideshow.jsp"/>
              </c:when>
            </c:choose>
            <c:remove var="teaserImageMapList" scope="request"/>
          </c:when>
          <c:when test="${showImage and stories.imagePosition=='top'}">
            <jsp:include page="helpers/topPicture.jsp"/>
          </c:when>
          <c:when test="${showImage and stories.imagePosition!='top' and stories.textWrap!='true'}">
            <c:set var="storyUrl" value="${articleUrl}" scope="request"/>
            <jsp:include page="helpers/picture.jsp"/>
            <c:remove var="storyUrl" scope="request"/>
          </c:when>
        </c:choose>
        <c:remove var="storyArticle" scope="request"/>

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

        <h${stories.headingSize}>
          <a href="${articleUrl}" class="${inpageTitleClass}">
            <c:out value="${modifiedTitle}" escapeXml="false"/>
          </a>
        </h${stories.headingSize}>

        <c:choose>
          <c:when test="${stories.source eq 'automatic'}">
            <c:set var="intro" value="${cArticle.fields.leadtext.value}"/>
            <c:set var="inpageLeadtextClass" value="${cArticle.fields.leadtext.options.inpageClasses}"/>
          </c:when>
          <c:otherwise>
            <c:set var="intro" value="${articleSummary.fields.leadtext.value}"/>
            <c:set var="inpageLeadtextClass" value="${articleSummary.fields.leadtext.options.inpageClasses}"/>
          </c:otherwise>
        </c:choose>

        <c:if test="${stories.showIntro and not empty intro}">
          <c:if test="${not empty stories.maxCharacters and fn:length(intro) > stories.maxCharacters}">
            <c:set var="intro" value="${fn:substring(intro, 0, stories.maxCharacters)}"/>
            <c:set var="intro" value="${intro}..."/>
          </c:if>
          <p class="summary">
            <c:if test="${showImage and stories.imagePosition!='top' and stories.textWrap=='true'}">
              <c:set var="storyUrl" value="${articleUrl}" scope="request"/>
              <jsp:include page="helpers/picture.jsp"/>
              <c:remove var="storyUrl" scope="request"/>
            </c:if>
            <span class="${inpageLeadtextClass}"><c:out value="${intro}"/></span>
          </p>
        </c:if>

        <c:if test="${not empty stories.readMore}">
          <a href="${articleUrl}"><c:out value="${stories.readMore}" escapeXml="true"/></a>
        </c:if>

        <c:if test="${stories.showComments}">
          <article:use articleId="${cArticle.id}">
            <wf-core:countArticleComments var="numOfComments" articleId="${article.id}"/>
            <c:set var="commentsListingUrl" value="${cArticle.url}#commentsList"/>
            <p class="comments">
              <a href="${commentsListingUrl}"><%--
                --%>
                <fmt:message key="stories.widget.comment.count">
                <fmt:param value="${numOfComments}"/>
                  </fmt:message>
                  <%--
                  --%></a>
            </p>
            <c:remove var="numOfComments" scope="request"/>
          </article:use>
        </c:if>

        <c:if test="${not fn:contains(stories.showRelated, 'none')}">
          <collection:createList id="relatedObjects"/>
          <c:forEach items="${stories.showRelated}" var="relationBox">
            <c:set var="relationBox" value="${fn:trim(relationBox)}"/>
            <c:if test="${not empty cArticle.relatedElements[relationBox].items}">
              <collection:addAll collection="relatedObjects" add="${cArticle.relatedElements[relationBox].items}"/>
            </c:if>
          </c:forEach>

          <c:if test="${not empty relatedObjects}">
            <div class="related">
              <c:if test="${not empty stories.relatedContentHeader}">
                <h4 class="related"><c:out value="${stories.relatedContentHeader}" escapeXml="true"/></h4>
              </c:if>
              <ul class="related">
                <c:forEach var="relatedObject" items="${relatedObjects}">
                  <wf-core:getFileTypeStyleClass var="styleClassName" relatedObject="${relatedObject}"/>
                  <c:set var="inpageRelatedTitleClass" value="${relatedObject.fields.title.options.inpageClasses}"/>
                  <li>
                    <a href="${relatedObject.content.url}" class="${styleClassName} ${inpageRelatedTitleClass}">
                        <c:out value="${relatedObject.content.title}" escapeXml="true"/>
                    </a>
                  </li>
                </c:forEach>
              </ul>
            </div>
          </c:if>
        </c:if>
      </div>
    </div>
    <c:remove var="cArticle"/>
    <c:remove var="teaserImageMap" scope="request"/>
  </c:forEach>
</div>

<c:remove var="stories" scope="request"/>
