<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileSlideshow/src/main/webapp/template/widgets/mobileSlideshow/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--This page generates the default HTML markup for the mobileSlideshow widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="mobileSlideshow" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${mobileSlideshow.source=='desked' and not empty mobileSlideshow.groupName}">
    <c:choose>
      <c:when test="${mobileSlideshow.sectionUniqueName == section.uniqueName}">
        <wf-core:getGroupByName var="targetGroup"
                                  groupName="${mobileSlideshow.groupName}"
                                  areaName="${requestScope.contentAreaName}"/>
      </c:when>
      <c:otherwise>
        <section:use uniqueName="${mobileSlideshow.sectionUniqueName}">
          <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
        </section:use>

        <wf-core:getGroupByName var="targetGroup"
                                  groupName="${mobileSlideshow.groupName}"
                                  areaName="${requestScope.contentAreaName}"
                                  pool="${targetSectionPool}"/>
        <c:remove var="targetSectionPool" scope="request"/>
      </c:otherwise>
    </c:choose>


    <wf-core:getPicturesInGroup var="mobileSlideshowPictures" group="${targetGroup}"
                                  contentType="${mobileSlideshow.pictureArticleTypeName}"
                                  max="${mobileSlideshow.maxPictures}"
                                  includeArticleRelatedPictures="${true}"/>

    <c:set target="${mobileSlideshow}" property="mobileSlideshowPictures" value="${requestScope.mobileSlideshowPictures}"/>

    <c:remove var="targetGroup" scope="request"/>
    <c:remove var="mobileSlideshowPictures" scope="request"/>
  </c:when>

  <c:when test="${mobileSlideshow.source=='related' and
                  requestScope['com.escenic.context'] == 'art' and
                  not empty article.relatedElements.pictureRel.items}">
    
    <collection:createList id="mobileSlideshowPictures" type="java.util.ArrayList" toScope="page"/>

    <c:choose>
      <c:when test="${not empty mobileSlideshow.maxPictures}">
        <c:set var="counter" value="0"/>
        <c:forEach var="pictureRelItem" items="${article.relatedElements.pictureRel.items}">
          <c:if
              test="${pictureRelItem.content.articleTypeName == mobileSlideshow.pictureArticleTypeName and (counter+0) < (mobileSlideshow.maxPictures+0)}">
            <collection:add collection="${mobileSlideshowPictures}" value="${pictureRelItem}"/>
            <c:set var="counter" value="${counter+1}"/>
          </c:if>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <c:forEach var="pictureRelItem" items="${article.relatedElements.pictureRel.items}">
          <c:if test="${pictureRelItem.content.articleTypeName == mobileSlideshow.pictureArticleTypeName}">
            <collection:add collection="${mobileSlideshowPictures}" value="${pictureRelItem}"/>
          </c:if>
        </c:forEach>
      </c:otherwise>
    </c:choose>

    <c:set target="${mobileSlideshow}" property="mobileSlideshowPictures" value="${mobileSlideshowPictures}"/>
  </c:when>
</c:choose>