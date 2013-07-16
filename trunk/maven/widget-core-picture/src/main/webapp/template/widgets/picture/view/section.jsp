<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/view/section.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this page renders the default view of the picture widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.HashMap" scope="request" />

<c:if test="${not empty picture.items}">
    <div class="${picture.wrapperStyleClass}" <c:if test="${not empty picture.styleId}">id="${picture.styleId}"</c:if>>
    <c:if test="${picture.showWidgetName=='true'}">
      <div class="header">
        <h5>
          <c:out value="${picture.widgetName}" escapeXml="true"/>
        </h5>
      </div>
    </c:if>

    <c:set var="animation" value="${picture.animation}"/>
    <c:set var="captifyClassName" value="captify-picture-section"/>

    <c:forEach var="pictureItem" items="${picture.items}">
      <div class="pictureContainer">
        <c:set var="imageVersion" value="${picture.imageVersion}" />
        <c:set var="showCaption" value="${not empty fn:trim(pictureItem.fields.caption.value)}" />
        <c:set var="showCredits" value="${not empty fn:trim(pictureItem.content.fields.photographer.value)}" />
        <c:set var="showPictureInfo" value="${showCaption or showCredits}"/>
        <c:set var="pictureInfoDivId" value="widgetContent${widgetContent.id}-picture${pictureItem.content.id}-info"/>

        <c:choose>
          <c:when test="${picture.softCrop}">
            <c:choose>
              <c:when test="${showPictureInfo}">
                <c:set var="imageStyleClass" value="${captifyClassName}"/>
              </c:when>
              <c:otherwise>
                <c:set var="imageStyleClass" value=""/>
              </c:otherwise>
            </c:choose>
            <a href="${pictureItem.content.url}">
              <img src="${pictureItem.content.fields.alternates.value[imageVersion].href}"
                   width="${pictureItem.content.fields.alternates.value[imageVersion].width}"
                   height="${pictureItem.content.fields.alternates.value[imageVersion].height}"
                   alt="${pictureItem.content.fields.alttext}"
                   title="${pictureItem.fields.caption}"
                   class="${imageStyleClass}"
                   <c:if test="${showPictureInfo}">rel="${pictureInfoDivId}"</c:if> />
            </a>
          </c:when>
          <c:otherwise>
            <a href="${pictureItem.content.url}">
              <img src="${pictureItem.content.fields.binary.value[imageVersion]}"
                   alt="${pictureItem.content.fields.alttext}"
                   title="${pictureItem.fields.caption}"
                   <c:if test="${showPictureInfo}">rel="${pictureInfoDivId}" class="${captifyClassName}"</c:if> />
            </a>
          </c:otherwise>
        </c:choose>

        <c:if test="${showPictureInfo}">
          <div id="${pictureInfoDivId}" style="display:none;">
            <c:if test="${showCaption}">
              <p class=""><c:out value="${fn:trim(pictureItem.fields.caption.value)}" escapeXml="true"/></p>
            </c:if>
            
            <c:if test="${showCredits}">
              <div class="credits">
                <c:out value="${fn:trim(pictureItem.content.fields.photographer.value)}" escapeXml="true"/>
              </div>
            </c:if>
          </div>
        </c:if>
      </div>
    </c:forEach>
  </div>
  <script type="text/javascript">
    // <![CDATA[
    $(document).ready(
        function() {
          $('img.captify-picture-section').captify({animation:'${animation}'});
        }
     );
    // ]]>
  </script>
</c:if>
