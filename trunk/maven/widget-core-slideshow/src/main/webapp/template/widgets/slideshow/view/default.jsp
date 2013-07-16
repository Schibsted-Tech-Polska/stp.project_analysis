<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-slideshow/src/main/webapp/template/widgets/slideshow/view/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--This page generates the default HTML markup for the slideshow widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="slideshow" type="java.util.Map" scope="request"/>

<c:if test="${not empty slideshow.slideshowPictures}">
  <div class="${slideshow.wrapperStyleClass}" <c:if test="${not empty slideshow.styleId}">id="${slideshow.styleId}"</c:if>>
    <c:choose>
      <c:when test="${fn:length(slideshow.slideshowPictures) == 1}">
        <jsp:include page="helpers/picture.jsp" />
      </c:when>
      <c:otherwise>
        <jsp:include page="helpers/gallery.jsp" />
      </c:otherwise>
    </c:choose>
  </div>
</c:if>

<c:remove var="slideshow" scope="request"/>
