<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-mobile/src/main/webapp/template/framework/wireframe/mobile.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>


<c:remove var="globalConfigSection"/>
<c:remove var="sectionConfigSection"/>
<c:remove var="globalSectionConfigSection"/>
<c:remove var="articleConfigSection"/>
<c:remove var="globalArticleConfigSection"/>
<c:remove var="profileConfigSection"/>
<c:remove var="articleConfigArticleType"/>
<c:remove var="articleConfigArticleTypeSection"/>
<c:remove var="customArticleConfigSection"/>

<%-- definitions of the mobile config sections to override those set in common.jsp--%>

<c:choose>
	<c:when test="${capabilities.tablet eq 'true'}">
		<section:use uniqueName="config.tablet">
		  <c:set var="globalConfigSection" value="${section}" scope="request"/> 
		</section:use>

		<section:use uniqueName="config.tablet.section.${section.uniqueName}">
		  <c:set var="sectionConfigSection" value="${section}" scope="request"/>
		</section:use>

		<section:use uniqueName="config.tablet.section">
		  <c:set var="globalSectionConfigSection" value="${section}" scope="request"/>
		</section:use>

		<section:use uniqueName="config.tablet.article.${section.uniqueName}">
		  <c:set var="articleConfigSection" value="${section}" scope="request"/>
		</section:use>
		<section:use uniqueName="config.tablet.article">
		  <c:set var="globalArticleConfigSection" value="${section}" scope="request"/>
		</section:use>

		<c:if test="${section.parent.uniqueName=='profile'}">
		  <section:use uniqueName="config.section.profile">'
		    <c:set var="profileConfigSection" value="${section}" scope="request"/>
		  </section:use>
		</c:if>

		<c:if test="${requestScope['com.escenic.context']=='art'}">
		  <section:use uniqueName="config.tablet.article.type.${article.articleTypeName}">
		    <c:set var="articleConfigArticleType" value="${section}" scope="request" />
		  </section:use>

		  <section:use uniqueName="config.tablet.article.${section.uniqueName}.type.${article.articleTypeName}">
		    <c:set var="articleConfigArticleTypeSection" value="${section}" scope="request" />
		  </section:use>
		    
		  <section:use uniqueName="${article.fields.customConfigSection.value}">
		      <c:set var="customArticleConfigSection" value="${section}" scope="request" />
		  </section:use>
		</c:if>
	</c:when>
	<c:otherwise>
		<section:use uniqueName="config.mobile">
		  <c:set var="globalConfigSection" value="${section}" scope="request"/> 
		</section:use>

		<section:use uniqueName="config.mobile.section.${section.uniqueName}">
		  <c:set var="sectionConfigSection" value="${section}" scope="request"/>
		</section:use>

		<section:use uniqueName="config.mobile.section">
		  <c:set var="globalSectionConfigSection" value="${section}" scope="request"/>
		</section:use>

		<section:use uniqueName="config.mobile.article.${section.uniqueName}">
		  <c:set var="articleConfigSection" value="${section}" scope="request"/>
		</section:use>
		<section:use uniqueName="config.mobile.article">
		  <c:set var="globalArticleConfigSection" value="${section}" scope="request"/>
		</section:use>

		<c:if test="${section.parent.uniqueName=='profile'}">
		  <section:use uniqueName="config.section.profile">'
		    <c:set var="profileConfigSection" value="${section}" scope="request"/>
		  </section:use>
		</c:if>

		<c:if test="${requestScope['com.escenic.context']=='art'}">
		  <section:use uniqueName="config.mobile.article.type.${article.articleTypeName}">
		    <c:set var="articleConfigArticleType" value="${section}" scope="request" />
		  </section:use>

		  <section:use uniqueName="config.mobile.article.${section.uniqueName}.type.${article.articleTypeName}">
		    <c:set var="articleConfigArticleTypeSection" value="${section}" scope="request" />
		  </section:use>
		    
		  <section:use uniqueName="${article.fields.customConfigSection.value}">
		      <c:set var="customArticleConfigSection" value="${section}" scope="request" />
		  </section:use>
		</c:if>
	</c:otherwise>
</c:choose>

<dxf:document viewportUserScalable="no" disable_cache="true">
	<dxf:xmlpidtd encoding="iso-8859-1" />
	
  <dxf:registerWidget widget="accordion"/>
  <dxf:registerWidget widget="article"/>
  <dxf:registerWidget widget="grid"/>
  <dxf:registerWidget widget="iphonebookmark"/>
  <dxf:registerWidget widget="map"/>
  <dxf:registerWidget widget="menu" skipCSS="true"/>
	<dxf:registerWidget widget="simplelist"/>
	<dxf:registerWidget widget="slideshow"/>
	<dxf:registerWidget widget="tabpane"/>
	<dxf:registerWidget widget="ticker"/>
  <dxf:registerWidget widget="textsize"/>
  <dxf:registerWidget widget="warning"/>
  <dxf:registerWidget widget="window" />

	<dxf:head>
		<dxf:css href="/${publication.name}/skins/${skinName}/mobile/css/${skinName}.css"/>
		<dxf:title>
			  <c:choose>
			    <c:when test="${requestScope['com.escenic.context']=='art'}">
			      ${article.title} -
			    </c:when>
			    <c:when test="${section.uniqueName != 'ece_frontpage'}">
			      ${section.name} -
			    </c:when>
			  </c:choose>

			  <fmt:message key="publication.skin.${skinName}.title"/>
		</dxf:title>
		
		<c:set var="area" value="head" scope="request"/>
		<jsp:include page="../group/getitems.jsp"/>
		<c:remove var="area" scope="request"/>
		<%--Iterating over the items--%>
		<c:forEach var="item" items="${items}">
			<c:if test="${fn:startsWith(item.type, 'widget_')}">
				<c:set var="element" value="${item}" scope="request"/>
				<wf-core:include widgetName="${fn:substringAfter(item.type,'widget_')}"/>
				<c:remove var="element" scope="request"/>
			</c:if>
		</c:forEach>
	</dxf:head>

	<dxf:body>
		<%-- Add mobile mark-up in this file --%>
		<wf-core:renderContext />
	</dxf:body>
</dxf:document>