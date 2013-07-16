<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileStoryContent/src/main/webapp/template/widgets/mobileStoryContent/view/helpers/renderBody.jsp#2 $
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
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<article:renderField var="inlineElement" field="body">
  <c:choose>
    <c:when test="${inlineElement.content.articleTypeName == 'picture'}">
      <dxf:div cssClass="inline-image">
        <%-- Unfortunately it is not possible to get the width/height of the inline image as it is in Content Studio
             (by dragging the corners of the image), so therefore a hardcoded version is used instead. --%>
          <dxf:img src="${inlineElement.content.fields.alternates.value.w300.href}"
               size="100"
                   originalWidth="${inlineElement.content.fields.alternates.value.w300.width}"
               originalHeight="${inlineElement.content.fields.alternates.value.w300.height}"
               alt="${fn:trim(inlineElement.content.fields.caption)}"
               cssClass="${not empty fn:trim(inlineElement.content.fields.caption) ? 'captify' : ''}"/>
      </dxf:div>
    </c:when>
    <c:otherwise>
        <c:if test="${not empty inlineElement and not empty inlineElement.content}">
        <dxf:a href="${inlineElement.content.url}"><c:out value="${inlineElement.content.title}" escapeXml="true"/></dxf:a>
      </c:if>
    </c:otherwise>
  </c:choose>
</article:renderField>