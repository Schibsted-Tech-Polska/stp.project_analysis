<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/tabs/default.jsp#2 $
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

<%-- this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="tabItemsList" type="java.util.List<neo.xredsys.presentation.PresentationElement>" scope="request" />
<jsp:useBean id="tabUniqueId" type="java.lang.String" scope="request" />
<jsp:useBean id="tabWidth" type="java.lang.String" scope="request" />
<jsp:useBean id="tabEvent" type="java.lang.String" scope="request" />

<c:set var="tempTabUniqueId" value="${requestScope.tabUniqueId}"/>
<c:set var="tempTabEvent" value="${requestScope.tabEvent}"/>
<c:set var="changeUrl" value="${requestScope.changeUrl}"/>
<c:remove var="changeUrl" scope="request"/>

<c:set var="initialIndex" value="0" />

<div id="${tempTabUniqueId}" class="defaultTab">
  <%-- tab navigation --%>
  <ul class="tabs">
    <c:forEach var="tabbingGroupItem" items="${tabItemsList}" varStatus="status">
      <c:set var="tabbingGroupItemReloadPage" value="false" />
      <c:set var="tabbingGroupItemAnchorText" value="${tempTabUniqueId}-${status.count}" />

      <c:choose>
        <c:when test="${tabbingGroupItem.type=='tabPaneGroup'}">
          <c:set var="tabbingGroupItemTitle" value="${fn:trim(tabbingGroupItem.options.title)}"/>
          <c:if test="${empty tabbingGroupItemTitle}">
            <c:set var="tabbingGroupItemTitle">&nbsp;</c:set>
          </c:if>

          <!-- handle param.tabPane -->
          <c:if test="${not empty param.tabPane and param.tabPane == tabbingGroupItemTitle}">
            <c:set var="initialIndex" value="${status.index}" />
          </c:if>

          <c:set var="tabbingGroupItemReloadPage" value="${tabbingGroupItem.options.reloadPage}" />
          <c:if test="${tabbingGroupItemReloadPage == 'true'}">
            <c:choose>
              <c:when test="${requestScope['com.escenic.context']=='art'}">
                <c:set var="currentUrl" value="${article.url}" />
              </c:when>
              <c:otherwise>
                <c:set var="currentUrl" value="${section.url}" />
              </c:otherwise>
            </c:choose>

            <c:url var="reloadPageUrl" value="${currentUrl}">
              <c:forEach var="curParam" items="${param}">
                <c:if test="${curParam.key != 'tabPane'}">
                  <c:param name="${curParam.key}" value="${curParam.value}" />
                </c:if>
              </c:forEach>
              <c:param name="tabPane" value="${tabbingGroupItemTitle}" />
            </c:url>

          </c:if>

        </c:when>
        <c:when test="${not empty tabbingGroupItem.content and
                        fn:startsWith(tabbingGroupItem.content.articleTypeName,'widget_')}">
          <c:set var="tabbingGroupItemTitle" value="${not empty tabbingGroupItem.fields.title ? tabbingGroupItem.fields.title : tabbingGroupItem.content.title }"  />
        </c:when>
      </c:choose>

      <li id="${tempTabUniqueId}-${status.count}">
        <a href="#${tabbingGroupItemAnchorText}" class="tabMenuItem" <c:if test="${tabbingGroupItemReloadPage == 'true'}">onclick="window.location.href='${reloadPageUrl}';"</c:if> >
          <span><c:out value="${tabbingGroupItemTitle}" escapeXml="true"/></span></a>
      </li>

      <c:remove var="tabbingGroupItemReloadPage" scope="page" />
      <c:remove var="tabbingGroupItemTitle" scope="page" />
    </c:forEach>
  </ul>

  <%-- tab content --%>
  <c:set var="prevTabbingEnabled" value="${requestScope.tabbingEnabled}" scope="request" />
  <c:set var="tabbingEnabled" value="true" scope="request" />

  <div class="tabPanes">
    <c:forEach var="tabbingGroupItem" items="${tabItemsList}" varStatus="status">
      <div class="tabPane">
        <c:choose>
          <c:when test="${tabbingGroupItem.type=='tabPaneGroup'}">
            <c:set var="tabbingEnabled" value="false" scope="request" />
            <c:set var="customStyleClass" value="${fn:trim(tabbingGroupItem.options.customStyleClass)}"/>
            <c:set var="styleClass" value="tabPaneGroup ${customStyleClass}" />
            <c:set var="styleId" value="${fn:trim(tabbingGroupItem.options.styleId)}"/>

            <c:set var="tabPaneGroupAreaName" value="tabPaneGroup-area" />
            <c:set var="tabPaneGroupItems" value="${tabbingGroupItem.areas[tabPaneGroupAreaName].items}"/>

            <div class="${styleClass}"  <c:if test="${not empty styleId}">id="${styleId}"</c:if> >
              <c:set var="items" value="${tabPaneGroupItems}" scope="request"/>
              <c:set var="paneGroupWidth" value="${tabWidth}" scope="request" />
              <jsp:include page="../group/showPaneGroupItems.jsp"/>
              <c:remove var="paneGroupWidth" scope="request" />
              <c:remove var="tabPaneWidth" scope="page" />
            </div>

            <c:remove var="tabPaneGroupItems" scope="page"/>
            <c:remove var="customStyleClass" scope="page" />
            <c:remove var="styleClass" scope="page" />
            <c:remove var="styleId" scope="page" />
            <c:set var="tabbingEnabled" value="true" scope="request" />
          </c:when>
          <c:when test="${not empty tabbingGroupItem.content and
                          fn:startsWith(tabbingGroupItem.content.articleTypeName,'widget_')}">
            <c:set var="widgetName" value="${fn:substringAfter(tabbingGroupItem.content.articleTypeName, 'widget_')}" scope="request"/>
            <c:set var="element" value="${tabbingGroupItem}" scope="request"/>
            <c:set var="contentType" value="${element.content.articleTypeName}"/>
            <c:choose>
              <c:when test="${requestScope.isConfigSection}">
                <c:if test="${element.content.state =='published'}">
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
        </c:choose>
      </div>
    </c:forEach>
  </div>

  <c:choose>
    <c:when test="${empty prevTabbingEnabled}">
      <c:remove var="tabbingEnabled" scope="request" />
    </c:when>
    <c:otherwise>
      <c:set var="tabbingEnabled" value="${prevTabbingEnabled}" scope="request" />
    </c:otherwise>
  </c:choose>
  <c:choose>
    <c:when test="${changeUrl}">
      <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function() {
          $("#${tempTabUniqueId} > ul.tabs").tabs("#${tempTabUniqueId} > div.tabPanes > div.tabPane", {
            current: 'current',
            effect: 'default',
            event: '${tempTabEvent}',
            initialIndex : ${initialIndex}
          }).history();
        });
        //]]>
      </script>
    </c:when>
    <c:otherwise>
      <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function() {
          $("#${tempTabUniqueId} > ul.tabs").tabs("#${tempTabUniqueId} > div.tabPanes > div.tabPane", {
            current: 'current',
            effect: 'default',
            event: '${tempTabEvent}',
            initialIndex : ${initialIndex}
          });
        });
        //]]>
      </script>
    </c:otherwise>
  </c:choose>
</div>



