<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-community/src/main/webapp/template/framework/navigation/head.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--Make sure that the right bundle is being used--%>
<c:if test="${not empty section.parameters['language.code']}">
  <c:set var="locale">
    ${section.parameters['language.code']}
  </c:set>
  <fmt:setLocale scope="session" value="${locale}"/>
  <fmt:setBundle scope="session" basename="com.escenic.framework.ApplicationResources"/>
</c:if>

<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request"/>
<jsp:useBean id="skinName" type="java.lang.String" scope="request"/>

<c:set var="area" value="meta" scope="request"/>
<jsp:include page="../group/getitems.jsp"/>
<c:remove var="area" scope="request"/>

<%--Iterating over the items--%>
<c:forEach var="item" items="${requestScope.items}">
  <c:if test="${fn:startsWith(item.type, 'widget_')}">
    <c:set var="element" value="${item}" scope="request"/>
    <wf-core:include widgetName="${fn:substringAfter(item.type,'widget_')}"/>
    <c:remove var="element" scope="request"/>
  </c:if>
</c:forEach>

<c:remove var="items" scope="request"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" type="text/css" href="${publication.url}skins/${skinName}/css/global.css"/>
<link rel="stylesheet" type="text/css" href="${publication.url}skins/${skinName}/css/grid.css"/>
<link rel="stylesheet" type="text/css" href="${publication.url}skins/${skinName}/css/${skinName}.css"/>
<link rel="stylesheet" type="text/css" href="${publication.url}skins/${skinName}/css/custom.css"/>
<link rel="stylesheet" type="text/css" href="${publication.url}skins/${skinName}/css/jquery-ui-1.7.3.custom.css"/>
<link rel="pingback" href="${publication.url}xmlrpc"/>

<script type="text/javascript" src="${resourceUrl}js/swfobject.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery-ui-1.7.3.custom.min.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery.charcounter.js"></script>

<script type="text/javascript" src="${resourceUrl}js/jquery.tools.min.js"></script>

<script type="text/javascript" src="${resourceUrl}js/jqDnR.min.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery.jqpopup.min.js"></script>
<script type="text/javascript" src="${resourceUrl}js/jquery.form.js"></script>
<script type="text/javascript" src="${resourceUrl}js/captify.js"></script>
<script type="text/javascript" src="${resourceUrl}js/tiny_mce/tiny_mce.js"></script>

<script type="text/javascript" src="${resourceUrl}js/widget-framework-util.js"></script>

<script type='text/javascript' language="javascript" src='${resourceUrl}js/flowplayer-3.1.4.min.js'></script>

<script type='text/javascript' language="javascript" src='${publication.url}dwr/interface/QualificationPluginAjax.js'></script>
<script type='text/javascript' language="javascript" src='${publication.url}dwr/engine.js'></script>
<script type='text/javascript' language="javascript" src='${publication.url}dwr/util.js'></script>
<script type='text/javascript' language="javascript" src='${resourceUrl}js/yahooUtil.js'></script>
<script type='text/javascript' language="javascript" src='${resourceUrl}js/qualification.js'></script>

<%-- include the special template for viziwyg support--%>
<%-- <jsp:include page="../../framework/inpage/inpage.jsp"/> --%>

<%-- Put all code that should be run once the document has been loaded in this file: init.js --%>
<script type="text/javascript" src="${resourceUrl}js/init.js"></script>

<%-- we may have some inlineStyle in the requestScope set by the style widget --%>
<c:if test="${not empty requestScope.inlineStyle}">
  <style type="text/css">
    ${requestScope.inlineStyle}
  </style>
</c:if>

<c:remove var="inlineStyle" scope="request" />

<title>
  <c:choose>
    <c:when test="${requestScope['com.escenic.context']=='art'}">
      <c:out value="${article.title}" escapeXml="true"/> -
    </c:when>
    <c:when test="${section.uniqueName != 'ece_frontpage'}">
      <c:out value="${section.name}" escapeXml="true"/> -
    </c:when>
  </c:choose>

  <fmt:message key="publication.skin.${skinName}.title"/>
</title>
