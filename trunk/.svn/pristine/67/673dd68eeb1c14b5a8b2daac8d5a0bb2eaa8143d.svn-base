<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-storyContent/src/main/webapp/template/widgets/storyContent/view/helpers/renderBody.jsp#1 $
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

<article:renderField var="inlineElement" field="body">
  <c:choose>
    <c:when test="${inlineElement.content.articleTypeName == 'picture'}">
      <div class="inline-image">
        <%-- Unfortunately it is not possible to get the width/height of the inline image as it is in Content Studio
             (by dragging the corners of the image), so therefore a hardcoded version is used instead. --%>
          <img src="${inlineElement.content.fields.alternates.value.w300.href}"
               width="${inlineElement.content.fields.alternates.value.w300.width}"
               height="${inlineElement.content.fields.alternates.value.w300.height}"
               alt="${fn:trim(inlineElement.content.fields.caption)}"
               ${not empty fn:trim(inlineElement.content.fields.caption) ? 'class="captify"' : ''}
               title="${inlineElement.content.fields.caption}"/>
      </div>
    </c:when>
    <c:otherwise>
      <a href="${inlineElement.content.url}"><c:out value="${inlineElement.content.title}"/></a>
    </c:otherwise>
  </c:choose>
</article:renderField>