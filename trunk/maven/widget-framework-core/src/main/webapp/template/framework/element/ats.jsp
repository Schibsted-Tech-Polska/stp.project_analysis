<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/element/ats.jsp#2 $
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

<c:set var="contentType" value="${element.content.articleTypeName}"/>

<c:choose>
  <c:when test="${fn:startsWith(contentType,'widget_')}">
    <c:set var="widgetName" value="${fn:substringAfter(contentType, 'widget_')}" scope="request"/>
    <c:choose>
      <c:when test="${requestScope.isConfigSection}">
        <c:if test="${element.content.state == 'published'}">
          <div class="widget-div-main" id="widget-div-main-${element.content.id}">
            <h1><c:out value="${element.content.fields.title.value}" escapeXml="true"/></h1>
          </div>
          <wf-core:getArticleFieldsMap articleTypeName="${contentType}" publicationId="${publication.id}" content="${element.content}" var="panelsMap"/>
          <c:if test="${fn:length(panelsMap)>0}">
            <div class="widget-div-popup" id="widget-div-popup-${element.content.id}">
              <button class="popup-button" type="button" id="popup-button-${element.content.id}" >Hide</button>
              <c:forEach var="panel" items="${panelsMap}">
                <div class="popup-panel">
                  <h3><c:out value="${panel.key}" escapeXml="true"/></h3>
                  <c:if test="${fn:length(panel.value)>0}">
                    <ul>
                      <c:forEach var="field" items="${panel.value}">
                        <li><span style="color:black;"><c:out value="${field.key}" escapeXml="true"/></span>=<span style="color:cornflowerblue;"><c:out value="${field.value}" escapeXml="false"/></span></li>
                      </c:forEach>
                    </ul>
                  </c:if>
                </div>
              </c:forEach>
            </div>
            <script language="javascript" type="text/javascript">
              var configWidgetShowingPopupId = null;
              var configWidgetSelectedMainDivId = null;
              $(function(){
                showWidgetOnClick('${element.content.id}');
              });
              $('#popup-button-${element.content.id}').click(function(e) {
                hideWidget('${element.content.id}');
              });
            </script>
          </c:if>
        </c:if>
      </c:when>
      <c:otherwise>
        <wf-core:include widgetName="${widgetName}" />
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <h2  class="error">
      <fmt:message key="widget.invalid.error.message">
        <fmt:param value="${contentType}" />
      </fmt:message>
    </h2>
  </c:otherwise>
</c:choose>
