<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-poll/src/main/webapp/template/widgets/poll/view/default_result.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the poll widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- add the js file for cookie related tasks --%>
<script type="text/javascript" src="${requestScope.resourceUrl}js/cookie.js"></script>

<%-- the controller has already set a HashMap named 'poll' in the requestScope --%>
<jsp:useBean id="poll" type="java.util.HashMap" scope="request"/>

<c:set var="pollItems" value="${poll.items}"/>

<c:if test="${not empty pollItems}">
  <div class="${poll.wrapperStyleClass}" <c:if test="${not empty poll.styleId}">id="${poll.styleId}"</c:if>>
    <c:if test="${poll.showWidgetName=='true'}">
      <div class="header">
        <h5>
          <c:out value="${poll.widgetName}" escapeXml="true"/>
        </h5>
      </div>
    </c:if>

    <c:forEach var="pollItem" items="${pollItems}">
      <div id="${pollItem.styleId}" class="content">
        <h2><c:out value="${pollItem.headline}" escapeXml="true"/></h2>

        <p><c:out value="${pollItem.question}" escapeXml="true"/></p>

        <c:set var="mentometer" value="${pollItem.mentometer}"/>

        <c:if test="${not empty mentometer.mentometerOption}">
          <c:set var="colorNames" value="Red,Blue,Green,DeepPink,DarkSeaGreen,OrangeRed,Peru,Indigo,OliveDrab,Maroon,Lime,Magenta,Cyan,Teal,DarkViolet,Sienna,Purple,Gray,PeachPuff,Yellow" />
          <c:set var="colorNamesArray" value="${fn:split(colorNames,',')}" />

          <ul>
            <c:forEach items="${mentometer.mentometerOption}" var="option" varStatus="status">
              <c:set var="colorName" value="${colorNamesArray[status.index]}" />
              <c:if test="${empty colorName}">
                <c:set var="colorName" value="Blue" />
              </c:if>

              <li>
                <p>
                  <c:out value="${option.title}" escapeXml="true"/> - <span style="color:${colorName};"><c:out value="${option.percentage}" escapeXml="false"/>%</span>
                </p>

                <div class="result">
                  <div style="width:${option.percentage}%;background:${colorName};">&nbsp;</div>
                </div>
              </li>
            </c:forEach>
          </ul>

          <p>
            <fmt:message key="poll.widget.result.label" />
            <strong><c:out value="${mentometer.totalVotes}" escapeXml="true"/></strong>
          </p>

          <c:choose>
            <c:when test="${pollItem.mode == 'vote'}">
              <p class="poll-form-link">
                <a href="${pollItem.url}"><fmt:message key="poll.widget.vote.linkText" /></a>
              </p>
            </c:when>
            <c:when test="${poll.voteMultipleTimes=='true'}">
              <p class="poll-form-link">
                <a href="${pollItem.revoteUrl}" onclick="eraseCookie('mentometer'); return true;" ><fmt:message key="poll.widget.revote.linkText" /></a>
              </p>
            </c:when>
          </c:choose>
        </c:if>
      </div>
    </c:forEach>
  </div>
</c:if>

<c:remove var="poll" scope="request" />