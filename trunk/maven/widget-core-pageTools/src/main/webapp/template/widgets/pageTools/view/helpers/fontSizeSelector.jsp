<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/view/helpers/fontSizeSelector.jsp#1 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%--The main controller have already set the map with values to be used by this jsp--%>
<jsp:useBean id="pageTools" class="java.util.HashMap" scope="request" />

<c:if test="${not empty sessionScope.pageToolsFontSize}">
  <script type="text/javascript">
    setFont('<c:out value="${sessionScope.useFontSelectorPageTools}" />', '${sessionScope.pageToolsFontSize}');
  </script>
</c:if>

<div class="enlarge-font">
  <a id="pageToolsSmallFont" class="small-font" href="#"><fmt:message key="pageTools.widget.fontsize.line"/></a>
  <a id="pagetToolsMediumFont" class="medium-font" href="#"><fmt:message key="pageTools.widget.fontsize.line"/></a>
  <a id="pageToolsLargeFont" class="large-font" href="#"><fmt:message key="pageTools.widget.fontsize.line"/></a>
</div>
<div class="email-link">
  <a id="openEmailBox" href="#"><fmt:message key="pageTools.widget.email.line"/></a>
</div>

<script type="text/javascript">
  $(document).ready(function() {
    $("#pageToolsSmallFont").click(function(event) {
      setFont('<c:out value="${sessionScope.useFontSelectorPageTools}" />', '${pageTools.smallFontSize}');
    <c:url var="pageToolsFontSizeUrl" value="${article.url}" scope="page">
    <c:param name="pageToolsFontSize" value="${pageTools.smallFontSize}"/>
    </c:url>
      $.get("${pageToolsFontSizeUrl}");
      event.preventDefault();
    });
    $("#pagetToolsMediumFont").click(function(event) {
      setFont('<c:out value="${sessionScope.useFontSelectorPageTools}" />', '${pageTools.mediumFontSize}');
    <c:url var="pageToolsFontSizeUrl" value="${article.url}">
    <c:param name="pageToolsFontSize" value="${pageTools.mediumFontSize}"/>
    </c:url>
      $.get("${pageToolsFontSizeUrl}");
      event.preventDefault();
    });
    $("#pageToolsLargeFont").click(function(event) {
      setFont('<c:out value="${sessionScope.useFontSelectorPageTools}" />', '${pageTools.largeFontSize}');
    <c:url var="pageToolsFontSizeUrl" value="${article.url}">
    <c:param name="pageToolsFontSize" value="${pageTools.largeFontSize}"/>
    </c:url>
      $.get("${pageToolsFontSizeUrl}");
      event.preventDefault();
    });
  });
</script>
<c:remove var="pageToolsFontSizeUrl" scope="page"/>