<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-blogUserList/src/main/webapp/template/widgets/blogUserList/controller/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the simple view list widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community"  %>

<%-- the general controller has already set a HashMap named 'blogUserList' in the requestScope --%>
<jsp:useBean id="blogUserList" type="java.util.HashMap" scope="request" />

<%-- access all the view specific fields --%>
<c:set var="contentType" value="${fn:trim(widgetContent.fields.contentTypeBlogs.value)}"/>
<c:if test="${empty contentType}">
  <c:set var="contentType" value="blogPost"/>
</c:if>
<c:set target="${blogUserList}" property="contentType" value="${contentType}"/>

<c:set target="${blogUserList}" property="maxBlogs" value="${fn:trim(widgetContent.fields.maxBlogs.value)}"/>

<c:set target="${blogUserList}" property="maxBlogPosts" value="${fn:trim(widgetContent.fields.maxBlogPostsBlogs.value)}"/>
<c:set target="${blogUserList}" property="maxBodyChar" value="${fn:trim(widgetContent.fields.maxBodyCharBlogs.value)}"/>
<c:set target="${blogUserList}" property="showAvatar" value="${fn:trim(widgetContent.fields.showAvatarBlogs.value)}"/>

<c:set target="${blogUserList}" property="avatarImageVersion" value="${fn:trim(widgetContent.fields.avatarImageVersionBlogs.value)}"/>
<c:set target="${blogUserList}" property="avatarSize" value="${fn:substringAfter(blogUserList.avatarImageVersion, 'w')}" />

<c:set target="${blogUserList}" property="showBody" value="${fn:trim(widgetContent.fields.showBodyBlogs.value)}"/>
<c:set target="${blogUserList}" property="showSeeMoreLink" value="${fn:trim(widgetContent.fields.showSeeMoreLinkBlogs.value)}"/>
<c:set target="${blogUserList}" property="seeMoreLinkLabel" value="${fn:trim(widgetContent.fields.seeMoreLabelBlogs.value)}"/>
<c:set target="${blogUserList}" property="seeMoreLinkedSection" value="${fn:trim(widgetContent.fields.seeMoreSectionBlogs.value)}"/>

<c:choose>
  <c:when test="${(not empty blogUserList.seeMoreLinkLabel)and(not empty blogUserList.seeMoreLinkedSection)}">
     <section:use uniqueName="${blogUserList.seeMoreLinkedSection}">
          <c:set target="${blogUserList}" property="seeMoreLinkedUrl" value="${section.url}"/>
     </section:use>
    <c:if test="${empty blogUserList.seeMoreLinkedUrl}">
       <c:set target="${blogUserList}" property="showSeeMoreLink" value="false"/>
    </c:if>
  </c:when>
  <c:otherwise>
    <c:set target="${blogUserList}" property="showSeeMoreLink" value="false"/>
  </c:otherwise>
</c:choose>

<wf-community:getLatestUpdatedBlogs var="latestblogUserList" max="${blogUserList.maxBlogs}"/>

<collection:createList id="attributeMapList" type="java.util.ArrayList" toScope="request"/>

<c:forEach var="userHomeSection" items="${latestblogUserList}">
  <section:use uniqueName="${userHomeSection}">
    <community:user id="communityUser" sectionId="${section.id}"/>
  </section:use>

  <c:if test="${not empty communityUser}">
    <collection:createMap id="attributeMap" type="java.util.HashMap" toScope="page"/>

    <c:choose>
      <c:when test="${not empty communityUser.article.relatedElements.profilePictures.items
                          and communityUser.article.relatedElements.profilePictures.items[0].content.articleTypeName == 'avatar'}">
        <c:set target="${attributeMap}" property="avatureImageUrl" value="${communityUser.article.relatedElements.profilePictures.items[0].content.fields.alternates.value[blogUserList.avatarImageVersion].href}" />
      </c:when>
      <c:otherwise>
        <c:set target="${attributeMap}" property="avatureImageUrl" value="${skinUrl}gfx/default-avatar.jpg" />
      </c:otherwise>
    </c:choose>

    <c:set target="${attributeMap}" property="blogName"
           value="${communityUser.article.fields.firstname.value} ${communityUser.article.fields.surname.value}" />

    <c:set target="${attributeMap}" property="blogUrl" value="${communityUser.section.url}" />

    <%-- get the latest articles from the blog user --%>
    <article:list id="userArticles" includeArticleTypes="blogPost" sort="lastChangedDate"  sectionUniqueName="${userHomeSection}"
                  includeSubSections="true" max="${blogUserList.maxBlogPosts}" from="${requestScope.articleListDateString}"/>

    <c:set target="${attributeMap}" property="userArtilces" value="${userArticles}" />

    <collection:add collection="${attributeMapList}" value="${attributeMap}"/>

    <c:remove var="attributeMap" scope="page"/>
  </c:if>

  <c:remove var="communityUser" scope="page" />
</c:forEach>

<c:remove var="latestblogUserList" scope="request"/>

<c:set target="${blogUserList}" property="attributeMapList" value="${attributeMapList}"/>


