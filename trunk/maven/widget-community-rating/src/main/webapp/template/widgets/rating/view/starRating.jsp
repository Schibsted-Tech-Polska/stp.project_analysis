<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/view/starRating.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the rating widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile"%>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>

<%-- the controller has already set a Map named 'rating' in the requestScope --%>
<jsp:useBean id="rating" type="java.util.Map" scope="request"/>

<profile:present>
  <c:if test="${requestScope['com.escenic.context']=='art'}">
    <qual:qualification id="starRating" type="StarRating" />
    <c:set var="maxStars" value="${rating.maxStars+0}" />

    <fmt:message var="ratingTitleSuffix" key="rating.widget.starRating.title.suffix">
      <fmt:param value="${maxStars}" />  
    </fmt:message>

    <div class="${rating.wrapperStyleClass}" <c:if test="${not empty rating.styleId}">id="${rating.styleId}"</c:if> >
      <ul class="starRating" style="width:${maxStars*14}px;">
        <li class="currentRating" style="width:${starRating.average*14}px;">
          <c:out value="${starRating.average} ${ratingTitleSuffix}" escapeXml="true"/>
        </li>

        <c:forEach begin="1" end="${maxStars}" varStatus="status">
          <c:set var="styleClass" value="star${status.count}"/>
          <li>
            <a href="#" class="${styleClass}" title="${status.count} ${ratingTitleSuffix}"
               onclick="return submitStarRating(${article.id}, ${rating.user.id}, ${status.count}, this);">
              <c:out value="${status.count}" escapeXml="true"/>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
    
  </c:if>
</profile:present>

<c:remove var="rating" scope="request" />