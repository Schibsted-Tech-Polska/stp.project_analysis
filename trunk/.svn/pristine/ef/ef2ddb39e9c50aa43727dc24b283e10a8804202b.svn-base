<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-forum/src/main/webapp/template/widgets/forum/view/helpers/sectionPostings.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>

<jsp:useBean id="forum" type="java.util.Map" scope="request"/>

<div class="${forum.wrapperStyleClass}" <c:if test="${not empty forum.styleId}">id="${forum.styleId}"</c:if> >
  
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

  <!-- all replies -->
  <div id="postings${widgetContent.id}" class="sectionPostings">
    <c:forEach items="${forum.latestPostings}" var="posting">
      <c:set var="posting" scope="request" value="${posting}" />
      <jsp:include page="showPosting.jsp">
        <jsp:param name="showReplies" value="false" />
        <jsp:param name="showReplyForm" value="true" />
        <jsp:param name="showThreadLink" value="true" />
        <jsp:param name="currentThreadDepth" value="0" />
      </jsp:include>
      <c:remove var="posting" scope="request" />
    </c:forEach>
  </div>

  <c:if test="${forum.enablePagination == 'true' and fn:length(forum.latestPostings) > 0 and fn:length(forum.latestPostings) > (forum.pageSize+0)}">
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
