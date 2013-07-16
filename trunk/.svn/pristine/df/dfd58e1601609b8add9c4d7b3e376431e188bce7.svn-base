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
<%--
This tag includes the common controller, view specific controller and the view jsp for a particular widget, in
that sequence.

Attributes :
  widgetName : name of the widget (mandatory)
  view : name of the view in use (optional, defaults to the field value 'view' specified in widget)
  controller : name of the controller to use (optional, defaults to the name of the view)
--%>
<%@ tag language="java" body-content="empty" %>
<%@ taglib uri="http://www.escenic.com/widget-framework/core" prefix="wf-core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%@ attribute name="widgetName" required="true" rtexprvalue="true" %>
<%@ attribute name="view" required="false" rtexprvalue="true" %>
<%@ attribute name="controller" required="false" rtexprvalue="true" %>
<%@ attribute name="skipController" required="false" rtexprvalue="true" %>

<%-- include the common controller --%>
<util:logMessage category="template"
                 message="including common controller for widget ${pageScope.widgetName}"
                 comment="including common controller for widget ${pageScope.widgetName}" />

<%--
  TODO: once the keys in the hashmap are constitent with widget field names (case insensitive), this generic controller can be used to replace most of the widget's first controller
  <wf-core:controller var="${widgetName}" />
--%>

<jsp:include page="/template/widgets/${widgetName}/controller/controller.jsp" />

<util:logMessage category="template"
                 message="successfully included common controller for widget ${pageScope.widgetName}"
                 comment="successfully included common controller for widget ${pageScope.widgetName}" />

<%-- find the name of the view to use--%>
<c:choose>
  <c:when test="${empty pageScope.view}">
    <c:set var="view" value="${requestScope[widgetName].view}"/>
  </c:when>
  <c:otherwise>
    <c:set target="${requestScope[widgetName]}" property="view" value="${pageScope.view}"/>
  </c:otherwise>
</c:choose>

<%-- find the name of the controller to use. None, same as view or custom name --%>

<c:if test="${pageScope.skipController != 'true'}">
  <c:if test="${empty pageScope.controller}">
    <c:set var="controller" value="${pageScope.view}" scope="page"/>
  </c:if>

  <%-- include the controller --%>
  <util:logMessage category="template"
                   message="including controller ${pageScope.controller} for widget ${pageScope.widgetName}"
                   comment="including controller ${pageScope.controller} for widget ${pageScope.widgetName}"/>

  <jsp:include page="/template/widgets/${pageScope.widgetName}/controller/${pageScope.controller}.jsp"/>

  <util:logMessage category="template"
                   message="successfully included controller ${pageScope.controller} for widget ${pageScope.widgetName}"
                   comment="successfully included controller ${pageScope.controller} for widget ${pageScope.widgetName}"/>

</c:if>

<%-- Dump variables set by the controller(s) --%>
<c:forEach var="widgetVar" items="${requestScope[widgetName]}">
    <util:logMessage category="template"
                     message="Widget ${widgetName} k=${widgetVar.key},v=${widgetVar.value}"
                     comment="Widget ${widgetName} k=${widgetVar.key},v=${widgetVar.value}" />
</c:forEach>

<%--re-reading the value of view is necessary because the view specific controller may override the value of view --%>
<c:set var="view" value="${requestScope[widgetName].view}"/>

<%-- include view page --%>
<util:logMessage category="template"
                 message="including view ${pageScope.view} for widget ${pageScope.widgetName}"
                 comment="including view ${pageScope.view} for widget ${pageScope.widgetName}" />

<%-- check if custom view page exists for the widget in question --%>
<wf-core:exists id="customViewExists" type="view" widgetName="${pageScope.widgetName}" name="${pageScope.view}" />

<c:choose>
  <c:when test="${requestScope.customViewExists}">
    <jsp:include page="/template/widgets/${pageScope.widgetName}/view/custom/${pageScope.view}.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="/template/widgets/${pageScope.widgetName}/view/${pageScope.view}.jsp"/>
  </c:otherwise>
</c:choose>

<c:remove var="customViewExists" scope="request"/>

<util:logMessage category="template"
                 message="successfully included view ${pageScope.view} for widget ${pageScope.widgetName}"
                 comment="successfully included view ${pageScope.view} for widget ${pageScope.widgetName}" />











