<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/controller/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
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

<%-- the general controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.HashMap" scope="request"/>

<c:set target="${picture}" property="groupName" value="${fn:trim(widgetContent.fields.groupName_newsletter.value)}"/>
<c:set target="${picture}" property="maxPictures"
       value="${fn:trim(widgetContent.fields.maxPictures_newsletter.value)}"/>
<c:set target="${picture}" property="showWidgetName"
       value="${fn:trim(widgetContent.fields.showWidgetName_newsletter.value)}"/>
<c:set target="${picture}" property="widgetName" value="${fn:trim(element.fields.title.value)}"/>

<c:set var="sectionUniqueName" value="${fn:trim(widgetContent.fields.sectionUniqueName_newsletter)}"/>
<c:if test="${empty sectionUniqueName}">
  <c:set var="sectionUniqueName" value="${section.uniqueName}"/>
</c:if>
<c:set target="${picture}" property="sectionUniqueName" value="${sectionUniqueName}"/>

<c:if test="${not empty picture.groupName}">
  <c:choose>
    <c:when test="${picture.sectionUniqueName == section.uniqueName}">
      <wf-core:getGroupByName var="targetGroup"
                                groupName="${picture.groupName}"
                                areaName="${requestScope.contentAreaName}"/>
    </c:when>
    <c:otherwise>
      <section:use uniqueName="${picture.sectionUniqueName}">
        <wf-core:getPresentationPool var="targetSectionPool" section="${section}"/>
      </section:use>

      <wf-core:getGroupByName var="targetGroup"
                                groupName="${picture.groupName}"
                                areaName="${requestScope.contentAreaName}"
                                pool="${targetSectionPool}"/>
      <c:remove var="targetSectionPool" scope="request"/>
    </c:otherwise>
  </c:choose>

  <wf-core:getPicturesInGroup var="picturesList" group="${targetGroup}" contentType="${picture.contentType}"
                                max="${picture.maxPictures}"/>
  <c:remove var="targetGroup" scope="request"/>
</c:if>

<c:set target="${picture}" property="items" value="${picturesList}"/>
<c:remove var="picturesList" scope="request"/>