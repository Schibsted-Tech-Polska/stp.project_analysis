<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/helpers/slideshow.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- The purpose of this page is to display slideshow of teaser images of a story --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- The page requires the following attributes in the requestScope --%>
<jsp:useBean id="stories" type="java.util.HashMap" scope="request" />
<jsp:useBean id="teaserImageMapList" type="java.util.ArrayList" scope="request"/>
<jsp:useBean id="storyArticle" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>

<c:set var="slideshowDivId" value="stories${widgetContent.id}-story${storyArticle.id}-slideshow"/>
<fmt:message var="slideshowPrevButtonTitle" key="slideshow.widget.previous.button.title"/>
<fmt:message var="slideshowNextButtonTitle" key="slideshow.widget.next.button.title"/>

<c:set var="slideshowAutoplay" value="${false}" />
<c:set var="slideshowSlideDuration" value="3" />

<c:set var="slideshowImageArray" value=""/>

<c:forEach var="teaserImageMap" items="${teaserImageMapList}" varStatus="loopStatus">
  <c:set var="imageLink" value="${teaserImageMap.url}" />
  <c:set var="imageCaption" value="${teaserImageMap.caption}" />
  <c:set var="imageCredits" value="" />

  <c:choose>
    <c:when test="${not empty imageCredits}">
      <c:set var="imageInfo" value="${imageCaption}<br/>${imageCredits}" />
    </c:when>
    <c:otherwise>
      <c:set var="imageInfo" value="${imageCaption}" />
    </c:otherwise>
  </c:choose>

  <c:if test="${loopStatus.first}">
    <c:set var="slideshowWidth" value="${teaserImageMap.width}"/>
    <c:set var="slideshowHeight" value="${teaserImageMap.height}"/>

    <c:choose>
      <c:when test="${slideshowWidth > 350}">
        <c:set var="slideshowInfoStyleClass" value="info" />
        <c:set var="slideshowPrevButtonUrl" value="${skinUrl}gfx/stories/left.png" />
        <c:set var="slideshowNextButtonUrl" value="${skinUrl}gfx/stories/right.png" />
        <c:set var="slideshowNavStatusText">
          <fmt:message key="slideshow.widget.navigation.status.text"/>
        </c:set>
      </c:when>
      <c:otherwise>
        <c:set var="slideshowInfoStyleClass" value="info miniInfo" />
        <c:set var="slideshowPrevButtonUrl" value="${skinUrl}gfx/stories/left-small.png" />
        <c:set var="slideshowNextButtonUrl" value="${skinUrl}gfx/stories/right-small.png" />
        <c:set var="slideshowNavStatusText">
          <fmt:message key="slideshow.widget.navigation.mini.status.text" />
        </c:set>
      </c:otherwise>
    </c:choose>
  </c:if>

  <c:choose>
    <c:when test="${empty slideshowImageArray}">
      <c:set var="slideshowImageArray"
             value="['${imageLink}', '${imageLink}', '_blank', '${imageInfo}']"/>
    </c:when>
    <c:otherwise>
      <c:set var="slideshowImageArray"
             value="${slideshowImageArray},['${imageLink}', '${imageLink}', '_blank', '${imageInfo}']"/>
    </c:otherwise>
  </c:choose>

  <c:remove var="imageLink" scope="page" />
  <c:remove var="imageCaption" scope="page" />
  <c:remove var="imageCredits" scope="page" />
  <c:remove var="imageInfo" scope="page" />
</c:forEach>

<script type="text/javascript" src="${requestScope.resourceUrl}js/simple.gallery.js"></script>

<script type="text/javascript">
  // <![CDATA[
  var mygallery = new simpleGallery({
    wrapperid: "${slideshowDivId}",
    dimensions: [${slideshowWidth}, ${slideshowHeight}],
    imagearray: [${slideshowImageArray}],
    autoplay: [${slideshowAutoplay}, ${slideshowSlideDuration}000, 2],
    persist: false,
    fadeduration: 500,
    shownav:true,

    /* custom configurations */
    slideNav: true,
    navStatusText: " ${slideshowNavStatusText} ",
    prevButtonUrl: "${slideshowPrevButtonUrl}",
    nextButtonUrl: "${slideshowNextButtonUrl}",
    prevButtonTitle:"${slideshowPrevButtonTitle}",
    nextButtonTitle:"${slideshowNextButtonTitle}",
    infoStyleClass: "${slideshowInfoStyleClass}",


    oninit:function() { },
    onslide:function(curslide, i) { }
  });
  // ]]>
</script>

<div id="${slideshowDivId}" class="slideshow">&nbsp;</div>

