<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/getitems.jsp#1 $
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
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- clear requestScope.items through which items will be returned. it could be present in request scope by mistake or by some other code. --%>
<c:if test="${not empty requestScope.items}">
  <c:remove var="items" scope="request" />
</c:if>

<c:if test="${not empty globalConfigSection}">
  <wf-core:getPresentationPool var="globalConfigPool" section="${globalConfigSection}" />
</c:if>

<c:choose>
  <%-- ARTICLE CONTEXT --%>
  <c:when test="${requestScope['com.escenic.context']=='art'}">
    <c:if test="${not empty articleConfigArticleTypeSection}">
      <wf-core:getPresentationPool var="articleTypeSectionArticleConfigPool" section="${articleConfigArticleTypeSection}"/>
    </c:if>
    <c:if test="${not empty customArticleConfigSection}">
      <wf-core:getPresentationPool var="customArticleConfigPool" section="${customArticleConfigSection}"/>
    </c:if>
    <c:if test="${not empty articleConfigArticleType}">
      <wf-core:getPresentationPool var="articleTypeArticleConfigPool" section="${articleConfigArticleType}"/>
    </c:if>
    <c:if test="${not empty articleConfigSection}">
      <wf-core:getPresentationPool var="articleConfigPool" section="${articleConfigSection}"/>
    </c:if>
    <c:if test="${not empty globalArticleConfigSection}">
      <wf-core:getPresentationPool var="globalArticleConfigPool" section="${globalArticleConfigSection}"/>
    </c:if>
    <c:choose>
      <c:when test="${(not empty customArticleConfigPool) and (not empty customArticleConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${customArticleConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty articleTypeSectionArticleConfigPool) and (not empty articleTypeSectionArticleConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${articleTypeSectionArticleConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty articleTypeArticleConfigPool) and (not empty articleTypeArticleConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${articleTypeArticleConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty articleConfigPool) and (not empty articleConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${articleConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty globalArticleConfigPool) and (not empty globalArticleConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${globalArticleConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty globalConfigPool) and (not empty globalConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${globalConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:otherwise>
        <%-- <c:set var="items" value="${pool.rootElement.areas[area].items}" scope="request"/>  --%>
      </c:otherwise>
    </c:choose>
    <c:if test="${empty items}">
      <%-- No content found, inherit from the parent section(s) --%>
      <c:choose>
        <c:when test="${(not empty articleTypeSectionArticleConfigPool) and not empty articleTypeSectionArticleConfigPool.section.parent and (not empty articleTypeSectionArticleConfigPool.rootElement.areas[area].items)}">
          <c:set var="parent" value="${articleTypeSectionArticleConfigPool.section.parent}" scope="request"/>
          <jsp:include page="getparentitems.jsp"/>
        </c:when>
        <c:when test="${(not empty articleTypeArticleConfigPool) and not empty articleTypeArticleConfigPool.section.parent and (not empty articleTypeArticleConfigPool.rootElement.areas[area].items)}">
          <c:set var="parent" value="${articleTypeArticleConfigPool.section.parent}" scope="request"/>
          <jsp:include page="getparentitems.jsp"/>
        </c:when>
        <c:when test="${(not empty articleConfigPool) and not empty articleConfigPool.section.parent and (not empty articleConfigPool.rootElement.areas[area].items)}">
          <c:set var="parent" value="${articleConfigPool.section.parent}" scope="request"/>
          <jsp:include page="getparentitems.jsp"/>
        </c:when>
        <c:when test="${(not empty globalArticleConfigPool) and not empty globalArticleConfigPool.section.parent and (not empty globalArticleConfigPool.rootElement.areas[area].items)}">
          <c:set var="parent" value="${globalArticleConfigPool.section.parent}" scope="request"/>
          <jsp:include page="getparentitems.jsp"/>
        </c:when>
        <c:when test="${(not empty globalConfigPool) and not empty globalConfigPool.section.parent and (not empty globalConfigPool.rootElement.areas[area].items)}">
          <c:if test="${globalConfigPool.section.uniqueName != 'config.mobil'}">
            <c:set var="parent" value="${globalConfigPool.section.parent}" scope="request"/>
            <jsp:include page="getparentitems.jsp"/>
          </c:if>
        </c:when>
        <c:otherwise>
          <%-- <c:set var="items" value="${pool.rootElement.areas[area].items}" scope="request"/>  --%>
        </c:otherwise>
      </c:choose>
    </c:if>
  </c:when>
  <%-- SECTION CONTEXT --%>
  <c:otherwise>
    <c:if test="${section.parent.uniqueName=='profile' and not empty profileConfigSection}">
      <wf-core:getPresentationPool var="profileConfigPool" section="${profileConfigSection}" />
    </c:if>
    <c:if test="${not empty sectionConfigSection}">
      <wf-core:getPresentationPool var="sectionConfigPool" section="${sectionConfigSection}"/>
    </c:if>
    <c:if test="${not empty globalSectionConfigSection}">
      <wf-core:getPresentationPool var="globalSectionConfigPool" section="${globalSectionConfigSection}"/>
    </c:if>
    <c:choose>
      <c:when test="${(not empty sectionConfigPool) and (not empty sectionConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${sectionConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
      <c:when test="${(not empty profileConfigPool) and (not empty profileConfigPool.rootElement.areas[area].items)}">
        <c:set var="items" value="${profileConfigPool.rootElement.areas[area].items}" scope="request"/>
      </c:when>
    </c:choose>
    <c:if test="${empty items}">
      <c:choose>
        <c:when test="${empty sectionConfigSection.parent or sectionConfigSection.uniqueName=='config'}">
          <c:choose>
            <c:when test="${(not empty profileConfigPool) and not empty profileConfigPool.section.parent and (not empty profileConfigPool.rootElement.areas[area].items)}">
              <c:set var="parent" value="${profileConfigPool.section.parent}" scope="request"/>
              <jsp:include page="getparentitems.jsp"/>
            </c:when>
            <c:when test="${(not empty globalSectionConfigPool) and (not empty globalSectionConfigPool.rootElement.areas[area].items)}">
              <c:set var="items" value="${globalSectionConfigPool.rootElement.areas[area].items}" scope="request"/>
            </c:when>
            <c:when test="${(not empty globalConfigPool) and (not empty globalConfigPool.rootElement.areas[area].items)}">
              <c:set var="items" value="${globalConfigPool.rootElement.areas[area].items}" scope="request"/>
            </c:when>
            <c:when test="${(not empty globalSectionConfigPool) and not empty globalConfigPool.section.parent and (not empty globalSectionConfigPool.rootElement.areas[area].items)}">
              <c:set var="parent" value="${globalSectionConfigPool.section.parent}" scope="request"/>
              <jsp:include page="getparentitems.jsp"/>
            </c:when>
            <c:when test="${(not empty globalConfigPool) and not empty globalConfigPool.section.parent and (not empty globalConfigPool.rootElement.areas[area].items)}">
              <c:if test="${globalConfigPool.section.uniqueName != 'config.mobil'}">
                <c:set var="parent" value="${globalConfigPool.section.parent}" scope="request"/>
                <jsp:include page="getparentitems.jsp"/>
              </c:if>
            </c:when>
          </c:choose>
        </c:when>
        <c:otherwise>
           <c:set var="backup" value="${sectionConfigSection}" scope="page"/>
          <c:set var="sectionConfigSection" value="${sectionConfigSection.parent}" scope="request"/>
          <jsp:include page="getitems.jsp"/>
          <c:set var="sectionConfigSection" value="${backup}" scope="request"/>
          <c:remove var="backup" scope="page"/>
        </c:otherwise>
      </c:choose>
    </c:if>
  </c:otherwise>
</c:choose>
