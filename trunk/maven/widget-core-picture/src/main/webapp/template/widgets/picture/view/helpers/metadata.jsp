<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-picture/src/main/webapp/template/widgets/picture/view/helpers/metadata.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'picture' in the requestScope --%>
<jsp:useBean id="picture" type="java.util.Map" scope="request"/>

<table cellspacing="1">
  <tr>
    <th><fmt:message key="picture.widget.article.metadata.key.headline" /></th>
    <th><fmt:message key="picture.widget.article.metadata.value.headline" /></th>
  </tr>
  <c:forEach var="metadataEntry" items="${picture.metadata}" varStatus="status">
    <c:set var="metadataEntryKey" value="${fn:trim(metadataEntry.key)}" />
    <c:set var="metadataEntryValue" value="${fn:trim(metadataEntry.value)}" />

    <tr class="${status.count mod 2 == 0 ? 'even' : 'odd'}">
      <td><c:out value="${metadataEntryKey}" escapeXml="true"/> </td>
      <c:choose>
        <c:when test="${fn:toLowerCase(metadataEntryKey) == 'last-modified'}">
          <td>
            <wf-core:getDateObject var="lastModifiedDate" timeInMillis="${fn:trim(metadataEntryValue)}" />
            <fmt:formatDate value="${lastModifiedDate}" pattern="${picture.dateFormat}" />
          </td>
        </c:when>
        <c:when test="${fn:toLowerCase(metadataEntryKey) == 'content-length'}">
          <td><c:out value="${metadataEntryValue}" escapeXml="true"/> bytes</td>
        </c:when>        
        <c:when test="${fn:toLowerCase(metadataEntryKey) == 'width' or
                        fn:toLowerCase(metadataEntryKey) == 'height'}">
          <td><c:out value="${metadataEntryValue}" escapeXml="true"/>px</td>
        </c:when>
        <c:otherwise>
          <td><c:out value="${metadataEntryValue}" escapeXml="true"/></td>
        </c:otherwise>
      </c:choose>
    </tr>
  </c:forEach>
</table>