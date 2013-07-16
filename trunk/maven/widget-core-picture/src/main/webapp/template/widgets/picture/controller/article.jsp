<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/controller/article.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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

<%-- the general controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.HashMap" scope="request" />

<%-- put the values of view specific fields / properties in the map --%>
<c:set target="${picture}" property="selectedFields" value="${widgetContent.fields.pictureFields.value}"/>

<c:if test="${requestScope['com.escenic.context'] == 'art'}">
  <c:set target="${picture}" property="validPictureContent" value="${true}" />

  <c:forEach var="currentField" items="${picture.selectedFields}">
    <c:choose>
      <c:when test="${currentField == 'caption'}">
        <wf-core:handleLineBreaks var="captionFieldValue" value="${fn:trim(article.fields.caption)}"/>
        <c:set target="${picture}" property="caption" value="${requestScope.captionFieldValue}" />
        <c:set target="${picture}" property="inpageCaptionClass" value=""/>
        <c:remove var="captionFieldValue" scope="request"/>
      </c:when>

      <c:when test="${currentField == 'picture'}">
        <c:set var="imageVersion" value="${picture.imageVersion}" />
        <c:set target="${picture}" property="imageId" value="picture${article.id}" />

        <c:choose>
          <c:when test="${picture.softCrop}">
            <c:if test="${not empty article.fields.alternates}">
              <c:set target="${picture}" property="imageUrl" value="${article.fields.alternates.value[imageVersion].href}" />
              <c:set target="${picture}" property="imageWidth" value="${article.fields.alternates.value[imageVersion].width}" />
              <c:set target="${picture}" property="imageHeight" value="${article.fields.alternates.value[imageVersion].height}" />
              <c:set target="${picture}" property="inpageImageClass" value=""/>
            </c:if>
          </c:when>
          <c:otherwise>
            <c:if test="${not empty article.fields.binary}">
              <c:set target="${picture}" property="imageUrl" value="${article.fields.binary.value[imageVersion]}" />
            </c:if>
          </c:otherwise>
        </c:choose>

        <c:set target="${picture}" property="imageAlttext" value="${article.fields.alttext}" />
        <c:set target="${picture}" property="imageTitle" value="${article.fields.caption}" />
      </c:when>

      <c:when test="${currentField == 'byline'}">
        <c:set target="${picture}" property="byline" value="${article.author.name}"/>
      </c:when>

      <c:when test="${currentField == 'dateline'}">
        <c:set var="dateFormat" value="${fn:trim(widgetContent.fields.dateFormat.value)}" />
        <c:if test="${empty dateFormat}">
          <c:set var="dateFormat" value="MMMM dd yyyy HH:mm" />
        </c:if>

        <c:set target="${picture}" property="dateFormat" value="${dateFormat}" />

        <c:set target="${picture}" property="publishedDate">
          <fmt:formatDate value="${article.publishedDateAsDate}" pattern="${picture.dateFormat}"/>
        </c:set>
        <c:set target="${picture}" property="lastModifiedDate">
          <fmt:formatDate value="${article.lastModifiedDateAsDate}" pattern="${picture.dateFormat}"/>
        </c:set>
      </c:when>

      <c:when test="${currentField == 'credits'}">
        <c:set target="${picture}" property="credits" value="${fn:trim(article.fields.photographer.value)}"/>
        <c:set target="${picture}" property="inpagePhotographerClass" value=""/>
      </c:when>

      <c:when test="${currentField == 'description'}">
        <c:set target="${picture}" property="description" value="${fn:trim(article.fields.description.value)}"/>
        <c:set target="${picture}" property="inpageDescriptionClass" value=""/>
      </c:when>

      <c:when test="${currentField == 'metadata'}">
        <c:set target="${picture}" property="metadata" value="${article.fields['com.escenic.defaultmetadata'].value}"/>
      </c:when>

    </c:choose>
  </c:forEach>
</c:if>

