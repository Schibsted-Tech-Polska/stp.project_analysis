<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/helpers/topPicture.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to display top picture of a story with/without caption  always / mouse hover --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- The page requires the following attributes in the requestScope --%>
<jsp:useBean id="stories" type="java.util.HashMap" scope="request" />
<jsp:useBean id="teaserImageMap" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="storyArticle" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>

<c:set var="picture" value="${teaserImageMap.imageArticle}"/>
<c:set var="imageVersion" value="${stories.imageVersion}" />

<c:set var="pictureDivId" value="widget${widgetContent.id}-story${storyArticle.id}-picture${picture.id}" />
<c:set var="pictureInfoDivId" value="${pictureDivId}-info"/>
<c:set var="pictureStyleClass" value="stories-${stories.view}-topPicture"/>
<c:set var="inpageStyleClass" value="${picture.fields.alternates.value[imageVersion].inpageClasses}"/>

<c:set var="showPictureCaption" value="${stories.showCaption!='hide' and not empty teaserImageMap.caption}"/>

<c:choose>
  <c:when test="${showPictureCaption}">
    <c:set var="combinedStyleClass" value="${pictureStyleClass} ${inpageStyleClass}"/>
  </c:when>
  <c:otherwise>
    <c:set var="combinedStyleClass" value="${inpageStyleClass}"/>
  </c:otherwise>
</c:choose>

<div id="${pictureDivId}">
  <c:choose>
    <c:when test="${stories.softCrop}">
      <img src="${picture.fields.alternates.value[imageVersion].href}"
           alt="${teaserImageMap.alttext}"
           title="${teaserImageMap.caption}"
           width="${picture.fields.alternates.value[imageVersion].width}"
           height="${picture.fields.alternates.value[imageVersion].height}"
           onclick="location.href='${storyArticle.url}';"
           <c:if test="${showPictureCaption}">rel="${pictureInfoDivId}"</c:if>
           class="${combinedStyleClass}"/>
    </c:when>
    <c:otherwise>
      <img src="${picture.fields.binary.value[imageVersion]}"
           alt="${teaserImageMap.alttext}"
           title="${teaserImageMap.caption}"
           onclick="location.href='${storyArticle.url}';"
           <c:if test="${showPictureCaption}">rel="${pictureInfoDivId}" class="${pictureStyleClass}"</c:if> />
    </c:otherwise>
  </c:choose>

  <c:if test="${showPictureCaption}">
    <div id="${pictureInfoDivId}" style="display:none;">
      <p><c:out value="${teaserImageMap.caption}" escapeXml="true"/></p>
    </div>
  </c:if>
</div>

<c:if test="${showPictureCaption}">
  <c:set var="pictureInfoAnimation" value="${stories.showCaption=='always' ? 'always-on' : 'slide'}" />

  <script type="text/javascript">
    // <![CDATA[
    $(document).ready(
        function() {
          $('img.${pictureStyleClass}').captify({
            animation:'${pictureInfoAnimation}'
          });
        }
    );
    // ]]>
  </script>
</c:if>



