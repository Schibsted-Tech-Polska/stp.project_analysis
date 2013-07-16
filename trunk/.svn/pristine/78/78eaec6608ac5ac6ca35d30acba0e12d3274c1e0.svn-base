<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getLatestUpdatedBlogs.tag#1 $
 * Last edited by : $Author: msh $ $Date: 2010/03/21 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="max" required="false" rtexprvalue="true" %>
<%@ attribute name="maxLookup" required="false" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection"%>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<c:set var="MAX" value="${0+(empty max?50:max)}" scope="page"/>
<c:set var="STEP_SIZE" value="${2*MAX}" scope="page"/>
<c:set var="STEP_COUNT" value="${0}" scope="page"/>
<c:set var="maxLookup" value="${0+(empty maxLookup?10000:maxLookup)}" scope="page"/>

<%
  int maxItems = ((Long)jspContext.getAttribute("MAX")).intValue();
  int stepSize = ((Long)jspContext.getAttribute("STEP_SIZE")).intValue();
  int maxLook = ((Long)jspContext.getAttribute("maxLookup")).intValue();
  int stepCount = 0;
  java.util.ArrayList blogList = new java.util.ArrayList();
  boolean hasMore = true;

  while (true){
%>
<c:set var="STEP_COUNT" value="${STEP_COUNT+1}" scope="page"/>

<c:if test="${empty requestScope.articleListDateString}">
  <wf-core:getDateString var="articleListDateString" hourDiff="${publication.features['article.list.age.max']}"/>  
</c:if>

<article:list id="foundArticles" includeArticleTypes="blogPost" sort="lastChangedDate"  sectionUniqueName="${section.parameters['usercontent.userProfile.uniqueName']}"
              includeSubSections="true" max="${(maxLookup>=STEP_COUNT*STEP_SIZE)?maxLookup:STEP_COUNT*STEP_SIZE}" from="${requestScope.articleListDateString}"/>
<%
  stepCount = ((Long)jspContext.getAttribute("STEP_COUNT")).intValue();
  if(foundArticles.size()<stepSize*stepCount || stepSize*stepCount>=maxLook)
  {
    hasMore = false;
  }
  for(int i=(stepSize*(stepCount-1));i<foundArticles.size();i++)
  {
    jspContext.setAttribute("curArt",foundArticles.get(i));
%>
<article:use article="${curArt}">
  <c:set var="uniqueName" value="${article.homeSection.uniqueName}" scope="page"/>
</article:use>
<%
      if(!blogList.contains(jspContext.getAttribute("uniqueName"))){
        blogList.add(jspContext.getAttribute("uniqueName"));
      }
      if(blogList.size()>=maxItems){
        break;
      }
    }
    if(blogList.size()>=maxItems || (!hasMore)){
      break;
    }
  }

  request.setAttribute(var,blogList);
%>

