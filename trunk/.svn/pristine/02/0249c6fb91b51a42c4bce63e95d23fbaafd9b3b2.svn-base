<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-widget/include.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ tag language="java" body-content="empty" dynamic-attributes="widgetParams" %>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.escenic.com/widget-framework/core" prefix="wf-core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%@ attribute name="widgetName" required="true" description="Name of the widget" %>

<%--
  -- This tag expects the following request attributes set:
  --    * element (the widget configuration article)
  --
  -- The widget will be included via an esi:include if the widget supports ESI (the field "enableESI" is set to true),
  -- otherwise it will do a normal template:call.
  --%>

<jsp:useBean id="publication" type="neo.xredsys.api.Publication" scope="request"/>
<jsp:useBean id="element" type="neo.xredsys.presentation.PresentationElement" scope="request"/>

<c:if test="${element.content.stateName == 'published'}">
  <util:logMessage category="template"
                   message="including the widget ${pageScope.widgetName}"
                   comment="including the widget ${pageScope.widgetName}"/>

  <%-- Get the value of the content type parameter. If it's "true" the widget supports ESI includes --%>
  <c:set var="useESI" value="${element.content.fields.enableESI.value}"/>

  <util:logMessage category="template"
                   message="widget ${pageScope.widgetName} supports ESI: ${not empty useESI and useESI eq true}"
                   comment="widget ${pageScope.widgetName} supports ESI: ${not empty useESI and useESI eq true}"/>

  <wf-core:present name="${pageScope.widgetName}">
    <c:set var="widgetContent" scope="request" value="${element.content}"/>
    <c:choose>
      <c:when test="${not empty useESI and useESI eq true}">
        <c:url var="templateFile" value="/template/widgets/${pageScope.widgetName}/index.jsp" context="/">
          <%-- Pass the article ID of the widget configuration article --%>
          <c:param name="widgetContentId" value="${element.content.id}"/>
          <c:param name="currentAreaName" value="${requestScope.currentAreaName}"/>
          <c:param name="contentAreaName" value="${requestScope.contentAreaName}"/>
          <c:param name="elementwidth" value="${requestScope.elementwidth}"/>
          <%-- Also make request parameters available to the esi-included part --%>
          <c:forEach var="requestParam" items="${param}">
            <c:param name="${requestParam.key}" value="${requestParam.value}"/>
          </c:forEach>
          <c:if test="${not empty widgetParams && fn:length(widgetParams) > 0}">
            <c:forEach var="widgetParam" items="${widgetParams}">
              <c:param name="${widgetParam.key}" value="${widgetParam.value}"/>
            </c:forEach>
          </c:if>
        </c:url>
        <wf-core:includeESI templateFile="${templateFile}"/>
      </c:when>
      <c:otherwise>
        <template:call file="/template/widgets/${pageScope.widgetName}/index.jsp">
          <c:if test="${not empty widgetParams && fn:length(widgetParams) > 0}">
            <c:forEach var="widgetParam" items="${widgetParams}">
              <template:parameter key="${widgetParam.key}" value="${widgetParam.value}"/>
            </c:forEach>
          </c:if>
        </template:call>
      </c:otherwise>
    </c:choose>
  </wf-core:present>

  <wf-core:notPresent name="${pageScope.widgetName}">
    Widget with name '${pageScope.widgetName}' is not present or properly configured.
  </wf-core:notPresent>

  <util:logMessage category="template"
                   message="finished including the widget ${pageScope.widgetName}"
                   comment="finished including the widget ${pageScope.widgetName}"/>
</c:if>