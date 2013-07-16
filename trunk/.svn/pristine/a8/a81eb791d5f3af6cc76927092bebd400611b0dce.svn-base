<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileVideo/src/main/webapp/template/widgets/mobileVideo/controller/youtube.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/19 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the youtube view of the video widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the general controller has already set a HashMap named 'video' in the requestScope --%>
<jsp:useBean id="mobileVideo" type="java.util.HashMap" scope="request"/>
<c:set var="contentTypes" value="${mobileVideo.contentTypes}" />

<c:choose>
  <c:when test="${mobileVideo.source=='desked' and not empty mobileVideo.groupName}">
    <c:choose>
      <c:when test="${mobileVideo.sectionUniqueName == section.uniqueName}">
        <wf-core:getGroupByName var="targetGroup" groupName="${mobileVideo.groupName}"
                                areaName="${requestScope.contentAreaName}"/>
      </c:when>
      <c:otherwise>
        <section:use uniqueName="${mobileVideo.sectionUniqueName}">
          <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
        </section:use>
        <wf-core:getGroupByName var="targetGroup" groupName="${mobileVideo.groupName}"
                                areaName="${requestScope.contentAreaName}" pool="${requestScope.targetSectionPool}"/>
        <c:remove var="targetSectionPool" scope="request"/>
      </c:otherwise>
    </c:choose>

    <wf-core:getVideosInGroup var="videoContents" group="${targetGroup}" contentTypes="${contentTypes}"
                               max="${mobileVideo.maxVideos}"/>
    <c:remove var="targetGroup" scope="request"/>
  </c:when>

  <c:when test="${mobileVideo.source=='latest'}">
    <section:use uniqueName="${mobileVideo.sectionUniqueName}">
      <article:list id="videosList"
                    sectionUniqueName="${mobileVideo.sectionUniqueName}"
                    includeSubSections="${mobileVideo.includeSubsections}"
                    includeArticleTypes="${contentTypes}"
                    max="${mobileVideo.maxVideos}"
                    sort="-publishDate"
                    from="${requestScope.articleListDateString}"/>
    </section:use>
    <c:set var="videoContents" value="${videosList}" scope="request"/>
  </c:when>

  <c:when test="${mobileVideo.source=='related' and
                  requestScope['com.escenic.context'] == 'art' and
                  not empty article.relatedElements.videoRel.items}">
    <c:set var="videoRelItems" value="${article.relatedElements.videoRel.items}"/>

    <c:set var="counter" value="0"/>
    <collection:createList id="videoContents" type="java.util.ArrayList" toScope="request"/>
    <c:forEach var="videoRelItem" items="${videoRelItems}">
      <c:if test="${(counter + 0) < (mobileVideo.maxVideos + 0) and fn:containsIgnoreCase(contentTypes, videoRelItem.content.articleTypeName)}">
        <collection:add collection="${videoContents}" value="${videoRelItem.content}"/>
        <c:set var="counter" value="${counter + 1}"/>
      </c:if>
    </c:forEach>
  </c:when>
</c:choose>

<c:set target="${mobileVideo}" property="items" value="${requestScope.videoContents}"/>
<c:remove var="videoContents" scope="request"/>