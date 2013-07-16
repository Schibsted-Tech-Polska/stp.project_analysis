<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-stories/src/main/webapp/template/widgets/stories/view/helpers/picture.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- The purpose of this page is to display teaser picture of a story --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- The requires the following attributes in the requestScope --%>
<jsp:useBean id="stories" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="teaserImageMap" type="java.util.HashMap" scope="request" />
<jsp:useBean id="storyUrl" type="java.lang.String" scope="request"/>

<c:set var="picture" value="${teaserImageMap.imageArticle}"/>
<c:set var="imageVersion" value="${stories.imageVersion}" />

<c:choose>
  <c:when test="${stories.softCrop}">
    <img src="${picture.fields.alternates.value[imageVersion].href}"
         class="${stories.imagePosition} ${picture.fields.alternates.value[imageVersion].inpageClasses}"
         alt="${teaserImageMap.alttext}"
         title="${teaserImageMap.caption}"
         width="${picture.fields.alternates.value[imageVersion].width}"
         height="${picture.fields.alternates.value[imageVersion].height}"
         onclick="location.href='${storyUrl}';"/>
  </c:when>
  <c:otherwise>
    <img src="${picture.fields.binary.value[imageVersion]}"
         class="${stories.imagePosition}"
         alt="${teaserImageMap.alttext}"
         title="${teaserImageMap.caption}"
         onclick="location.href='${storyUrl}';" />
  </c:otherwise>
</c:choose>
