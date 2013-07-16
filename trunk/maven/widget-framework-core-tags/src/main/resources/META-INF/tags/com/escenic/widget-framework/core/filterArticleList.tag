<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/filterArticleList.tag#1 $
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
<%@ tag import="java.util.Iterator" %>
<%@ tag import="neo.xredsys.presentation.PresentationArticle" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="articles" type="java.util.Collection" required="true" rtexprvalue="true" %>
<%@ attribute name="articleId" required="true" rtexprvalue="true" %>
<%@ attribute name="maxSize" required="true" rtexprvalue="true" %>

<%
  int targetArticleId = Integer.parseInt(articleId);
  int size = Integer.parseInt(maxSize);
  List resultList = new ArrayList();

  if (articles != null) {
    for (Iterator iter = articles.iterator(); iter.hasNext(); ) {
      PresentationArticle article = (PresentationArticle) iter.next();
      
      if (article.getId() != targetArticleId) {
        resultList.add(article);
      }
    }

    if (resultList.size() == size && size > 0) {
      resultList.remove(size - 1);
    }
  }

  request.setAttribute(var, resultList);
%>