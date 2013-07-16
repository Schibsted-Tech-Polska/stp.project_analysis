<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/view/pictures.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the related pictures view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the controller has already set a HashMap named 'relatedContents' in the requestScope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request" />

<c:set var="relatedPictures" value="${relatedContents.pictures}" />

<c:if test="${not empty relatedPictures}">
  <%--<c:set var="allClasses">${relatedContents.styleClass} relatedPictures<c:if test="${not empty relatedContents.customStyleClass}"> ${relatedContents.customStyleClass}</c:if></c:set>--%>
  <div class="${relatedContents.wrapperStyleClass}" <c:if test="${not empty relatedContents.styleId}">id="${relatedContents.styleId}"</c:if>>
    <c:if test="${relatedContents.showHeadline}">
      <h5><c:out value="${relatedContents.headline}" escapeXml="true"/></h5>
    </c:if>    

    <c:forEach var="relatedPicture" items="${relatedPictures}" varStatus="status">
      <div class="relatedPicture" onclick="location.href='${relatedPicture.content.fields.binary.value.original}';">
        <c:set var="imageVersion" value="${relatedContents.imageVersion}" />
        <c:set var="pictureCaption" value="${fn:trim(relatedPicture.fields.caption)}" />
        <c:choose>
          <c:when test="${relatedContents.softCrop=='true'}">
            <c:choose>
              <c:when test="${relatedContents.showCaption=='true' and not empty pictureCaption}">
                <c:set var="imageStyleClass"
                       value="captify ${relatedPicture.content.fields.alternates.value[imageVersion].inpageClasses}"/>
              </c:when>
              <c:otherwise>
                <c:set var="imageStyleClass"
                       value="${relatedPicture.content.fields.alternates.value[imageVersion].inpageClasses}"/>
              </c:otherwise>
            </c:choose>
            <img src="${relatedPicture.content.fields.alternates.value[imageVersion].href}"
                 width="${relatedPicture.content.fields.alternates.value[imageVersion].width}"
                 height="${relatedPicture.content.fields.alternates.value[imageVersion].height}"
                 alt="${pictureCaption}"
                 class="${imageStyleClass}"
                 title="${relatedPicture.fields.caption}"/>
          </c:when>
          <c:otherwise>
            <img src="${relatedPicture.content.fields.binary.value[imageVersion]}"
                 alt="${pictureCaption}"
                 <c:if test="${relatedContents.showCaption=='true' and not empty pictureCaption}">
                   class="captify"
                 </c:if>
                 title="${relatedPicture.fields.caption}"/>
          </c:otherwise>
        </c:choose>
      </div>
    </c:forEach>
  </div>
</c:if>

<c:remove var="relatedContents" scope="request"/>