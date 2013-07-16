<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-slideshow/src/main/webapp/template/widgets/slideshow/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--This page generates the default HTML markup for the slideshow widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="slideshow" type="java.util.Map" scope="request"/>

<!--read view specific fields-->
<c:set target="${slideshow}" property="maxPictures" value="${fn:trim(widgetContent.fields.maxPictures.value)}"/>
<c:set target="${slideshow}" property="autoplay" value="${fn:trim(widgetContent.fields.autoplay.value)}"/>
<c:set target="${slideshow}" property="slideDuration" value="${fn:trim(widgetContent.fields.slideDuration.value)}"/>
<c:set target="${slideshow}" property="slideNav" value="${fn:trim(widgetContent.fields.slideNav.value)}"/>
<c:if test="${empty slideshow.slideNav}">
  <c:set target="${slideshow}" property="slideNav" value="${true}" />
</c:if>

<c:choose>
  <c:when test="${slideshow.source=='desked' and not empty slideshow.groupName}">
    <c:choose>
      <c:when test="${slideshow.sectionUniqueName == section.uniqueName}">
        <wf-core:getGroupByName var="targetGroup"
                                  groupName="${slideshow.groupName}"
                                  areaName="${requestScope.contentAreaName}"/>
      </c:when>
      <c:otherwise>
        <section:use uniqueName="${slideshow.sectionUniqueName}">
          <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
        </section:use>

        <wf-core:getGroupByName var="targetGroup"
                                  groupName="${slideshow.groupName}"
                                  areaName="${requestScope.contentAreaName}"
                                  pool="${targetSectionPool}"/>
        <c:remove var="targetSectionPool" scope="request"/>
      </c:otherwise>
    </c:choose>

    <wf-core:getPicturesInGroup var="slideshowPictures" group="${targetGroup}"
                                  contentType="${slideshow.pictureArticleTypeName}"
                                  max="${slideshow.maxPictures}"
                                  includeArticleRelatedPictures="${true}"/>

    <c:set target="${slideshow}" property="slideshowPictures" value="${requestScope.slideshowPictures}"/>

    <c:remove var="targetGroup" scope="request"/>
    <c:remove var="slideshowPictures" scope="request"/>
  </c:when>

  <c:when test="${slideshow.source=='related' and
                  requestScope['com.escenic.context'] == 'art' and
                  not empty article.relatedElements.pictureRel.items}">
    
    <collection:createList id="slideshowPictures" type="java.util.ArrayList" toScope="page"/>

    <c:choose>
      <c:when test="${not empty slideshow.maxPictures}">
        <c:set var="counter" value="0"/>
        <c:forEach var="pictureRelItem" items="${article.relatedElements.pictureRel.items}">
          <c:if
              test="${pictureRelItem.content.articleTypeName == slideshow.pictureArticleTypeName and (counter+0) < (slideshow.maxPictures+0)}">
            <collection:add collection="${slideshowPictures}" value="${pictureRelItem}"/>
            <c:set var="counter" value="${counter+1}"/>
          </c:if>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <c:forEach var="pictureRelItem" items="${article.relatedElements.pictureRel.items}">
          <c:if test="${pictureRelItem.content.articleTypeName == slideshow.pictureArticleTypeName}">
            <collection:add collection="${slideshowPictures}" value="${pictureRelItem}"/>
          </c:if>
        </c:forEach>
      </c:otherwise>
    </c:choose>

    <c:set target="${slideshow}" property="slideshowPictures" value="${slideshowPictures}"/>
  </c:when>
</c:choose>

<c:choose>
  <c:when test="${fn:length(slideshow.slideshowPictures) == 1}">
    <jsp:include page="helpers/pictureAttributes.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="helpers/galleryAttributes.jsp"/>
  </c:otherwise>
</c:choose>