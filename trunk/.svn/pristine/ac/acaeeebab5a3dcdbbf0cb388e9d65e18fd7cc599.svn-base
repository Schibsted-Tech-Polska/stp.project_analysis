<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/controller/controller.jsp#1 ${PACKAGE_NAME}/${NAME}.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="relation" uri="http://www.escenic.com/taglib/escenic-relation" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%-- making sure that comments widget is only displayed in article page, not in section page --%>
<c:if test="${requestScope['com.escenic.context']=='art'}">
  <%--create a map that will contain relevant field values --%>
  <jsp:useBean id="comments" class="java.util.HashMap" scope="request"/>

  <%-- get necessary parameters from element's content article fields --%>
  <c:set target="${comments}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>
  <c:set target="${comments}" property="captcha" value="${fn:trim(widgetContent.fields.captcha)}"/>

  <%--Initialize the CommentTitleLength--%>
  <c:set var="useCommentTitleLength" value="${fn:trim(widgetContent.fields.titleLength)}" />
  <c:if test="${empty useCommentTitleLength}">
    <c:set var="useCommentTitleLength" value="100"/>
  </c:if>

  <%--Initialize the CommentBodyLength--%>
  <c:set var="useCommentBodyLength" value="${fn:trim(widgetContent.fields.bodyLength)}"/>
  <c:if test="${empty useCommentBodyLength}">
    <c:set var="useCommentBodyLength" value="1000"/>
  </c:if>

  <c:set target="${comments}" property="commentTitleLength" value="${fn:trim(useCommentTitleLength)}"/>
  <c:set target="${comments}" property="commentBodyLength" value="${fn:trim(useCommentBodyLength)}"/>

  <c:set target="${comments}" property="showTitle" value="${fn:trim(widgetContent.fields.showTitle)}"/>

  <c:set target="${comments}" property="styleId" value="${fn:trim(widgetContent.fields.styleId)}"/>
  <c:set target="${comments}" property="customStyleClass" value="${fn:trim(widgetContent.fields.customStyleClass)}"/>
  <c:set var="numberOfAllComments" value="0"/>
  <c:set var="numberOfTopLevelComments" value="0"/>
  <article:hasRelation includeArticleTypes="posting">
    <relation:articles id="relatedThread" includeArticleTypes="posting">
      <forum:thread id="thread" threadId="${relatedThread.id}"/>
      <c:set var="numberOfAllComments" value="${numberOfAllComments+thread.postingCount-1}"/>
      <c:set var="numberOfTopLevelComments" value="${numberOfTopLevelComments + thread.root.repliesCount}"/>
    </relation:articles>
  </article:hasRelation>

  <c:set target="${comments}" property="numberOfAllComments" value="${numberOfAllComments}"/>
  <c:set target="${comments}" property="numberOfTopLevelComments" value="${numberOfTopLevelComments}"/>
  
</c:if>
<c:set var="noPrint" value="${fn:trim(widgetContent.fields.noPrint.value)}"/>
<c:set target="${comments}" property="wrapperStyleClass">widget comments ${comments.view} widget-editable viziwyg-section-${widgetContent.homeSection.id} inpage-widget-${widgetContent.id}<c:if test="${noPrint=='true'}"> noPrint</c:if><c:if test="${not empty comments.customStyleClass}"> ${comments.customStyleClass}</c:if></c:set>