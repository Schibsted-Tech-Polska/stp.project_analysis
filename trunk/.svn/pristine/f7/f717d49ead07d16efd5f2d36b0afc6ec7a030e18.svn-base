<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/menuPane/menuPaneGroup.jsp#2 $
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
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="paneGroup" value="${requestScope.menuPaneGroup}"/>

<c:if test="${not empty paneGroup}">
  <c:set var="reference" value="${fn:trim(paneGroup.options.reference)}"/>
  <c:set var="linkText" value="${fn:trim(paneGroup.options.linkText)}"/>

  <fmt:formatNumber var="menuPaneWidth" value="${paneGroup.options.width}" maxFractionDigits="0" type="number" pattern="###"/>
  <c:set var="paneGroupWidth" value="${menuPaneWidth}" scope="request"/>

  <c:choose>
    <c:when test="${reference == 'sectionUniqueName'}">
      <c:set var="sectionUniqueName" value="${fn:trim(paneGroup.options.sectionUniqueName)}"/>
      <section:use uniqueName="${sectionUniqueName}">
        <c:set var="linkUrl" value="${section.url}"/>
        <c:if test="${empty linkText}">
          <c:set var="linkText" value="${sectionUniqueName}"/>
        </c:if>
      </section:use>
    </c:when>
    <c:when test="${reference == 'url'}">
      <c:set var="linkUrl" value="${fn:trim(paneGroup.options.url)}"/>
    </c:when>
    <c:when test="${reference == 'articleId'}">
      <fmt:formatNumber var="articleId" value="${paneGroup.options.articleId}" maxFractionDigits="0" type="number" pattern="###"/>
      <article:use articleId="${articleId}">
        <c:set var="linkUrl" value="${article.url}"/>
      </article:use>
    </c:when>
  </c:choose>

  <c:if test="${not empty linkText and not empty linkUrl}">
    <c:set var="uniqueId" value="${requestScope.menuPaneGroupId}"/>
    <c:set var="hiddenDivId" value="hidden-div-${uniqueId}"/>
    <c:set var="linkId" value="menuPane-link-${uniqueId}"/>
    <div class="menu">
      <ul>
        <li>
          <a href="${linkUrl}" id="${linkId}" class="menuPaneLink"><c:out value="${linkText}" escapeXml="true"/></a>
        </li>
      </ul>
      <div id="${hiddenDivId}" class="hidden-div" style="width:${paneGroupWidth}px;">
        <c:set var="items" value="${paneGroup.areas['menuPaneGroup-area'].items}" scope="request"/>
        <jsp:include page="../group/showPaneGroupItems.jsp"/>
      </div>
    </div>

    <script type="text/javascript">
      $(document).ready(function() {
        var hide_${uniqueId} = false;
        // Shows the DIV on hover with a fade in
        $("#${linkId}").hover(function() {
          if (hide_${uniqueId}) clearTimeout(hide_${uniqueId});
          $("#${hiddenDivId}").fadeIn('fast', function() {
            $("#${hiddenDivId}").css({opacity:1.0});
          });
          // The main nav menu item is assigned the 'active' CSS class
          $(this).addClass("active");
        }, function() {
          // Fades out the DIV and removes the 'active' class from the main nav menu item
          hide_${uniqueId} = setTimeout(function() {
            $("#${hiddenDivId}").fadeOut('fast');
          });
          $("#${linkId}").removeClass("active");
        });
        // Ensures the DIV displays when your mouse moves away from the main nav menu item
        $("#${hiddenDivId}").hover(function() {
          if (hide_${uniqueId}) clearTimeout(hide_${uniqueId});
          $("#${linkId}").addClass("active");
        }, function() {
          // If your mouse moves out of the displayed hidden DIV, the DIv fades out and removes the 'active' class
          hide_${uniqueId} = setTimeout(function() {
            $("#${hiddenDivId}").fadeOut('fast');
          });
          $("#${hiddenDivId}").stop().fadeIn('fast', function() {
            $("#${hiddenDivId}").css({opacity:1.0});
          });
          $("#${linkId}").removeClass("active");
        });
      });
    </script>
  </c:if>

  <c:remove var="paneGroupWidth" scope="request"/>
</c:if>