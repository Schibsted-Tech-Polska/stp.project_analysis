<%--
 * File           : $Header: $
 * Last edited by : $Author: $ $Date: $
 * Version        : $Revision: $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<c:choose>
  <c:when test="${requestScope['com.escenic.context']=='art'}">
    <c:choose>
      <c:when test="${not empty articleConfigArticleTypeSection}">
        <jsp:include page="../group/${articleConfigArticleTypeSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty articleConfigArticleType}">
        <jsp:include page="../group/${articleConfigArticleType.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty articleConfigSection}">
        <jsp:include page="../group/${articleConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty globalArticleConfigSection}">
        <jsp:include page="../group/${globalArticleConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty globalConfigSection}">
        <jsp:include page="../group/${globalConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:otherwise>
        <wf-core:getPresentationPool var="pool" section="${article.homeSection}"/>
        <jsp:include page="../group/${pool.rootElement.type}.jsp"/>
      </c:otherwise>
    </c:choose>
  </c:when>
  <c:otherwise>
    <c:choose>
      <c:when test="${section.parent.uniqueName == 'profile' and not empty profileConfigSection}">
        <jsp:include page="../group/${profileConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty sectionConfigSection}">
        <jsp:include page="../group/${sectionConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty globalSectionConfigSection}">
        <jsp:include page="../group/${globalSectionConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:when test="${not empty globalConfigSection}">
        <jsp:include page="../group/${globalConfigSection.activeIndexPage.elements.descriptor.name}.jsp"/>
      </c:when>
      <c:otherwise>
        <jsp:include page="../group/${pool.rootElement.type}.jsp"/>
      </c:otherwise>
    </c:choose>
  </c:otherwise>
</c:choose>