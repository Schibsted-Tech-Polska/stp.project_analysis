<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-comments/src/main/webapp/template/widgets/comments/view/helpers/commentSuccess.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
  the purpose of this page is to display the success page after posting a new comment
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forum" uri="http://www.escenic.com/taglib/escenic-forum" %>

<%--
  this JSP page expects the following objects in the request scope
  if any of them is missing, then this page will not work
--%>
<jsp:useBean id="comments" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="newPostingId" type="java.lang.String" scope="request" />

<forum:posting id="newComment" postingId="${newPostingId}"/>

<c:choose>
  <c:when test="${not empty pageScope.newComment and newComment.id > 0}">
    <c:choose>
      <c:when test="${not empty requestScope.topLevelCommentsList and
                      not empty comments.numberOfCommentsPerPage}">
        <%-- call commentPageNumber.jsp to find out the appropiate pageNumber of the newly posted comment --%>
        <c:set var="comment" value="${newComment}" scope="request"/>
        <jsp:include page="commentPageNumber.jsp" />
        <c:remove var="comment" scope="request" />
        
        <c:set var="pageNumber" value="${requestScope.pageNumber}" />
        <c:set var="timeOut" value="10" />
      </c:when>
      <c:otherwise>
        <c:set var="pageNumber" value="1" />
        <c:set var="timeOut" value="1500" />
      </c:otherwise>
    </c:choose>

   <%-- create redirection url for the newly posted comment --%>
    <c:url var="redirectionUrl" value="${article.url}">
      <c:param name="commentId" value="${newComment.id}" />
      <c:param name="pageNumber" value="${pageNumber}" />
    </c:url>
    <c:set var="redirectionUrl" value="${redirectionUrl}#comment-${newComment.id}"/>

    <c:url var="commentSuccessPopupUrl" value="${requestScope.widgetUrl}comments/view/helpers/commentSuccessPopup.jsp">
      <c:param name="commentsSkinUrl" value="${requestScope.widgetUrl}comments/skins/${requestScope.skinName}/" />
      <c:param name="redirectionUrl" value="${redirectionUrl}" />
    </c:url>

    <script type="text/javascript">
    // <![CDATA[
    window.setTimeout("location.href='${redirectionUrl}'",${timeOut});
    
     /* uncomment the following block if you want to add thank you page */
     /*
        var popupWindow = window.open("${commentSuccessPopupUrl}","_self", "channelmode=yes,fullscreen=yes");
        if(popupWindow==null || typeof(popupWindow)=="undefined") {
          alert("You must disable your popup blocker for this site!");
        }
     */
    // ]]>
    </script>

    <%--increase the comment counter by 1 for this article by calling comment statistics page--%>
    <jsp:include page="../../../../framework/eae/eaeCommentLoggerClient.jsp" />
  </c:when>
  <c:otherwise>
    <%-- the new posting is actually a complaint --%>
    <c:set var="pageNumber" value="${param.pageNumber}" />
    <c:if test="${empty pageNumber}">
      <c:set var="pageNumber" value="1" />
    </c:if>

    <c:set var="parentId" value="${param.parentId}" />
    <c:choose>
      <c:when test="${not empty parentId}">
        <c:url var="redirectionUrl" value="${article.url}">
          <c:param name="pageNumber" value="${pageNumber}" />
          <c:param name="complaintParentId" value="${parentId}" />
        </c:url>
        <c:set var="redirectionUrl" value="${redirectionUrl}#comment-${parentId}" />
      </c:when>
      <c:otherwise>
        <c:url var="redirectionUrl" value="${article.url}">
          <c:param name="pageNumber" value="${pageNumber}" />
        </c:url>
        <c:set var="redirectionUrl" value="${redirectionUrl}#commentsList"/>
      </c:otherwise>
    </c:choose>

    <%-- javascript redirection for the newly posted comment --%>
    <script type="text/javascript">
      // <![CDATA[
        location.href='${redirectionUrl}';
      // ]]>
    </script>
  </c:otherwise>
</c:choose>




