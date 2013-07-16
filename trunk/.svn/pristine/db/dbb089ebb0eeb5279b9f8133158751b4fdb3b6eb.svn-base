<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-slideshow/src/main/webapp/template/widgets/slideshow/view/helpers/picture.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="slideshow" type="java.util.Map" scope="request" />
<c:set var="picture" value="${slideshow.slideshowPictures[0]}"/>
<c:set var="imageRepresentation" value="${slideshow.imageRepresentation}"/>
<c:set var="showCaption" value="${not empty slideshow.pictureCaption}"/>
<c:set var="showCredits" value="${not empty slideshow.pictureCredits}"/>
<c:set var="showPictureInfo" value="${showCaption or showCredits}"/>
<c:set var="pictureInfoDivId" value="widgetContent${widgetContent.id}-picture${picture.content.id}-info"/>
<c:set var="pictureStyleClass" value="captify-slideshow"/>

<div id="${slideshow.pictureId}">
  <c:choose>
    <c:when test="${showPictureInfo}">
      <c:set var="imageClass" value="${pictureStyleClass} ${picture.content.fields.alternates.value[imageRepresentation].inpageClasses}"/>
    </c:when>
    <c:otherwise>
      <c:set var="imageClass" value="${picture.content.fields.alternates.value[imageRepresentation].inpageClasses}"/>
    </c:otherwise>
  </c:choose>
  <img src="${picture.content.fields.alternates.value[imageRepresentation].href}"
       class="${imageClass}"
       alt="${picture.content.fields.alttext}"
       title="${picture.content.fields.caption}"
       width="${picture.content.fields.alternates.value[imageRepresentation].width}"
       height="${picture.content.fields.alternates.value[imageRepresentation].height}"
       <c:if test="${showPictureInfo}">rel="${pictureInfoDivId}"</c:if> />

  <c:if test="${showPictureInfo}">
    <div id="${pictureInfoDivId}" style="display:none;">
      <c:if test="${showCaption}">
        <p><c:out value="${slideshow.pictureCaption}" escapeXml="true"/></p>
      </c:if>

      <c:if test="${showCredits}">
        <div class="credits"><c:out value="${slideshow.pictureCredits}" escapeXml="true"/></div>
      </c:if>
    </div>
  </c:if>
</div>
<script type="text/javascript">
  // <![CDATA[
  $(document).ready(
      function() {
        $('img.captify-slideshow').captify({animation:'always-on'});
      }
  );
  // ]]>
</script>