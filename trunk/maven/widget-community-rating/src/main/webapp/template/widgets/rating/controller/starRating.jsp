  <%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-rating/src/main/webapp/template/widgets/rating/controller/starRating.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>  
<%-- this is controller for the starRating view of rating widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the general controller has already set a Map named 'rating' in the requestScope --%>
<jsp:useBean id="rating" type="java.util.Map" scope="request"/>

<c:set var="maxStars" value="${fn:trim(widgetContent.fields.maxStars)}" />
<c:if test="${empty maxStars}">
  <c:set var="maxStars" value="5" />  
</c:if>

<c:set target="${rating}" property="maxStars" value="${maxStars}"/>

