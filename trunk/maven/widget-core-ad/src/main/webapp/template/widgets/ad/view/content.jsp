<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-ad/src/main/webapp/template/widgets/ad/view/content.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%--declare the map that will contain relevant field values--%>
<jsp:useBean id="ad" type="java.util.Map" scope="request"/>

<%-- render html --%>
<c:if test="${not empty widgetContent.relatedElements.images.items}">
  <c:set var="adPicture" value="${widgetContent.relatedElements.images.items[0]}"/>
  <c:if test="${fn:trim(adPicture.content.articleTypeName eq 'picture')}">
     <div class="${ad.wrapperStyleClass}" <c:if test="${not empty ad.styleId}">id="${ad.styleId}"</c:if>>
      <a href="${ad.url}" onclick="return openLink(this.href,'${ad.target}')">
        <img src="${adPicture.content.fields.binary.value.href}" alt="${ad.linkTitle}" width="${ad.width}"
             height="${ad.height}"
             title="${ad.linkTitle}"/>
      </a>
    </div>
  </c:if>
</c:if>

<c:remove var="ad" scope="request"/>


