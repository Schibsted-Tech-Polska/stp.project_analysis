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
<%@ tag import="java.util.Collection" %>
<%@ tag import="neo.xredsys.presentation.PresentationArticle" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="neo.xredsys.presentation.PresentationLoader" %>
<%@ tag import="com.escenic.servlet.ApplicationBus" %>
<%@ tag import="neo.xredsys.api.*" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="listName" required="true" rtexprvalue="true" %>
<%@ attribute name="contentType" required="true" rtexprvalue="true" %>
<%@ attribute name="max" required="false" rtexprvalue="true" %>

<%
  List<PresentationArticle> articleList = new ArrayList<PresentationArticle>();
  int maxInt = Integer.MAX_VALUE;

  if (max != null) {
    try {
      maxInt = Integer.parseInt(max);
    } catch (Exception ex) {
      maxInt = Integer.MAX_VALUE;
    }
  }

  try {
    Section section = (Section) request.getAttribute("section");
    Collection<ListPool> lists = section.getLists();
    ListPool targetList = null;

    for (ListPool list : lists) {
      if (list.getName().equals(listName)) {
        targetList = list;
        break;
      }
    }

    if (targetList != null) {
      EditableContentList contentList = targetList.getContentList();
      EditableContentList.Value items = contentList.getItems();
      Collection<EditableContentList.Handle> handles = items.getHandles();
      int count = 0;
      String presentationLoaderFactoryName = "/neo/xredsys/presentation/PresentationLoader";
      PresentationLoader presentationLoader = (PresentationLoader) ApplicationBus.getApplicationBus(application).lookupSafe(presentationLoaderFactoryName);

      for (EditableContentList.Handle handle : handles) {
        IOHashKey key = handle.getHashKey();       
        PresentationArticle article = presentationLoader.getArticle(key.getObjectId());
        if (article != null && contentType.contains(article.getArticleTypeName()) && count < maxInt) {
          articleList.add(article);
          count++;
        }
      }
    }
  } catch (Exception ex) {
    System.err.println(ex);
  }

  request.setAttribute(var, articleList);
%>