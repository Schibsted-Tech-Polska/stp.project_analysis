<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/showPaneGroupItems.jsp#1 $
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
<jsp:useBean id="level" type="java.lang.String" scope="request"/>

<c:choose>
  <c:when test="${not empty section.parameters['nesting.limit']}">
    <c:set var="nestingLimit" value="${section.parameters['nesting.limit']}"/>
  </c:when>
  <c:otherwise>
    <c:set var="nestingLimit" value="10"/>
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${(level+0) <= (nestingLimit+0)}">
    <c:set var="level" value="${level+1}"/>
    <c:forEach var="item" items="${requestScope.items}">
      <c:choose>
        <c:when test="${fn:startsWith(item.type,'x')}">
          <c:set var="elementwidthOld" value="${requestScope['elementwidth']}"/>

          <c:set var="widthArray" value="${fn:split(item.type,'x')}"/>

          <c:set var="remainingWidth" value="${requestScope.paneGroupWidth}"/>
          <c:if test="${empty remainingWidth or remainingWidth == 0}">
            <c:set var="totalWidth" value="0"/>

            <c:forEach var="width" items="${widthArray}">
              <c:set var="totalWidth" value="${totalWidth + width + 20}"/>
            </c:forEach>

            <c:set var="totalWidth" value="${totalWidth - 20}"/>
            <c:set var="remainingWidth" value="${totalWidth}"/>
          </c:if>

          <c:set var="customStyleClass" value="${fn:trim(item.options.customStyleClass)}" />
          <c:set var="styleId" value="${fn:trim(item.options.styleId)}" />

          <div class="${item.type} ${customStyleClass}" style="width:${remainingWidth}px;"
               <c:if test="${not empty styleId}">id="${styleId}"</c:if> >

            <c:remove var="customStyleClass" scope="page" />
            <c:remove var="styleId" scope="page" />

            <c:forEach var="i" begin="1" end="${fn:length(item.areas)}" step="1" varStatus="loopStatus">
              <c:set var="areaString" value="column-${i}"/>
              <c:set var="elementwidth" value="${widthArray[i-1]}" scope="request"/>
              <c:set var="area" value="${item.areas[areaString]}"/>

              <c:set var="remainingWidth" value="${remainingWidth - requestScope.elementwidth}"/>

              <c:choose>
                <c:when test="${(remainingWidth + 0) >= 0}">
                  <div class="${areaString}">
                    <c:set var="items" value="${area.items}" scope="request"/>
                    <jsp:include page="showPaneGroupItems.jsp"/>
                  </div>
                </c:when>
                <%-- we will display the error message only in preview --%>
                <c:when test="${not empty param.poolId and not empty param.token}">
                  <div class="error">
                    <fmt:message key="paneGroup.width.error.message"/>
                  </div>
                </c:when>
              </c:choose>

              <c:set var="remainingWidth" value="${remainingWidth - 20}"/>
            </c:forEach>
          </div>

          <%-- retroing the current elementwidth from temporary storage elementwidthOld --%>
          <c:set var="elementwidth" value="${elementwidthOld}" scope="request"/>
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
    <c:remove var="items" scope="request"/>
  </c:when>
  <c:otherwise>
    <p>
      <fmt:message key="nesting.limit.error.message">
        <fmt:param value="${nestingLimit}"/>
        <fmt:param value="${level}"/>
      </fmt:message>
    </p>
  </c:otherwise>
</c:choose>