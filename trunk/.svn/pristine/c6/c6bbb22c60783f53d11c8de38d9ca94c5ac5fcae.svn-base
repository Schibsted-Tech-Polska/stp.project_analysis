<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getArticlesInList.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="neo.xredsys.content.type.TypeManager" %>
<%@ tag import="neo.xredsys.content.type.ArticleType" %>

<%@ attribute name="articleTypeName" type="java.lang.String" required="true" rtexprvalue="true" %>
<%@ attribute name="publicationId" type="java.lang.Integer" required="true" rtexprvalue="true" %>
<%@ attribute name="content" type="neo.xredsys.presentation.PresentationRelationArticle" required="true" rtexprvalue="true" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%
  try{
    ArticleType articleType = TypeManager.getInstance().getArticleType(publicationId,articleTypeName);
    jspContext.setAttribute("articleType",articleType);
  }
  catch (Exception ex){
    System.err.println(ex);
  }
%>

<jsp:useBean id="filedsMap" class="java.util.LinkedHashMap"/>
<c:forEach var="panel" items="${articleType.panels}">
  <jsp:useBean id="panelMap" class="java.util.LinkedHashMap"/>
  <c:forEach var="field" items="${panel.fields}">
    <c:set target="${panelMap}" property="${field.label}" value="${content.fields[field.name]}"/>
  </c:forEach>
  <c:set target="${filedsMap}" property="${panel.label}" value="${panelMap}"/>
  <c:remove var="panelMap"/>
</c:forEach>
<%
  request.setAttribute(var,jspContext.getAttribute("filedsMap"));
%>