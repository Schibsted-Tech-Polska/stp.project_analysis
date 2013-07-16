<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/pictures.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%-- this is the pictures view of list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'list' in the requestScope --%>
<jsp:useBean id="list" type="java.util.HashMap" scope="request" />

<div class="${list.wrapperStyleClass} ${list.inpageDnDAreaClass}" <c:if test="${not empty list.styleId}">id="${list.styleId}"</c:if>>
  <%-- show the header conditionally --%>
  <c:if test="${requestScope.tabbingEnabled!='true' and not empty list.picturesList}">
    <div class="header">
      <h5><c:out value="${requestScope.element.fields.title}" escapeXml="true"/></h5>
    </div>
  </c:if>

  <c:if test="${not empty list.picturesList}">
    <div class="content">
      <c:set var="captifyStyleClass" value="captify-list-pictures-${widgetContent.id}"/>
      <c:forEach var="pictureMap" items="${list.picturesList}" varStatus="status">
        <c:set var="pictureCaption" value="${not empty pictureMap.caption ? pictureMap.caption : pictureMap.title}" />
        <c:set var="inpageCaptionClass" value="${not empty pictureMap.caption ? pictureMap.inpageCaptionClass : pictureMap.inpageTitleClass}"/>
        <c:set var="showCaption" value="${list.showCaption and not empty pictureCaption}"/>
        <c:set var="showCredits" value="${list.showCredits and not empty pictureMap.photographer}"/>
        <c:set var="showCaptionOverPicture" value="${showCaption and (list.captionStylePictures == 'overAnimated' or list.captionStylePictures == 'overNonAnimated')}"/>
        <%--<c:set var="showInfoOverPicture" value="${showCaptionOverPicture or showCredits}"/>--%>
        <c:set var="showInfoOverPicture" value="${false}"/>
        <c:set var="pictureInfoDivId" value="widgetContent${widgetContent.id}-picture${pictureMap.articleId}-info"/>

        <c:if test="${list.showCaption}">
          <c:set var="styleClassForCaption" value="title" />
        </c:if>

        <c:if test="${list.showCredits}">
          <c:set var="styleClassForCredits" value="credits" />
        </c:if>

        <div class="listPicture ${pictureMap.inpageDnDSummaryClass}">
          <c:if test="${list.showCaption and list.captionStylePictures == 'above'}">
            <p class="title" style="width:${pictureMap.width}px;">
              <a href="${pictureMap.articleUrl}" class="${inpageCaptionClass}">${pictureCaption}</a>
            </p>
          </c:if>

          <a href="${pictureMap.articleUrl}">
            <img src="${pictureMap.imageUrl}"
                 alt="${pictureMap.alttext}"
                 title="${pictureCaption}"
                 width="${pictureMap.width}"
                 height="${pictureMap.height}"
                 class="${pictureMap.inpageImageClass}"
                 <c:if test="${showInfoOverPicture}">rel="${pictureInfoDivId}" class="${captifyStyleClass}"</c:if> />
          </a>

          <%--<c:if test="${showCaption and list.captionStylePictures == 'below'}">
            <p class="title" style="width:${pictureMap.width}px;"><a href="${pictureMap.articleUrl}">${pictureCaption}</a></p>
          </c:if>--%>

          <!-- caption and description both should be inside a div so that its height can be specified -->
          <c:if test="${(list.showCaption and list.captionStylePictures == 'below') or list.showCredits=='true'}">
            <div class="info ${styleClassForCaption} ${styleClassForCredits}" style="width:${pictureMap.width}px;">
              <c:if test="${list.showCaption and list.captionStylePictures == 'below'}">
                <p class="title">
                  <a href="${pictureMap.articleUrl}" class="${inpageCaptionClass}">${pictureCaption}</a>
                </p>
              </c:if>
              <c:if test="${list.showCredits=='true' and not empty pictureMap.photographer}">
                <%-- todo decide if picture credits should be editable too --%>
                <div class="credits">
                  <c:if test="${not empty list.pictureCreditsPrefix}">
                    <c:out value="${list.pictureCreditsPrefix}" escapeXml="true"/>
                  </c:if>
                  ${pictureMap.photographer}
                </div>
              </c:if>
            </div>
          </c:if>


          <%--<c:if test="${showInfoOverPicture}">
            <div id="${pictureInfoDivId}" style="display:none;">
              <c:if test="${showCaptionOverPicture}">
                <p>${pictureCaption}</p>
              </c:if>

              <c:if test="${showCredits}">
                <div class="credits">
                  <c:if test="${not empty list.pictureCreditsPrefix}">
                    <c:out value="${list.pictureCreditsPrefix}" />
                  </c:if>
                  ${pictureMap.photographer}
                </div>
              </c:if>
            </div>
          </c:if>--%>
        </div>
      </c:forEach>

      <script type="text/javascript">
        // <![CDATA[
        <c:choose>
          <c:when test="${list.captionStylePictures == 'overNonAnimated'}">
              <c:set var="captifyAnimation" value="always-on" />
          </c:when>
          <c:otherwise>
            <c:set var="captifyAnimation" value="slide" />
          </c:otherwise>
        </c:choose>
        $(document).ready(function() {
          $('img.${captifyStyleClass}').captify({
            //animation:'${list.pictureAnimation}'  // slide
            animation:'${captifyAnimation}'
          });
        });
        // ]]>
      </script>
    </div>
  </c:if>
</div>

<c:remove var="list" scope="request"/>

