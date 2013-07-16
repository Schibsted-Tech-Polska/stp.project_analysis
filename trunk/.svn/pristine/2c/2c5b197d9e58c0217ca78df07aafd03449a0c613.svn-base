<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/links.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related links view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedLinks" value="${relatedContents.links}" />

<c:if test="${not empty relatedLinks}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedLinks<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if>>
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>
    
    <ul>
      <c:forEach var="relatedLink" items="${relatedLinks}" varStatus="status">
        <li <c:if test="${status.first}">class="first"</c:if> >
          <a target="${relatedContents.linkTarget}" href="${relatedLink.content.fields.url}" class="${relatedLink.fields.title.options.inpageClasses}">
            <c:out value="${relatedLink.fields.title}" escapeXml="true"/>
          </a>
        </li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>