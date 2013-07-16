<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileTwitter/src/main/webapp/template/widgets/mobileTwitter/view/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<jsp:useBean id="mobileTwitter" type="java.util.HashMap" scope="request"/>

<c:choose>
  <c:when test="${mobileTwitter.mode eq 'username'}">
    <dxw:twitter var="twitterResult" user="${mobileTwitter.userName}" page="1" count="${mobileTwitter.count}"/>
  </c:when>
  <c:otherwise>
    <dxw:twitter var="twitterResult" search="${mobileTwitter.searchWord}" page="1" count="${mobileTwitter.count}"/>
  </c:otherwise>
</c:choose>

<c:set var="loopCount" value="0"/>

<dxf:div cssClass="${mobileTwitter.wrapperStyleClass}">
  <c:forEach var="tweet" items="${twitterResult}" varStatus="loopStatus">
    <c:if test="${loopCount < mobileTwitter.count}">
      <dxw:article title="${tweet.text}"/>
      <c:set var="loopCount" value="${loopCount + 1}"/>      
    </c:if>
  </c:forEach>
</dxf:div>

<c:remove var="mobileTwitter" scope="request"/>
