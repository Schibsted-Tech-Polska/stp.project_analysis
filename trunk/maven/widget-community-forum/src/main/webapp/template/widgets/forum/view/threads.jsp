<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/threads.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this jsp renders the threads view of forum widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- the controller has already set a hashmap named 'forum' in the requestScope --%>
<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<c:if test="${not empty forum.forumMaps}">
  <div class="${forum.wrapperStyleClass}" <c:if test="${not empty forum.styleId}">id="${forum.styleId}"</c:if> >
    <script type="text/javascript" src="${requestScope.resourceUrl}js/paginator.js"></script>
    <script type="text/javascript" src="${resourceUrl}js/formValidator.js"></script>

    <jsp:useBean id="currentDate" class="java.util.Date"/>

    <c:forEach var="forumMap" items="${forum.forumMaps}">
      <c:set var="currentForum" value="${forumMap.forum}" />
      <c:set var="latestThreads" value="${forumMap.latestThreads}" />

      <div id="forum-${currentForum.id}" class="forumThreads ${forum.threadsSource}Threads">
        <article:use articleId="${currentForum.id}">
          <div class="forumHead">
            <h2><a href="${article.url}"><c:out value="${fn:trim(article.fields.name)}" escapeXml="true"/></a></h2>

            <p class="description"><c:out value="${fn:trim(article.fields.description.value)}" escapeXml="true"/></p>
          </div>
        </article:use>

        <c:if test="${not empty latestThreads}">
          <table>
            <thead>
              <tr>
                <th class="title"><fmt:message key="forum.widget.threads.title.header" /></th>
                <th class="author"><fmt:message key="forum.widget.threads.author.header" /></th>
                <th class="postsCount"><fmt:message key="forum.widget.threads.posts.header" /></th>
                <th class="latestPost"><fmt:message key="forum.widget.threads.latestPost.header" /></th>
              </tr>
            </thead>

            <tbody>
              <c:forEach var="latestThread" items="${latestThreads}" varStatus="status">
                <jsp:useBean id="latestThread" type="com.escenic.forum.presentation.PresentationThread" scope="page"/>

                <tr class="thread">
                  <td class="title">
                    <a href="${latestThread.root.url}"><c:out value="${latestThread.title}"/></a>
                  </td>

                  <td class="author">
                    <jsp:include page="helpers/authorName.jsp">
                      <jsp:param name="articleId" value="${latestThread.root.id}"/>
                    </jsp:include>
                  </td>

                  <td class="postsCount">${latestThread.postingCount}</td>


                  <td class="latestPost">
                    <c:set var="postingCount" value="${latestThread.postingCount}" />

                    <c:if test="${postingCount>0}">
                      <%-- latest posting in a thread is always stored in the 0 index --%>
                      <c:set var="latestPosting" value="${latestThread.postings[0]}" />
                      <article:use articleId="${latestPosting.id}">
                        <wf-core:getDateDifference var="publishedDate"
                                                     from="${article.publishedDateAsDate}" to="${currentDate}"/>

                        <span class="dateline"><c:out value="${publishedDate}"/></span>

                        <span class="byline">
                          <fmt:message key="forum.widget.threads.byline.prefix" />

                          <jsp:include page="helpers/authorName.jsp">
                            <jsp:param name="articleId" value="${article.id}"/>
                          </jsp:include>
                        </span>
                      </article:use>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:if>

        <profile:present>
          <%-- first try to load the community user who is currently logged in --%>
          <section:use uniqueName="${sessionScope.user.userName}">
            <community:user id="currentCommunityUser" sectionId="${section.id}"/>
            <c:set var="threadFormId" value="forumWidget${widgetContent.id}-addThread${currentForum.id}"/>
          </section:use>
        </profile:present>

        <c:if test="${forum.enablePagination == 'true'}">
          <script type="text/javascript">
            // <![CDATA[
            $(document).ready(function() {
                itemsPerPage = ${not empty forum.pageSize ? forum.pageSize : '20'};
                paginatorStyle = 1;
                paginatorPosition = 'bottom';
                enableGoToPage = false;
	              firstPageSymbol = 'First'; // to indicate First Page
              	previousPageSymbol = 'Previous'; // to indicate Previous Page
              	nextPageSymbol = 'Next'; // to indicate Next Page
              	lastPageSymbol = 'Last'; // to indicate Last Page
                separator = '';
                showIfSinglePage = false;
              $('#forum-${currentForum.id} > table > tbody').pagination();
            });
            // ]]>
          </script>
        </c:if>

        <c:choose>
          <c:when test="${forum.enablePagination == 'true' and  fn:length(latestThreads) > (forum.pageSize+0)}">
            <c:set var="forumActionLinksStyleClass" value="forumActionLinks forumActionLinksWithPaginator" />
          </c:when>
          <c:otherwise>
            <c:set var="forumActionLinksStyleClass" value="forumActionLinks" />
          </c:otherwise>
        </c:choose>

        <div class="${forumActionLinksStyleClass}">
          <ul>
            <c:if test="${forum.threadsSource != 'article'}">
              <li>
                <a href="${currentForum.url}"><fmt:message key="forum.widget.threads.forum.linkText" /></a>
              </li>
            </c:if>

            <c:choose>
              <c:when test="${not empty currentCommunityUser}">
                <li>
                  <a onclick="$('#${threadFormId}').slideToggle('slow'); return false;"
                     href="#"><fmt:message key="forum.widget.thread.form.post.linkText" /></a>
                </li>
              </c:when>
              <c:otherwise>
                <li>
                  <c:set var="loginSectionUniqueName" value="login" />
                  <wf-community:getLoginUrl var="loginUrl" sectionUniqueName="${loginSectionUniqueName}" />
                  <a href="${loginUrl}"><fmt:message key="forum.widget.thread.form.login.linkText" /></a>
                  <c:remove var="loginUrl" scope="request" />
                </li>
              </c:otherwise>
            </c:choose>
          </ul>
        </div>

        <c:if test="${not empty currentCommunityUser}">
          <c:choose>
            <c:when test="${requestScope['com.escenic.context'] == 'art'}">
              <c:set var="currentUrl" value="${article.url}" />
            </c:when>
            <c:otherwise>
              <c:set var="currentUrl" value="${section.url}" />
            </c:otherwise>
          </c:choose>

          <jsp:include page="helpers/insertThreadForm.jsp">
            <jsp:param name="forumId" value="${currentForum.id}" />
            <jsp:param name="successUrl" value="${currentUrl}" />
            <jsp:param name="errorUrl" value="${currentUrl}" />
            <jsp:param name="formContainerId" value="${threadFormId}" />
            <jsp:param name="formContainerStyle" value="display: none;" />
          </jsp:include>

          <c:remove var="currentCommunityUser" scope="page" />
          <c:remove var="threadFormId" scope="page" />
        </c:if>
      </div>

      <c:remove var="currentForum" scope="page" />
      <c:remove var="latestThreads" scope="page" />
    </c:forEach>
  </div>
</c:if>


<c:remove var="forum" scope="request" />




