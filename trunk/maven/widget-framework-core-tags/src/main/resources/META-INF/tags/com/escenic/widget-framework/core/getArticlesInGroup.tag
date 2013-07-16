<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getArticlesInGroup.tag#1 $
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
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="neo.xredsys.presentation.PresentationArticle" %>
<%@ tag import="neo.xredsys.presentation.PresentationElement" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="group" required="true" rtexprvalue="true" type="neo.xredsys.presentation.PresentationElement" %>
<%@ attribute name="contentType" required="true" rtexprvalue="true" %>
<%@ attribute name="max" required="false" rtexprvalue="true" %>

<%
  List<PresentationArticle> articles = new ArrayList<PresentationArticle>();
  int maxInt = Integer.MAX_VALUE;

  if (max != null) {
    try {
      maxInt = Integer.parseInt(max);
    } catch (Exception ex) {
      maxInt = Integer.MAX_VALUE;
    }
  }

  Map<String, PresentationElement> areas = group.getAreas();
  int counter = 0;
  for(PresentationElement area : areas.values()){
    for(PresentationElement item : area.getItems()) {
      if(item.getItems().size() <= 0 && contentType.contains(item.getContent().getArticleTypeName()) && counter < maxInt) {
        articles.add(item.getContent());
        counter++;
      }
    }
  }
  request.setAttribute(var, articles);
%>