<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-actionLinks/src/main/webapp/template/widgets/actionLinks/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This JSP page is the entry point of the actionLinks widget. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<%-- constants based on widget framework section naming conventions--%>
<c:set var="addStorySectionUniqueName" value="saveBlogPost"/>
<c:set var="addPictureSectionUniqueName" value="savePicture"/>
<c:set var="deleteContentSectionUniqueName" value="deleteContent"/>

<%--create a hashmap named 'actionLinks' that will contain relevant field values --%>
<jsp:useBean id="actionLinks" class="java.util.HashMap" scope="request" />

<%-- retreive necessary parameters --%>
<c:set target="${actionLinks}" property="view" value="${fn:trim(widgetContent.fields.view.value)}"/>
<c:set target="${actionLinks}" property="styleId" value="${fn:trim(widgetContent.fields.styleId.value)}"/>
<c:set target="${actionLinks}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass.value)}"/>
<c:set target="${actionLinks}" property="showTitle" value="${fn:trim(widgetContent.fields.showTitle.value)}"/>
<c:set target="${actionLinks}" property="headline" value="${fn:trim(element.fields.title.value)}"/>

<section:use uniqueName="${addStorySectionUniqueName}">
  <c:set target="${actionLinks}" property="addStoryUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${addPictureSectionUniqueName}">
  <c:set target="${actionLinks}" property="addPictureUrl" value="${section.url}"/>
</section:use>

<section:use uniqueName="${deleteContentSectionUniqueName}">
  <c:set var="deleteContentUrl" value="${section.url}"/>
</section:use>

<c:set target="${actionLinks}" property="logoutUrl" value="${publication.url}community/logoff.do"/>

<profile:present>

  <section:use uniqueName="${user.userName}">
    <community:user id="currentUser" sectionId="${section.id}"/>
    <c:set target="${actionLinks}" property="currentUser" value="${currentUser}"/>
    <c:set target="${actionLinks}" property="profileUrl" value="${section.url}"/>
  </section:use>

  <c:choose>

    <c:when test="${requestScope['com.escenic.context']=='art' and
                    article.articleTypeName eq 'blogPost' and
                    article.author.id == currentUser.id and
                    article.homeSection.uniqueName eq currentUser.section.uniqueName }">
      <c:set target="${actionLinks}" property="allowEditStory" value="${true}"/>

      <c:url var="deleteStoryUrl" value="${deleteContentUrl}">
        <c:param name="articleId" value="${article.id}" />
      </c:url>

      <c:set target="${actionLinks}" property="deleteStoryUrl" value="${deleteStoryUrl}"/>
    </c:when>
    <c:otherwise>
      <c:set target="${actionLinks}" property="allowEditStory" value="${false}"/>
    </c:otherwise>
  </c:choose>

  <c:choose>
    <c:when test="${requestScope['com.escenic.context']=='art' and
                    article.articleTypeName eq 'picture' and
                    article.author.id == currentUser.id and
                    article.homeSection.uniqueName eq currentUser.section.uniqueName }">

      <c:set target="${actionLinks}" property="allowEditPicture" value="${true}"/>
      <c:url var="deletePictureUrl" value="${deleteContentUrl}">
        <c:param name="articleId" value="${article.id}" />
      </c:url>
      <c:set target="${actionLinks}" property="deletePictureUrl" value="${deletePictureUrl}"/>
    </c:when>

    <c:otherwise>
      <c:set target="${actionLinks}" property="allowEditPicture" value="${false}"/>
    </c:otherwise>
  </c:choose>

</profile:present>

<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${actionLinks}" property="wrapperStyleClass">widget actionLinks ${actionLinks.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty actionLinks.customStyleClass}"> ${actionLinks.customStyleClass}</c:if></c:set>