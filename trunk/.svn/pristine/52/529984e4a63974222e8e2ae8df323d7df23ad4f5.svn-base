<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/media.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related media view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request"/>

<c:set var="relatedMediaList" value="${relatedContents.media}"/>

<c:if test="${not empty relatedMediaList}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedMedia<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if> >
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>
    <ul>
      <c:forEach var="relatedMedia" items="${relatedMediaList}" varStatus="status">
        <wf-core:getFileTypeStyleClass var="styleClassName" relatedObject="${relatedMedia}"/>

        <c:choose>
          <c:when test="${empty fn:trim(relatedMedia.fields.headline)}">
            <c:set var="headline" value="${relatedMedia.content.fields.binary.value.title}"/>
          </c:when>
          <c:otherwise>
            <c:set var="headline" value="${relatedMedia.fields.headline}"/>
            <c:set var="inpageHeadlineClass" value="${relatedMedia.fields.headline.options.inpageClasses}"/>
          </c:otherwise>
        </c:choose>

        <li <c:if test="${status.first}">class='first'</c:if> >
          <p>
            <a onclick="return openLink(this.href,'_blank')" href="${relatedMedia.content.fields.binary.value.href}" class="${styleClassName} ${inpageHeadlineClass}">
              <c:out value="${headline}" escapeXml="true"/>
            </a>

            <c:if test="${relatedContents.showMimetype=='true'}">
              (<c:out value="${relatedMedia.content.fields.binary.value['mime-type']}" escapeXml="true"/>)
            </c:if>
          </p>

            <%-- dsiplay intro conditionally --%>
          <c:set var="intro" value="${fn:trim(relatedMedia.fields.intro)}"/>
          <c:set var="inpageIntroClass" value="${relatedMedia.fields.intro.options.inpageClasses}"/>
          <c:if test="${relatedContents.showIntro=='true' and not empty intro}">
            <wf-core:getCurtailedText var="curtailedIntro" inputText="${intro}"
                                        maxLength="${relatedContents.maxCharacters}" ellipsis="..."/>

            <p class="summary ${inpageIntroClass}">
                <c:out value="${curtailedIntro}" escapeXml="true"/>
            </p>
          </c:if>
        </li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>