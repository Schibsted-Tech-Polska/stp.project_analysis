<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/view/helpers/tags.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="storyContent" type="java.util.Map" scope="request"/>

<c:forEach var="tag" items="${storyContent.tagList}" varStatus="loopStatus">
  <c:choose>
    <c:when test="${loopStatus.first}">
      <c:set var="tagNames" value="${tag.name}"/>
    </c:when>
    <c:otherwise>
      <c:set var="tagNames" value="${tagNames}, ${tag.name}"/>
    </c:otherwise>
  </c:choose>
</c:forEach>

<div class="tagLabel">
  <fmt:message key="storyContent.tags.label"/> :
</div>
<div class="tagNames">
  <c:out value="${tagNames}" escapeXml="true"/>
</div>
