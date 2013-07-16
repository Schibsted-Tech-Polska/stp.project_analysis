<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/view/favorite.jsp#2 $
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

<%-- the controller has already set a Map named 'rating' in the requestScope --%>
<jsp:useBean id="rating" type="java.util.Map" scope="request"/>

<c:if test="${requestScope['com.escenic.context']=='art'}">
  <div class="${rating.wrapperStyleClass}" <c:if test="${not empty rating.styleId}">id="${rating.styleId}"</c:if> >
    <p class="${rating.view}">
      <profile:present>
        <c:if test="${rating.isFavorite == false}">
          <a onclick="return submitFavorite(${article.id},${rating.user.id}, this, '${rating.favoriteSelfResultText}');"
             href="#">${rating.favoriteLinkText}</a>
            <c:if test="${not empty rating.favoriteResultText}">
              &nbsp;-&nbsp;
            </c:if>
        </c:if>
      </profile:present>
      <c:if test="${not empty rating.favoriteResultText}">
        <span><c:out value="${rating.favoriteResultText}" escapeXml="true"/></span>
      </c:if>
    </p>
  </div>
</c:if>

<c:remove var="rating" scope="request" />