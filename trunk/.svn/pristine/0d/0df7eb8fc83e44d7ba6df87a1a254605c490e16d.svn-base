<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/controller/helpers/latestArticles.jsp#1 $
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
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<jsp:useBean id="list" type="java.util.Map" scope="request"/>

<c:choose>
  <c:when test="${list.contentType=='posting'}">
  	<%-- filtering thread postings from comment postings --%>
    <section:use uniqueName="${list.sectionUniqueName}">
      <article:list id="postingList"
              sectionUniqueName="${list.sectionUniqueName}"
              includeSubSections="${list.includeSubsections}"
              includeArticleTypes="${list.contentType}"
              max="${list.itemCount*2}"
              sort="-publishDate"
              from="${requestScope.articleListDateString}"/>
    </section:use>
    <collection:createList id="articleList" type="java.util.ArrayList" />
      <c:set var="count" value="0"/>
      <c:forEach var="item" items="${postingList}">
      	<forum:posting id="posting" postingId="${item.id}"/>
        <c:if test="${not empty posting.parent and count lt list.itemCount}">
          <collection:add collection="${articleList}" value="${posting}" />
          <c:set var="count" value="${count+1}"/> 
        </c:if>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <section:use uniqueName="${list.sectionUniqueName}">
      <article:list id="articleList"
              sectionUniqueName="${list.sectionUniqueName}"
              includeSubSections="${list.includeSubsections}"
              includeArticleTypes="${list.contentType}"
              max="${list.itemCount}"
              sort="-publishDate"
              from="${requestScope.articleListDateString}"/>
    </section:use>
  </c:otherwise>
</c:choose>

<c:set var="resultList" value="${articleList}" scope="request" />