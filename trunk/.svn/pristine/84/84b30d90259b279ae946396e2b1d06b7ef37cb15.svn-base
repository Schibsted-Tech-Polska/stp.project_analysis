<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/view/newsletter.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this page renders the default view of the picture widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.HashMap" scope="request"/>

<c:if test="${not empty picture.items}">
  <table class="${picture.wrapperStyleClass}" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top" style="border-top:1px dashed #D9D9D9;">
        <c:if test="${picture.showWidgetName=='true'}">
          <h5>
              <c:out value="${picture.widgetName}" escapeXml="true"/>
          </h5>
        </c:if>
      </td>
    </tr>
    <c:forEach var="pictureItem" items="${picture.items}">
      <tr>
        <c:set var="imageVersion" value="${picture.imageVersion}"/>
        <td valign="top">
          <c:choose>
            <c:when test="${picture.softCrop}">
              <a href="${pictureItem.content.url}">
                <img src="${pictureItem.content.fields.alternates.value[imageVersion].href}"
                     width="${pictureItem.content.fields.alternates.value[imageVersion].width}"
                     height="${pictureItem.content.fields.alternates.value[imageVersion].height}"
                     alt="${pictureItem.content.fields.alttext}"
                     title="${pictureItem.fields.caption}"/>
              </a>
            </c:when>
            <c:otherwise>
              <a href="${pictureItem.content.url}">
                <img src="${pictureItem.content.fields.binary.value[imageVersion]}"
                     alt="${pictureItem.content.fields.alttext}"
                     title="${pictureItem.fields.caption}"/>
              </a>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </table>
</c:if>




