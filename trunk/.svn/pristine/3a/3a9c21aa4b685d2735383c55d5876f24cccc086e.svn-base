<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/helpers/searchItem.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  The purpose of this page is to display a single search result item
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- this page expects the following attributes in the requestScope --%>
<jsp:useBean id="searchItemId" type="java.lang.String" scope="request" />
<jsp:useBean id="firstItemStyleClass" type="java.lang.String" scope="request" />

<jsp:useBean id="search" type="java.util.HashMap" scope="request"/>

<article:use articleId="${searchItemId}">
  <div class="article ${firstItemStyleClass}">

    <%-- set title, leadText and image attributes depending on article-type --%>
    <c:set var="articleType" value="${article.articleTypeName}"/>
    <c:choose>
      <c:when test="${articleType=='picture'}">
        <c:set var="title" value="${fn:trim(article.fields.caption.value)}"/>
        <c:set var="description" value="${fn:trim(article.fields.description.value)}"/>

        <c:choose>
          <c:when test="${empty description}">
            <c:set var="leadText" value=""/>
          </c:when>
          <c:otherwise>
            <c:set var="maxChar" value="${100}"/>
            <c:if test="${fn:length(description) < maxChar}">
              <c:set var="maxChar" value="${fn:length(description)}"/>
              <c:set var="deprecatedLeadText" value="${true}"/>
            </c:if>

            <%--
            <c:set var="tempLeadText" value="${fn:substring(description,0,maxChar)}"/>
            
            <c:if test="${deprecatedLeadText==true}">
              <c:set var="leadText" value="${tempLeadText} ..."/>
            </c:if>
            --%>
            <c:set var="leadText" value="${description}"/>
            

          </c:otherwise>
        </c:choose>

        <c:set var="picture" value="${article}"/>
        
      </c:when>

      <c:otherwise>
        <c:set var="title" value="${article.title}"/>
        <c:set var="leadText" value="${article.fields.leadtext}"/>
        <c:if test="${empty leadText}">
          <c:set var="leadText" value=""/>
        </c:if>
        <wf-core:getTeaserImageMap var="teaserImageMap" articleId="${article.id}" />
        <c:set var="picture" value="${requestScope.teaserImageMap.imageArticle}" />
        <c:remove var="teaserImageMap" scope="request" />
        
      </c:otherwise>
    </c:choose>


    <p class="summary" onclick="location.href ='${article.url}'">
      
      <c:if test="${search.showImage=='true'}">
        <c:if test="${not empty picture}">
          <c:set var="imageVersion" value="${search.imageVersion}" />
          <img src="${picture.fields.alternates.value[imageVersion].href}"
               width="${picture.fields.alternates.value[imageVersion].width}"
               height="${picture.fields.alternates.value[imageVersion].height}"
               alt="alt text"
               title="title"/>
        </c:if>
      </c:if>

      <span class="resultTitle">
        <a href="${article.url}"><strong><c:out value="${title}" escapeXml="true"/></strong></a><br/>
      </span>

      <c:if test="${search.showLeadText=='true' and not empty leadText}">
        <c:out value="${leadText}" escapeXml="true"/><br/>
      </c:if>

      <span class="resultDateInfo">
        <c:if test="${search.showPublishedDate=='true'}">
          <strong><fmt:message key="search.widget.published.label"/></strong> <fmt:formatDate value="${article.firstPublishedDateAsDate}" pattern="${search.dateFormat}"/>  &nbsp;
        </c:if>
        <c:if test="${search.showLastModifiedDate=='true'}">
          <strong><fmt:message key="search.widget.lastModified.label"/></strong> <fmt:formatDate value="${article.lastModifiedDateAsDate}" pattern="${search.dateFormat}"/>&nbsp;
        </c:if>
      </span>
      

    </p>
    
  </div>
</article:use>
