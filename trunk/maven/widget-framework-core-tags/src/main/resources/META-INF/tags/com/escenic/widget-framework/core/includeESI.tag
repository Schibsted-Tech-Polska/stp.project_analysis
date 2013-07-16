<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/includeESI.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" dynamic-attributes="templateParameters" body-content="empty" pageEncoding="UTF-8"
        description="Include a template file via ESI or do a normal jsp:include if ESI support is not enabled" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ attribute name="templateFile" description="Template file to include" required="true" %>

<%-- ESI prefix: should be the same as in EsiFilter.properties! --%>
<c:set var="esiPrefix" value="/esi"/>
<jsp:useBean id="section" type="neo.xredsys.api.Section" scope="request"/>

<c:choose>
  <c:when test="${section.parameters['template.enableESI'] eq 'true'}">
    <%-- Note that we append the template path to the article or section URL. The EsiFilter class handles this so we
         never have to pass an article/section ID. --%>
    <c:set var="esiUrl" value="${not fn:startsWith(section.directoryPath, '/') ? '/' : ''}${requestScope['com.escenic.context']=='art' ? article.relativeUrl : ''}${esiPrefix}${templateFile}"/>
      <c:forEach var="templateParameter" items="${templateParameters}" varStatus="status">
		<c:choose>
			<c:when test="${status.first}">
	    			<c:set var="esiUrl" value="${esiUrl}?${templateParameter.key}=${templateParameter.value}"/>
	 		</c:when>
			<c:otherwise>
				<c:set var="esiUrl" value="${esiUrl}&${templateParameter.key}=${templateParameter.value}"/>
			</c:otherwise>
		</c:choose>
      </c:forEach>

    <c:forEach var="attr" items="${requestScope}">
      <util:logMessage category="template"
                       message="Req. attr ${attr.key}: ${attr.value}"
                       comment="Req. attr ${attr.key}: ${attr.value}"/>
    </c:forEach>

    <util:logMessage category="template" comment="ESI include: ${esiUrl}" message="ESI include: ${esiUrl}"/>
    <%-- The following line is to let IntelliJ stop whining about the unknown esi tag --%>
    <%--suppress XmlUnboundNsPrefix --%>
    <esi:include src="${esiUrl}"/>
  </c:when>
  <c:otherwise>
    <c:url var="jspUrl" value="${templateFile}" context="/">
      <c:forEach var="templateParameter" items="${templateParameters}">
        <c:param name="${templateParameter.key}" value="${templateParameter.value}"/>
      </c:forEach>
    </c:url>
    <util:logMessage category="template" comment="non-ESI include: ${jspUrl}" message="non-ESI include: ${jspUrl}"/>
    <jsp:include page="${jspUrl}"/>
  </c:otherwise>
</c:choose>
