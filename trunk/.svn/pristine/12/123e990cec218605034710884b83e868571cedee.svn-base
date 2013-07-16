<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/view/flagging.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the flagging view of rating widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile"%>
<%@ taglib prefix="qual" uri="http://www.escenic.com/taglib/escenic-qualification" %>

<%-- the controller has already set a Map named 'rating' in the requestScope --%>
<jsp:useBean id="rating" type="java.util.Map" scope="request"/>

<profile:present>
  <c:if test="${requestScope['com.escenic.context']=='art'}">
    <div class="${rating.wrapperStyleClass}" <c:if test="${not empty rating.styleId}">id="${rating.styleId}"</c:if> >
      <qual:hasQualified id="hasFlagged" type="flagging"/>
      <p class="${rating.view}">
        <c:choose>
          <c:when test="${hasFlagged!=true}">
            <a href="#" onclick="return submitFlagging(${article.id}, ${rating.user.id}, this, '${rating.flaggingResultText}');"><%--
            --%>${rating.flaggingLinkText}<%--
            --%></a>
          </c:when>
          <c:otherwise>
            <c:out value="${rating.flaggingResultText}" escapeXml="true"/>
          </c:otherwise>
        </c:choose>
      </p>
    </div>
  </c:if>
</profile:present>

<c:remove var="rating" scope="request" />