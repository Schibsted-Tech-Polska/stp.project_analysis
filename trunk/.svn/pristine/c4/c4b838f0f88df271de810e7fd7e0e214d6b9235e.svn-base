<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-community/src/main/webapp/template/custom/menu/blogMenu.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<%--
Menu items: 'Overview', 'Blog',  'Comments', 'Create', 'Archive', 'Profile'
the first 3 items: 'Overview', 'Blog',  'Comments' will be displayed always in user home section,
but
the last 3 items will be displayed only if a user is logged in and we are in the current user's home section
--%>

<%-- at first try to load community user from the current section --%>
<community:user id="blogUser" sectionId="${section.id}"/>

<profile:present>
  <section:use uniqueName="${sessionScope.user.userName}">
    <community:user id="currentUser" sectionId="${section.id}"/>
  </section:use>
  <c:if test="${empty blogUser}">
    <c:set var="blogUser" value="${currentUser}" />
  </c:if>
</profile:present>

<c:if test="${not empty currentUser and blogUser.id == currentUser.id}">
  <c:set var="saveBlogPostSectionUniqueName" value="saveBlogPost"/>
  <c:set var="savePictureSectionUniqueName" value="savePicture"/>
  <c:set var="archiveBlogPostsSectionUniqueName" value="archiveBlogPosts"/>
  <c:set var="archivePicturesSectionUniqueName" value="archivePictures"/>

  <c:set var="profileSectionUniqueName" value="viewProfile"/>
  <c:set var="editProfileSectionUniqueName" value="editProfile"/>
  <c:set var="uploadProfilePictureSectionUniqueName" value="uploadProfilePicture"/>
  <c:set var="changePasswordSectionUniqueName" value="changePassword"/>
  <c:set var="deleteBlogSectionUniqueName" value="deleteProfile"/>

  <section:use uniqueName="${saveBlogPostSectionUniqueName}">
    <c:set var="saveBlogPostUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${savePictureSectionUniqueName}">
    <c:set var="savePictureUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${archiveBlogPostsSectionUniqueName}">
    <c:set var="archiveBlogPostsUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${archivePicturesSectionUniqueName}">
    <c:set var="archivePicturesUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${profileSectionUniqueName}">
    <c:set var="profileSectionUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${uploadProfilePictureSectionUniqueName}">
    <c:set var="uploadProfilePictureUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${changePasswordSectionUniqueName}">
    <c:set var="changePasswordUrl" value="${section.url}" />
  </section:use>

  <section:use uniqueName="${deleteBlogSectionUniqueName}">
    <c:set var="deleteBlogUrl" value="${section.url}" />
  </section:use>
</c:if>

<c:if test="${not empty blogUser}">
  <c:set var="blogUserSectionUrl" value="${blogUser.section.url}" />

  <c:url var="overviewUrl" value="${blogUserSectionUrl}">
    <c:param name="switchItem" value="Activities" />
  </c:url>

  <c:url var="blogUrl" value="${blogUserSectionUrl}">
    <c:param name="switchItem" value="Blog" />
  </c:url>

  <c:url var="commentsUrl" value="${blogUserSectionUrl}">
    <c:param name="switchItem" value="Comments" />
  </c:url>

  <div class="blogMenu">
    <ul>
      <li>
        <a href="${overviewUrl}"
          <c:if test="${section.uniqueName == blogUser.section.uniqueName and (empty fn:trim(param.switchItem) or fn:trim(param.switchItem) == 'Activities')}">class='active'</c:if> >
          <span><fmt:message key="publication.blog.menu.custom.overview.linkText" /></span>
        </a>
      </li>

      <li>
        <a href="${blogUrl}"
          <c:if test="${section.uniqueName == blogUser.section.uniqueName and not empty fn:trim(param.switchItem) and fn:trim(param.switchItem) == 'Blog'}">class='active'</c:if> >
          <span><fmt:message key="publication.blog.menu.custom.blog.linkText" /></span>
        </a>
      </li>

      <li>
        <a href="${commentsUrl}"
          <c:if test="${section.uniqueName == blogUser.section.uniqueName and not empty fn:trim(param.switchItem) and fn:trim(param.switchItem) == 'Comments'}">class='active'</c:if> >
          <span><fmt:message key="publication.blog.menu.custom.comments.linkText" /></span>
        </a>
      </li>

      <c:if test="${not empty currentUser and blogUser.id == currentUser.id}">
        <li>
          <a href="${saveBlogPostUrl}"
             <c:if test="${section.uniqueName == saveBlogPostSectionUniqueName or section.uniqueName == savePictureSectionUniqueName}">class='active'</c:if> >
            <span><fmt:message key="publication.blog.menu.custom.createContent.linkText" /></span>
          </a>
        </li>

        <li>
          <a href="${archiveBlogPostsUrl}"
             <c:if test="${section.uniqueName == archiveBlogPostsSectionUniqueName or section.uniqueName == archivePicturesSectionUniqueName}">class='active'</c:if> >
            <span><fmt:message key="publication.blog.menu.custom.archiveContents.linkText" /></span>
          </a>
        </li>

        <li>
          <a href="${profileSectionUrl}"
             <c:if test="${section.uniqueName == profileSectionUniqueName or
                           section.uniqueName ==  editProfileSectionUniqueName or
                           section.uniqueName == uploadProfilePictureSectionUniqueName or
                           section.uniqueName == changePasswordSectionUniqueName  or
                           section.uniqueName == deleteBlogSectionUniqueName}">class='active'</c:if> >
            <span><fmt:message key="publication.blog.menu.custom.profile.linkText" /></span>
          </a>
        </li>
      </c:if>
    </ul>

    <c:if test="${not empty currentUser and blogUser.id == currentUser.id}">
      <c:choose>
        <c:when test="${section.uniqueName == saveBlogPostSectionUniqueName or
                        section.uniqueName == savePictureSectionUniqueName}">
          <ul class="submenu">
            <li>
              <a href="${saveBlogPostUrl}"
                 <c:if test="${section.uniqueName == saveBlogPostSectionUniqueName}">class='active'</c:if> >
                <span><fmt:message key="publication.blog.menu.custom.createContent.blogPost.linkText" /></span>
              </a>
            </li>

            <li>
              <a href="${savePictureUrl}"
                 <c:if test="${section.uniqueName == savePictureSectionUniqueName}">class='active'</c:if> >
                <span><fmt:message key="publication.blog.menu.custom.createContent.picture.linkText" /></span>
              </a>
            </li>
          </ul>
        </c:when>
        <c:when test="${section.uniqueName == archiveBlogPostsSectionUniqueName or
                        section.uniqueName == archivePicturesSectionUniqueName}">
          <ul class="submenu">
            <li>
              <a href="${archiveBlogPostsUrl}"
                 <c:if test="${section.uniqueName == archiveBlogPostsSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.archiveContents.blogPosts.linkText" /></span>
              </a>
            </li>

            <li>
              <a href="${archivePicturesUrl}"
                 <c:if test="${section.uniqueName == archivePicturesSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.archiveContents.pictures.linkText" /></span>
              </a>
            </li>
          </ul>
        </c:when>
        <c:when test="${section.uniqueName == profileSectionUniqueName or
                        section.uniqueName ==  editProfileSectionUniqueName or
                        section.uniqueName == uploadProfilePictureSectionUniqueName or
                        section.uniqueName == changePasswordSectionUniqueName  or
                        section.uniqueName == deleteBlogSectionUniqueName}">
          <ul class="submenu">
            <li>
              <a href="${profileSectionUrl}"
                 <c:if test="${section.uniqueName == profileSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.profile.view.linkText" /></span>
              </a>
            </li>

            <li>
              <c:choose>
                <c:when test="${section.uniqueName == editProfileSectionUniqueName}">
                  <c:set var="editProfileLinkStyleClass" value="active" />
                </c:when>
                <c:otherwise>
                  <c:set var="editProfileLinkStyleClass" value="" />
                </c:otherwise>
              </c:choose>

              <c:set var="editProfileLinkText">
                <span><fmt:message key="publication.blog.menu.custom.profile.edit.linkText" /></span>
              </c:set>
              <wf-community:getEditProfileLink linkText="${editProfileLinkText}" />
              <%--<framework:getEditBlogProfileLink linkText="${editProfileLinkText}" styleClass="${editProfileLinkStyleClass}" />--%>
            </li>

            <li>
              <a href="${uploadProfilePictureUrl}"
                 <c:if test="${section.uniqueName == uploadProfilePictureSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.profile.uploadPicture.linkText" /></span>
              </a>
            </li>

            <li>
              <a href="${changePasswordUrl}"
                 <c:if test="${section.uniqueName == changePasswordSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.profile.changePassword.linkText" /></span>
              </a>
            </li>

            <li>
              <a href="${deleteBlogUrl}"
                 <c:if test="${section.uniqueName == deleteBlogSectionUniqueName}">class='active'</c:if> >
                  <span><fmt:message key="publication.blog.menu.custom.profile.deleteBlog.linkText" /></span>
              </a>
            </li>
          </ul>
        </c:when>
      </c:choose>
    </c:if>
  </div>

  <c:if test="${not empty currentUser}">
    <c:remove var="currentUser" scope="page" />
  </c:if>

  <c:remove var="blogUser" scope="page" />
</c:if>
