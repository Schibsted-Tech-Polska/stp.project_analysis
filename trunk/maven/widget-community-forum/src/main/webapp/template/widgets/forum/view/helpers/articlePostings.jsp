<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/articlePostings.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>


<jsp:useBean id="article" type="neo.xredsys.presentation.PresentationArticle" scope="request"/>
<forum:thread id="thread" threadId="${article.id}"/>

<div class="${forum.wrapperStyleClass}" <c:if test="${not empty forum.styleId}"> id="${forum.styleId}"</c:if> >

  <script type="text/javascript" src="${requestScope.resourceUrl}js/formValidator.js"></script>
  <script type="text/javascript" src="${requestScope.resourceUrl}js/paginator.js"></script>
  <script type="text/javascript">
    //<![CDATA[
    function showHiddenPosting(postingId) {
      $('#posting-'+postingId+' > div.postingContent > p.showHiddenPosting').hide('fast');
      $('#posting-'+postingId+' > div.postingContent > p.body').slideDown('fast');
      $('#posting-'+postingId+' > div.postingContent > div.postingActionLinks').slideDown('fast');
    }
   //]]>
  </script>

  <h1><c:out value="${forum.threadTitle}"/></h1>

  <p class="threadInfo">
    <%-- posting count --%>
    <span class="postingCount">
      ${thread.postingCount} <fmt:message key="forum.widget.postings.posts.text" /> ,
    </span>


    <!-- last modified date -->
    <span class="dateline">
      <fmt:message key="forum.widget.postings.latestPost.text" />
      <jsp:useBean id="currentDate" class="java.util.Date" scope="page"/>
      <article:use articleId="${thread.postings[0].id}">
        <c:set var="lastModifiedDate" value="${article.lastModifiedDateAsDate}" />
      </article:use>
      <wf-core:getDateDifference var="tempLastModifiedText" from="${lastModifiedDate}" to="${currentDate}" />
      <c:out value="${tempLastModifiedText}"/>
      <c:remove var="tempLastModifiedText" scope="request" />
      <c:remove var="currentDate" scope="page" />
    </span>

    <span class="byline">
      <fmt:message key="forum.widget.postings.byline.prefix" />
      <jsp:include page="authorName.jsp">
        <jsp:param name="articleId" value="${thread.postings[0].id}" />
      </jsp:include>
    </span>
  </p>

  <p class="forumLink">
    <fmt:message key="forum.widget.postings.forum.go.prefix" /> <a href="${forum.forumUrl}"><c:out value="${forum.forumName}"/></a>
  </p>

  <!-- display root thread contents-->
  <c:set var="rootThread" value="${thread.root}" />
  <c:set var="rootReplyDivId" value="rootReplyDiv${rootThread.id}" />
  <c:set var="posting" value="${rootThread}" scope="request" />

  <jsp:include page="showPosting.jsp">
    <jsp:param name="showReplies" value="false" />
    <jsp:param name="showReplyForm" value="true" />
    <jsp:param name="showThreadLink" value="false" />
    <jsp:param name="currentThreadDepth" value="0" />
    <jsp:param name="customStyleClass" value="threadPosting" />
    <jsp:param name="replyLinkAnchor" value="" />
  </jsp:include>

  <!-- all replies -->
  <div id="postings${widgetContent.id}" class="articlePostings">
    <c:forEach items="${rootThread.replies}" var="posting">
      <c:set var="posting" scope="request" value="${posting}" />
      <jsp:include page="showPosting.jsp">
        <jsp:param name="showReplies" value="true" />
        <jsp:param name="showReplyForm" value="true" />
        <jsp:param name="showThreadLink" value="false" />
        <jsp:param name="currentThreadDepth" value="1" />
      </jsp:include>
      <c:remove var="posting" scope="request" />
    </c:forEach>
  </div>

<!-- root thread reply form -->
  <profile:present>
    <community:user id="communityUser" userId="${sessionScope.user.id}"/>
    <fmt:message var="postingFormHeadline" key="forum.widget.posting.form.headline" />
    <jsp:include page="replyForm.jsp">
      <jsp:param name="divId" value="${rootReplyDivId}" />
      <jsp:param name="customStyleClass" value="threadReplyForm" />
      <jsp:param name="typeName" value="posting" />
      <jsp:param name="forumId" value="${rootThread.forum.id}" />
      <jsp:param name="email" value="${communityUser.article.fields.email}" />
      <jsp:param name="parentId" value="${rootThread.id}" />
      <jsp:param name="targetUrl" value="${rootThread.thread.root.url}" />
      <jsp:param name="errorUrl" value="${rootThread.thread.root.url}" />
      <jsp:param name="cancelUrl" value="${rootThread.thread.root.url}" />
      <jsp:param name="title" value="${rootThread.fields.title}" />
      <jsp:param name="formHeadline" value="${postingFormHeadline}" />
      <jsp:param name="keepHidden" value="false" />
    </jsp:include>
  </profile:present>
  
  <c:if test="${forum.enablePagination == 'true' and (thread.root.repliesCount+0) > 0 and (thread.root.repliesCount+0) > (forum.pageSize+0)}">
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
            $('#postings${widgetContent.id}').pagination();
        });
        // ]]>
    </script>
  </c:if>

</div>
