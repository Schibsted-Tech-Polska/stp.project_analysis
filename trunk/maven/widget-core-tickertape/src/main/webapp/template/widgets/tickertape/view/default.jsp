<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-tickertape/src/main/webapp/template/widgets/tickertape/view/default.jsp#2 $
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
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- declare the map that contains field values--%>
<jsp:useBean id="tickertape" type="java.util.Map" scope="request"/>

<%-- load the javascript needed for displaying ti ckertape--%>
<script type="text/javascript" src="${resourceUrl}js/jquery.newsTicker1.2.2.js"></script>

<%-- render HTML --%>
<div class="${tickertape.wrapperStyleClass}" <c:if test="${not empty tickertape.styleId}">id="${tickertape.styleId}"</c:if>>
  <h4><c:out value="${tickertape.title}" escapeXml="true"/></h4>

  <div id="tickertape-${tickertape.uniqueSuffix}" class="news-items">
    <c:forEach var="articleSummary" items="${tickertape.articleSummaryList}">
      <h5><a href="${articleSummary.content.url}"><c:out value="${articleSummary.fields.title}" escapeXml="true"/></a></h5>
    </c:forEach>
  </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
      var options = {
        newsList: "#tickertape-${tickertape.uniqueSuffix}",
        startDelay: 10,
        placeHolder1: "",
        placeHolder2: ""
      };
      $().newsTicker(options);
    });
</script>