<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/stories.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related stories view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedStories" value="${relatedContents.stories}" />

<c:if test="${not empty relatedStories}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedStories<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if>>
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>    

    <ul>
      <c:forEach var="relatedStory" items="${relatedStories}" varStatus="status">
        <li <c:if test="${status.first}">class="first"</c:if> >
          <%-- display headline with link --%>
          <p>
            <a href="${relatedStory.content.url}" class="${relatedStory.fields.title.options.inpageClasses}">
              <c:out value="${relatedStory.fields.title}" escapeXml="true"/>
            </a>
          </p>

          <c:set var="intro" value="${fn:trim(relatedStory.fields.leadtext)}"/>
          <c:if test="${relatedContents.showIntro=='true' and not empty intro}">
            <wf-core:getCurtailedText var="curtailedIntro" inputText="${intro}" maxLength="${relatedContents.maxCharacters}" ellipsis="..."/>

            <p class="summary ${relatedStory.fields.leadtext.options.inpageClasses}"><c:out value="${curtailedIntro}" escapeXml="true"/></p>
          </c:if>

          <c:if test="${relatedContents.dateline!='hide'}">
            <c:set var="date"
                   value="${dateline=='lastModified' ? relatedStory.content.lastModifiedDateAsDate : relatedStory.content.publishedDateAsDate}" />
    
            <p class="dateline">
              <fmt:formatDate value="${date}" pattern="${relatedContents.dateFormat}" />
            </p>
          </c:if>
        </li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>