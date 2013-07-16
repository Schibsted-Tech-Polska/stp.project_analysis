<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-webAnalytics/src/main/webapp/template/widgets/webAnalytics/view/googleAnalytics.jsp#1 $
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

<jsp:useBean id="webAnalytics" type="java.util.Map" scope="request"/>

<c:if test="${not empty webAnalytics.accountId}">
  <script type="text/javascript">
    // <![CDATA[
    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
    document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    // ]]>
  </script>

  <script type="text/javascript">
    // <![CDATA[
    try{
      var pageTracker = _gat._getTracker("${webAnalytics.accountId}");

      <c:if test="${not empty webAnalytics.domainName}">
        pageTracker._setDomainName("${webAnalytics.domainName}");
      </c:if>

      pageTracker._trackPageview();
    }
    catch(err) {}
    // ]]>
  </script>
</c:if>

<c:remove var="webAnalytics" scope="request"/>







