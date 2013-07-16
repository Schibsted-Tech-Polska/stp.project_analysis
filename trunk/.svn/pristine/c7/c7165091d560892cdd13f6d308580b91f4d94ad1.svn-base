<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/view/helpers/articleInColumnView.jsp#3 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>
<jsp:useBean id="articleAttributeMap" type="java.util.Map" scope="request"/>

<c:set var="imageVersion" value="${articleAttributeMap.imageVersion}"/>
<c:set var="teaserImageMap" value="${articleAttributeMap.teaserImageMap}"/>
<c:set var="teaserImageArticle" value="${teaserImageMap.imageArticle}"/>

<c:choose>
  <c:when test="${articleAttributeMap.articleStyleClass eq 'first'}">
    <%-- handle the rendering of first article --%>
    <div class="article ${articleAttributeMap.articleStyleClass} ${articleAttributeMap.inpageDnDSummaryClass}">
      <c:choose>
        <c:when test="${trailers.imagePositionColumn eq 'top'}">
          <%-- handle image display at top--%>
          <%-- show image--%>
          <c:if test="${trailers.showImageColumn != 'none' and not empty teaserImageArticle}">
            <c:choose>
              <c:when test="${trailers.softCrop}">
                <c:set var="inpageImageClass" value="${teaserImageArticle.fields.alternates.value[imageVersion].inpageClasses}"/>
                <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                     alt="${teaserImageMap.alttext}"
                     class="${inpageImageClass}"
                     onclick="location.href='${articleAttributeMap.url}'"
                     title="${teaserImageMap.caption}"
                     width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                     height="${teaserImageArticle.fields.alternates.value[imageVersion].height}" />
              </c:when>
              <c:otherwise>
                <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                     onclick="location.href='${articleAttributeMap.url}'"
                     alt="${teaserImageMap.alttext}"
                     title="${teaserImageMap.caption}"/>
              </c:otherwise>
            </c:choose>
          </c:if>

          <%-- show title --%>
          <c:if test="${trailers.showTitleColumn != 'none'}">
            <h3>
              <a href="${articleAttributeMap.url}" class="${articleAttributeMap.inpageTitleClass}">
                <c:out value="${articleAttributeMap.title}" escapeXml="false"/>
              </a>
            </h3>
          </c:if>

          <%-- show intro --%>
          <c:if test="${trailers.showIntroColumn != 'none'}">
            <p class="summary ${articleAttributeMap.inpageLeadtextClass}">
              <c:out value="${articleAttributeMap.intro}" escapeXml="true"/>
            </p>
          </c:if>
        </c:when>
        <c:otherwise>
          <%-- handle left/right image display for top item --%>
          <%-- display title --%>
          <c:if test="${trailers.showTitleColumn != 'none'}">
            <h3>
              <a href="${articleAttributeMap.url}" class="${articleAttributeMap.inpageTitleClass}">
                <c:out value="${articleAttributeMap.title}" escapeXml="false"/>
              </a>
            </h3>
          </c:if>

          <p class="summary">
            <!-- display image -->
            <c:if test="${trailers.showImageColumn != 'none' and not empty teaserImageArticle}">
              <c:choose>
                <c:when test="${trailers.softCrop}">
                  <c:set var="inpageImageClass" value="${teaserImageArticle.fields.alternates.value[imageVersion].inpageClasses}"/>
                  <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                       alt="${teaserImageMap.alttext}"
                       title="${teaserImageMap.caption}"
                       class="${trailers.imagePositionColumn} ${inpageImageClass}"
                       onclick="location.href='${articleAttributeMap.url}'"
                       width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                       height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"/>
                </c:when>
                <c:otherwise>
                  <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                       alt="${teaserImageMap.alttext}"
                       title="${teaserImageMap.caption}"
                       onclick="location.href='${articleAttributeMap.url}'"
                       class="${trailers.imagePositionColumn}"/>
                </c:otherwise>
              </c:choose>
            </c:if>
            <!-- display summary-->
            <c:if test="${trailers.showIntroColumn != 'none'}">
              <span class="${articleAttributeMap.inpageLeadtextClass}">
                <c:out value="${articleAttributeMap.intro}" escapeXml="true"/>
              </span>
            </c:if>
          </p>
        </c:otherwise>
      </c:choose>
      <c:if test="${trailers.showComments}">
        <p class="comments">
          <a href="${articleAttributeMap.url}#commentsList"><c:out value="${articleAttributeMap.numOfComments}" escapeXml="true"/> comments</a>
        </p>
      </c:if>
    </div>
  </c:when>
  <c:otherwise>
    <%-- handle the rendering of later articles --%>
    <div class="article ${articleAttributeMap.articleStyleClass}">
      <c:choose>
        <c:when test="${trailers.imagePositionColumn eq 'top'}">
          <%-- handle top image display for later items--%>
          <%-- show image--%>
          <c:if test="${trailers.showImageColumn == 'all' and not empty teaserImageArticle}">
            <c:choose>
              <c:when test="${trailers.softCrop}">
                <c:set var="inpageImageClass" value="${teaserImageArticle.fields.alternates.value[imageVersion].inpageClasses}"/>
                <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                     alt="${teaserImageMap.alttext}"
                     class="${inpageImageClass}"
                     onclick="location.href='${articleAttributeMap.url}'"
                     title="${teaserImageMap.caption}"
                     width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                     height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"/>
              </c:when>
              <c:otherwise>
                <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                     alt="${teaserImageMap.alttext}"
                     onclick="location.href='${articleAttributeMap.url}'"
                     title="${teaserImageMap.caption}"/>
              </c:otherwise>
            </c:choose>
          </c:if>

          <%-- show title --%>
          <c:if test="${trailers.showTitleColumn == 'all'}">
            <h4>
              <a href="${articleAttributeMap.url}" class="${articleAttributeMap.inpageTitleClass}">
                <c:out value="${articleAttributeMap.title}" escapeXml="false"/>
              </a>
            </h4>
          </c:if>

          <%-- show intro --%>
          <c:if test="${trailers.showIntroColumn == 'all'}">
            <p class="summary ${articleAttributeMap.inpageLeadtextClass}">
              <c:out value="${articleAttributeMap.intro}" escapeXml="true"/>
            </p>
          </c:if>
        </c:when>
        <c:otherwise>
          <%--handle left/right image display for later items --%>
          <%-- display title --%>
          <c:if test="${trailers.showTitleColumn == 'all'}">
            <h4>
              <a href="${articleAttributeMap.url}" class="${articleAttributeMap.inpageTitleClass}">
                <c:out value="${articleAttributeMap.title}" escapeXml="false"/>
              </a>
            </h4>
          </c:if>

          <p class="summary">
            <%-- display image --%>
            <c:if test="${trailers.showImageColumn == 'all' and not empty teaserImageArticle}">
              <c:choose>
                <c:when test="${trailers.softCrop}">
                  <c:set var="inpageImageClass" value="${teaserImageArticle.fields.alternates.value[imageVersion].inpageClasses}"/>
                  <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                       alt="${teaserImageMap.alttext}"
                       title="${teaserImageMap.caption}"
                       class="${trailers.imagePositionColumn} ${inpageImageClass}"
                       width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                       height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"
                       onclick="location.href='${articleAttributeMap.url}'" />
                </c:when>
                <c:otherwise>
                  <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                       alt="${teaserImageMap.alttext}"
                       title="${teaserImageMap.caption}"
                       onclick="location.href='${articleAttributeMap.url}'"
                       class="${trailers.imagePositionColumn}"/>
                </c:otherwise>
              </c:choose>
            </c:if>
            <%-- display summary--%>
            <c:if test="${trailers.showIntroColumn == 'all'}">
              <span class="${articleAttributeMap.inpageLeadtextClass}">
                <c:out value="${articleAttributeMap.intro}" escapeXml="true"/>
              </span>
            </c:if>
          </p>
        </c:otherwise>
      </c:choose>
      <c:if test="${trailers.showComments}">
        <p class="comments">
          <a href="${articleAttributeMap.url}#commentsList"><c:out value="${articleAttributeMap.numOfComments}" escapeXml="true"/> comments</a>
        </p>
      </c:if>
    </div>
  </c:otherwise>
</c:choose>