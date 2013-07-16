<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/view/helpers/printContent.jsp#1 $
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

<script type="text/javascript">
  function printArticle(url){
    window.open(url,'print');
  }
</script>
<c:url var="printUrl" value="${article.url}">
  <c:param name="service" value="print"/>  
</c:url>

<div class="print-link">
  <a id="showPrintPage" href="#" onclick="printArticle('${printUrl}')">
    <fmt:message key="pageTools.widget.print.line"/>
  </a>
</div>