<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/view/row.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%--declare the map that contains relevant field values --%>

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>

<div class="${trailers.wrapperStyleClass} ${trailers.inpageDnDAreaClass}" <c:if test="${not empty trailers.styleId}">id="${trailers.styleId}"</c:if>>
  <c:forEach var="articleMap" items="${trailers.articleMapList}" varStatus="loopStatus">
    <c:if test="${loopStatus.count <= trailers.trailerColumnCount}">
      <div class="trailer w${trailers.trailerWidthRow} ${articleMap.trailerStyleClass}">
        <c:if test="${trailers.showSectionName}">
          <h5><c:out value="${articleMap.homeSectionName}" escapeXml="true"/></h5>
        </c:if>
        <c:set var="articleAttributeMap" value="${articleMap}" scope="request"/>
        <jsp:include page="helpers/articleList.jsp"/>
        <c:remove var="articlePropertyMap" scope="request"/>
      </div>
    </c:if>
  </c:forEach>
</div>
<c:remove var="trailers" scope="request"/>

