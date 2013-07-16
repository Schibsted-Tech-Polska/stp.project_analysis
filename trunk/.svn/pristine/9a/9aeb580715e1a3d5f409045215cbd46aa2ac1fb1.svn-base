<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getFileTypeStyleClass.tag#1 $
 * Last edited by : $Author: bappi $ $Date: 2012/01/07 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- This tag takes a related content  as input and return corresponding Style Class name. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="var" required="true" rtexprvalue="true" %>
<%@ attribute name="relatedObject" type="neo.xredsys.presentation.PresentationElement" required="true" rtexprvalue="true" %>

<c:choose >
  <c:when test="${relatedObject.content.articleTypeName eq 'media'}">
    <c:set var="mimeType" value="${fn:toLowerCase(relatedObject.content.fields.binary.value['mime-type'])}" />
    
    <c:choose>
      <c:when test="${fn:startsWith(mimeType,'video/')}">
        <c:set var="styleClassName" value="video" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'audio/')}">
        <c:set var="styleClassName" value="audio" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'text/html')}">
        <c:set var="styleClassName" value="html" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'text/')}">
        <c:set var="styleClassName" value="text" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/zip')}">
        <c:set var="styleClassName" value="zip" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') or
                      fn:startsWith(mimeType,'application/vnd.ms-excel')}">
        <c:set var="styleClassName" value="excel" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/vnd.openxmlformats-officedocument.presentationml.presentation') or
                      fn:startsWith(mimeType,'application/vnd.ms-powerpoint')}">
        <c:set var="styleClassName" value="powerpoint" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/vnd.openxmlformats-officedocument.wordprocessingml.document') or
                      fn:startsWith(mimeType,'application/msword')}">
        <c:set var="styleClassName" value="word" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/pdf')}">
        <c:set var="styleClassName" value="pdf" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/x-shockwave-flash')}">
        <c:set var="styleClassName" value="flash" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/x-msdos-program')}">
        <c:set var="styleClassName" value="binary" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/vnd.visio')}">
        <c:set var="styleClassName" value="visio" />
      </c:when>
      <c:when test="${fn:startsWith(mimeType,'application/xml')}">
        <c:set var="styleClassName" value="xml" />
      </c:when>
      <c:otherwise>
        <c:set var="styleClassName" value="media" />
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:set var="styleClassName" value="${relatedObject.content.articleTypeName}" />
  </c:otherwise>
</c:choose>

<%
  request.setAttribute(var,jspContext.getAttribute("styleClassName"));
%>