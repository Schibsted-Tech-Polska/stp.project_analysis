<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/wrap/default.jsp#2 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--
  this JSP page expects the following objects in the request scope, if any of them is missing, then this page will not work
--%>
<jsp:useBean id="floatingContentsItems" type="java.util.List<neo.xredsys.presentation.PresentationElement>" scope="request" />
<jsp:useBean id="mainContentsItems" type="java.util.List<neo.xredsys.presentation.PresentationElement>" scope="request" />
<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request" />
<jsp:useBean id="floatingGroupOptions" type="java.util.Map" scope="request" />

<%-- at first display the floating contents --%>
<collection:createList id="floatingContentsWidgetsList" type="java.util.ArrayList"/>
<c:forEach var="floatingContentsItem" items="${floatingContentsItems}">
  <c:if test="${fn:startsWith(floatingContentsItem.content.articleTypeName,'widget_')}">
    <collection:add collection="${floatingContentsWidgetsList}" value="${floatingContentsItem}" />
  </c:if>
</c:forEach>

<c:set var="mainContentWidth" value="${requestScope['elementwidth']}" />

<c:if test="${not empty floatingContentsWidgetsList}">
  <c:forEach var="floatingContentsWidget" items="${floatingContentsWidgetsList}">
    <c:set var="floatingItemWidth" value="${fn:trim(floatingContentsWidget.options['width'])}" />
    <wf-core:getEnumFieldValue var="strippedFloatingItemWidth" value="${floatingItemWidth}" />
    <c:set var="floatingItemWidth" value="${strippedFloatingItemWidth}" />
    <c:if test="${empty floatingItemWidth}">
      <c:set var="floatingItemWidth" value="140" />
    </c:if>

    <c:set var="floatingItemPosition" value="${fn:trim(floatingContentsWidget.options['position'])}" />
    <wf-core:getEnumFieldValue var="strippedFloatingItemPosition" value="${floatingItemPosition}" />
    <c:set var="floatingItemPosition" value="${strippedFloatingItemPosition}" />
    <c:if test="${empty floatingItemPosition}">
      <c:set var="floatingItemPosition" value="right" />
    </c:if>

    <!--read individual item style class and style id-->
    <c:set var="floatingItemStyleClass" value="${fn:trim(floatingContentsWidget.options['customStyleClass'])}" />
    <c:set var="floatingItemStyleId" value="${fn:trim(floatingContentsWidget.options['styleId'])}" />

    <div <c:if test="${not empty floatingItemStyleId}">id="${floatingItemStyleId}"</c:if>  class="floatingContent-${floatingItemPosition} ${floatingItemStyleClass}" style="width:${floatingItemWidth}px;">
      <c:set var="elementwidth" value="${floatingItemWidth}" scope="request" />
      <c:set var="widgetName" value="${fn:substringAfter(floatingContentsWidget.content.articleTypeName, 'widget_')}" scope="request"/>
      <c:set var="element" value="${floatingContentsWidget}" scope="request"/>
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
      <c:remove var="element" scope="request" />
      <c:remove var="widgetName" scope="request" />
      <c:remove var="elementwidth" scope="request" />
    </div>
  </c:forEach>
</c:if>

<%-- now display the main contents --%>
<collection:createList id="mainContentsWidgetsList" type="java.util.ArrayList"/>
<c:forEach var="mainContentsItem" items="${mainContentsItems}">
  <c:if test="${fn:startsWith(mainContentsItem.content.articleTypeName,'widget_')}">
    <collection:add collection="${mainContentsWidgetsList}" value="${mainContentsItem}" />
  </c:if>
</c:forEach>

<c:if test="${not empty mainContentsWidgetsList}">
  <!--set group's style class and style id to the wrapper of main contents-->
  <c:set var="customStyleClass" value="${floatingGroupOptions.customStyleClass}" />
  <c:set var="customStyleId" value="${floatingGroupOptions.styleId}" />

  <div <c:if test="${not empty customStyleId}">id="${customStyleId}"</c:if> class="wrappingContent ${customStyleClass}">
    <c:forEach var="mainContentsWidget" items="${mainContentsWidgetsList}">
      <c:set var="elementwidth" value="${mainContentWidth}" scope="request" />
      <c:set var="widgetName" value="${fn:substringAfter(mainContentsWidget.content.articleTypeName, 'widget_')}" scope="request"/>
      <c:set var="element" value="${mainContentsWidget}" scope="request"/>
      <c:choose>
        <c:when test="${requestScope.isConfigSection}">
          <c:if test="${element.content.state == 'published'}">
            <div class="widget-div-main" id="widget-div-main-${element.content.id}">
              <h1>${element.content.fields.title.value}</h1>
            </div>
            <wf-core:getArticleFieldsMap articleTypeName="${contentType}" publicationId="${publication.id}" content="${element.content}" var="panelsMap"/>
            <c:if test="${fn:length(panelsMap)>0}">
              <div class="widget-div-popup" id="widget-div-popup-${element.content.id}">
                <button class="popup-button" type="button" id="popup-button-${element.content.id}" >Hide</button>
                <c:forEach var="panel" items="${panelsMap}">
                  <div class="popup-panel">
                    <h3>${panel.key}</h3>
                    <c:if test="${fn:length(panel.value)>0}">
                      <ul>
                        <c:forEach var="field" items="${panel.value}">
                          <li><span style="color:black;">${field.key}</span>=<span style="color:cornflowerblue;">${field.value}</span></li>
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
      <c:remove var="element" scope="request" />
      <c:remove var="widgetName" scope="request" />
      <c:remove var="elementwidth" scope="request" />
    </c:forEach>
  </div>
</c:if>

<c:set var="elementwidth" value="${mainContentWidth}" scope="request" />

<div class="clearfix"><!-- clear --></div>