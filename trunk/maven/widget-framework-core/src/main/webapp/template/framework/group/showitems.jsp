<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/showitems.jsp#1 $
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

<%-- the page expects the following attributes in the requestScope --%>
<jsp:useBean id="level" type="java.lang.String" scope="request" />

<c:choose>
  <c:when test="${not empty section.parameters['nesting.limit']}">
    <c:set var="nestingLimit" value="${section.parameters['nesting.limit']}"/>
  </c:when>
  <c:otherwise>
    <c:set var="nestingLimit" value="10"/>
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${(level+0) <= (nestingLimit+0)}">   <%-- making sure that EL conputes this as an Integer operation --%>
    <c:set var="level" value="${level+1}"/>
    <c:forEach var="item" items="${items}">
      <c:choose>
        <c:when test="${fn:startsWith(item.type,'x')}">  <%-- checking for config groups --%>
          <%-- stroing the current elementwidth temporarily as elementwidthOld --%>
          <c:set var="elementwidthOld" value="${requestScope['elementwidth']}" />

          <c:set var="widtharray" value="${fn:split(item.type,'x')}"/>

          <c:set var="customStyleClass" value="${fn:trim(item.options.customStyleClass)}" />
          <c:set var="styleId" value="${fn:trim(item.options.styleId)}" />

          <div class="${item.type} ${customStyleClass}"
               <c:if test="${not empty styleId}">id="${styleId}"</c:if> >

            <c:remove var="customStyleClass" scope="page" />
            <c:remove var="styleId" scope="page" />

            <c:forEach var="i" begin="1" end="${fn:length(item.areas)}" step="1">
              <c:set var="areastring" value="column-${i}"/>
              <c:set var="elementwidth" value="${widtharray[i-1]}" scope="request"/>
              <c:set var="area" value="${item.areas[areastring]}"/>
              <div class="${areastring}">
                <c:set var="items" value="${area.items}" scope="request"/>
                <jsp:include page="showitems.jsp" />
              </div>
            </c:forEach>
          </div>

          <%-- retroing the current elementwidth from temporary storage elementwidthOld --%>
          <c:set var="elementwidth" value="${elementwidthOld}" scope="request" />
        </c:when>

        <c:when test="${item.type=='floatingGroup'}"> <%-- checking for floating groups --%>
          <c:set var="floatingGroupOptions" value="${item.options}" scope="request" />
          <c:set var="mainContentsAreaName" value="mainContents" />
          <c:set var="mainContentsArea" value="${item.areas[mainContentsAreaName]}" />
          <c:set var="mainContentsItems" value="${mainContentsArea.items}" scope="request" />
          <c:set var="floatingContentsAreaName" value="floatingContents" />
          <c:set var="floatingContentsArea" value="${item.areas[floatingContentsAreaName]}" />
          <c:set var="floatingContentsItems" value="${floatingContentsArea.items}" scope="request" />
          <jsp:include page="../wrap/default.jsp" />
          <c:remove var="floatingGroupOptions" scope="request" />
          <c:remove var="mainContentsItems" scope="request" />
          <c:remove var="floatingContentsItems" scope="request" />
        </c:when>

        <c:when test="${item.type=='tabbingGroup'}"> <%-- checking for tabbing groups --%>
          <c:set var="tabbingGroup" value="${item}" scope="request"/>
          <jsp:include page="../tabs/tabbingGroup.jsp" />
          <c:remove var="tabbingGroup" scope="request" />
        </c:when>

        <c:when test="${item.type=='configCarouselGroup'}">
          <c:set var="configCarouselGroup" value="${item}" scope="request"/>
          <jsp:include page="../carousel/default.jsp" />
          <c:remove var="configCarouselGroup" scope="request" />
        </c:when>

        <c:when test="${item.type=='boxGroup'}"> <%-- checking for box groups --%>
          <c:set var="boxGroupStyleClass" value="${item.options.customStyleClass}"/>
          <c:set var="boxGroupStyleId" value="${item.options.styleId}"/>
          <c:set var="boxHeaderItems" value="${item.areas['header'].items}"/>
          <c:set var="boxMainItems" value="${item.areas['main'].items}"/>
          <c:set var="boxFooterItems" value="${item.areas['footer'].items}"/>

          <c:if test="${not empty boxHeaderItems or not empty boxMainItems or not empty boxFooterItems}">
            <div class="box ${boxGroupStyleClass}" <c:if test="${not empty boxGroupStyleId}"> id="${boxGroupStyleId}"</c:if>>
              <c:if test="${not empty boxHeaderItems}">
                <div class="box-header" <c:if test="${not empty boxGroupStyleId}"> id="${boxGroupStyleId}-header"</c:if>>
                  <c:set var="items" value="${boxHeaderItems}" scope="request" />
                  <jsp:include page="showitems.jsp" />
                </div>
              </c:if>
              <c:if test="${not empty boxMainItems}">
                <div class="box-main" <c:if test="${not empty boxGroupStyleId}"> id="${boxGroupStyleId}-main"</c:if>>
                  <c:set var="elementwidthOld" value="${requestScope.elementwidth}"/>
                  <c:set var="elementwidth" value="${requestScope.elementwidth - 20}" scope="request"/>
                  <c:set var="items" value="${boxMainItems}" scope="request" />
                  <jsp:include page="showitems.jsp" />
                  <c:set var="elementwidth" value="${elementwidthOld}" scope="request"/>
                  <c:remove var="elementwidthOld" scope="page"/>
                </div>
              </c:if>
              <c:if test="${not empty boxFooterItems}">
                <div class="box-footer" <c:if test="${not empty boxGroupStyleId}"> id="${boxGroupStyleId}-footer"</c:if>>
                  <c:set var="items" value="${boxFooterItems}" scope="request" />
                  <jsp:include page="showitems.jsp" />
                </div>
              </c:if>
            </div>
          </c:if>

          <c:remove var="boxGroupStyleId" scope="page"/>
          <c:remove var="boxGroupStyleClass" scope="page"/>
          <c:remove var="boxHeaderItems" scope="page"/>
          <c:remove var="boxMainItems" scope="page"/>
          <c:remove var="boxFooterItems" scope="page"/>
        </c:when>

        <%-- checking for menu groups--%>
        <c:when test="${item.type == 'menuGroup'}">
          <c:set var="menuGroupArea" value="${item.areas['menuGroup-area']}" />
          <c:set var="menuGroupStyleClass" value="${item.options.customStyleClass}" />
          <c:set var="menuGroupStyleId" value="${item.options.styleId}" />
          <c:set var="items" value="${menuGroupArea.items}" scope="request" />
          <div <c:if test="${not empty menuGroupStyleId}">id="${menuGroupStyleId}"</c:if> class="menuGroup ${menuGroupStyleClass}">
            <jsp:include page="showitems.jsp" />
          </div>
          <c:remove var="menuGroupStyleClass" scope="page" />
          <c:remove var="menuGroupStyleId" scope="page" />
        </c:when>

        <%-- checking for menu pane groups--%>
        <c:when test="${item.type == 'menuPaneGroup'}">
          <c:set var="menuPaneGroup" value="${item}" scope="request"/>
          <c:set var="styleId" value="${fn:trim(menuPaneGroup.options.styleId)}"/>
          <c:set var="customStyleClass" value="${fn:trim(menuPaneGroup.options.customStyleClass)}"/>
          <c:set var="allClasses">menuPaneGroup <c:if test="${not empty customStyleClass}">${customStyleClass}</c:if></c:set>
          <c:set var="menuPaneGroupId" value="${requestScope.menuPaneGroupId + 1}" scope="request"/>

          <div class="${allClasses}" <c:if test="${not empty styleId}">id="${styleId}"</c:if>>
            <jsp:include page="../menuPane/menuPaneGroup.jsp"/>
          </div>
          <c:remove var="menuPaneGroup" scope="request" />
        </c:when>

        <c:when test="${item.type=='switchingGroup'}">
          <c:set var="switchingGroup" value="${item}" scope="request"/>
          <jsp:include page="../switch/default.jsp" />
          <c:remove var="switchingGroup" scope="request" />
        </c:when>

        <c:when test="${fn:startsWith(item.type,'widget_')}">
          <c:set var="element" value="${item}" scope="request"/>
          <jsp:include page="../element/ats.jsp"/>
        </c:when>

        <c:otherwise>
          <h2 class="error">
            <fmt:message key="page.options.error.message" />
          </h2>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:remove var="items" scope="request" />
  </c:when>
  <c:otherwise>
    <p>
      <fmt:message key="nesting.limit.error.message">
        <fmt:param value="${nestingLimit}" />
        <fmt:param value="${level}" />
      </fmt:message>
    </p>
  </c:otherwise>
</c:choose>