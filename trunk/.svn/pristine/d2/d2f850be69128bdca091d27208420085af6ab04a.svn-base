<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/factboxes.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />


<c:set var="relatedFactboxes" value="${relatedContents.factboxes}" />
<c:if test="${not empty relatedFactboxes}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedFactboxes<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if>>
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>

    <c:forEach items="${relatedFactboxes}" var="relatedFactbox" varStatus="status">
      <div class="relatedFactbox" >
        <%-- Step 1: show the image --%>
        <c:if test="${relatedContents.showImageFactBox == 'true'}">
          <%-- check if there is any related image --%>
          <c:if test="${not empty relatedFactbox.images}">
            <c:forEach items="${relatedFactbox.images}" var="relatedImage" begin="0" end="0">
              <c:set var="imageVersion" value="${relatedContents.imageVersionFactBox}" />
              <c:choose>
              <%-- Step 1.1: if soft crop, show cropped image --%>
                <c:when test="${relatedContents.softCropFactBox=='true'}">
                  <img src="${relatedImage.content.fields.alternates.value[imageVersion].href}"
                     width="${relatedImage.content.fields.alternates.value[imageVersion].width}"
                     height="${relatedImage.content.fields.alternates.value[imageVersion].height}"
                     alt="${relatedImage.content.fields.alttext}"
                     title="${relatedImage.content.fields.caption}"
                     class="${relatedImage.content.fields.alternates.value[imageVersion].inpageClasses}"/>
                </c:when>
              <%-- Step 1.2: if not soft crop, show image version --%>
                <c:otherwise>
                  <img src="${relatedImage.content.fields.binary.value[imageVersion]}"
                     alt="${relatedImage.content.fields.alttext}"
                     title="${relatedImage.content.fields.caption}" />
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </c:if>
        </c:if>

        <%-- Step 2: show the title --%>
        <c:if test="${relatedContents.showTitleFactBox == 'true'}">
          <h4 class="${relatedFactbox.inpageTitleClass}"><c:out value="${relatedFactbox.title}" escapeXml="true"/></h4>
        </c:if>

        <%-- Step 3: show the body --%>
        <c:if test="${relatedContents.showBodyFactBox == 'true'}">
          <p class="${relatedFactbox.inpageBodyClass}"><c:out value="${relatedFactbox.body}" escapeXml="true"/></p>
        </c:if>
      </div>
    </c:forEach>
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>