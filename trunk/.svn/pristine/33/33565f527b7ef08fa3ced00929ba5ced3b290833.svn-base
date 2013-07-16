<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/view/article.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.Map" scope="request"/>

<%-- render the chosen fields--%>
<c:if test="${picture.validPictureContent and not empty picture.selectedFields}">
    <div class="${picture.wrapperStyleClass}" <c:if test="${not empty picture.styleId}">id="${picture.styleId}"</c:if>>
    <c:forEach var="currentField" items="${picture.selectedFields}">
      <c:choose>
        <c:when test="${currentField == 'caption'}">
          <c:if test="${not empty picture.caption}">
            <h1 class="${picture.inpageCaptionClass}"><c:out value="${picture.caption}" escapeXml="false"/> </h1>
          </c:if>
        </c:when>

        <c:when test="${currentField == 'picture'}">
          <c:set var="animation" value="${picture.animation}"/>
          <c:set var="captifyClassName" value="captify-picture-article"/>
          <c:set var="showCaption" value="${not empty picture.caption}" />
          <c:set var="showCredits" value="${not empty picture.credits}"/>
          <c:set var="showPictureInfo" value="${showCaption or showCredits}"/>
          <c:set var="pictureInfoDivId" value="widgetContent${widgetContent.id}-picture${picture.imageId}-info"/>

          <div class="pictureContainer">
            <c:choose>
              <c:when test="${picture.softCrop}">
                <c:choose>
                  <c:when test="${showPictureInfo}">
                    <c:set var="imageStyleClass" value="${captifyClassName} ${picture.inpageImageClass}"/>
                  </c:when>
                  <c:otherwise>
                    <c:set var="imageStyleClass" value="${picture.inpageImageClass}"/>
                  </c:otherwise>
                </c:choose>
                <img src="${picture.imageUrl}"
                     width="${picture.imageWidth}"
                     height="${picture.imageHeight}"
                     alt="${picture.imageAlttext}"
                     title="${picture.imageTitle}"
                     class="${imageStyleClass}"
                     <c:if test="${showPictureInfo}">rel="${pictureInfoDivId}"</c:if> />
              </c:when>
              <c:otherwise>
                <img src="${picture.imageUrl}"
                     alt="${picture.imageAlttext}"
                     title="${picture.imageTitle}"
                     <c:if test="${showPictureInfo}">rel="${pictureInfoDivId}" class="${captifyClassName}"</c:if> />
              </c:otherwise>
            </c:choose>

            <c:if test="${showPictureInfo}">
              <div id="${pictureInfoDivId}" style="display:none;">
                <c:if test="${showCaption}">
                  <p class="${picture.inpageCaptionClass}"><c:out value="${picture.caption}" escapeXml="true"/> </p>
                </c:if>

                <c:if test="${showCredits}">
                  <div class="credits"><c:out value="${picture.credits}" escapeXml="true"/></div>
                </c:if>
              </div>
            </c:if>
          </div>

          <script type="text/javascript">
            // <![CDATA[
            $(document).ready(
                function() {
                  $('img.captify-picture-article').captify({animation:'${animation}'});
                }
            );
            // ]]>
          </script>
        </c:when>

        <c:when test="${currentField == 'byline'}">
          <p class="byline">
            <fmt:message key="article.byline.label" />
            <span class="authorName"><c:out value="${picture.byline}" escapeXml="true"/> </span>
          </p>
        </c:when>

        <c:when test="${currentField == 'dateline'}">
          <p class="dateline">
            <span class="label">
              <fmt:message key="article.dateline.published.label"/>
            </span>
            <c:out value="${picture.publishedDate}" escapeXml="true"/>

            &nbsp;
            
            <span class="label">
              <fmt:message key="article.dateline.updated.label"/>
            </span>
            <c:out value="${picture.lastModifiedDate}" escapeXml="true"/>
          </p>
        </c:when>

        <c:when test="${currentField == 'credits'}">
          <c:if test="${not empty picture.credits}">
            <div class="credits">
              <h3><fmt:message key="picture.widget.article.credits.headline" /></h3>
              <div class="${picture.inpagePhotographerClass}"><c:out value="${picture.credits}" escapeXml="true"/></div>
            </div>
          </c:if>
        </c:when>

        <c:when test="${currentField == 'description'}">
          <c:if test="${not empty picture.description}">
            <div class="description">
              <h3><fmt:message key="picture.widget.article.description.headline" /></h3>
              <div class="${picture.inpageDescriptionClass}"><c:out value="${picture.description}" escapeXml="true"/></div>
            </div>
          </c:if>
        </c:when>

        <c:when test="${currentField == 'metadata'}">
          <c:if test="${not empty picture.metadata and fn:length(picture.metadata) > 0}">
            <div class="metadata">
              <h3><fmt:message key="picture.widget.article.metadata.headline" /></h3>
              <jsp:include page="helpers/metadata.jsp" />
            </div>
          </c:if>
        </c:when>

      </c:choose>
    </c:forEach>
  </div>
</c:if>

<c:remove var="picture" scope="request"/>