<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/includeESI.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/10/04 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="java.net.URI" %>
<%@ tag import="com.sun.syndication.fetcher.impl.HttpURLFeedFetcher" %>
<%@ tag import="com.sun.syndication.fetcher.FeedFetcher" %>
<%@ tag import="com.sun.syndication.fetcher.impl.HashMapFeedInfoCache" %>
<%@ tag import="com.sun.syndication.fetcher.impl.FeedFetcherCache" %>
<%@ tag import="com.sun.syndication.feed.synd.SyndFeed" %>
<%@ tag import="java.util.*" %>
<%@ tag import="com.sun.syndication.feed.synd.SyndEntry" %>

<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="sourceUrls" type="java.util.Collection" required="true" rtexprvalue="true" %>
<%@ attribute name="maxArticles" required="true" rtexprvalue="true" %>

<%
  int max;

  try {
    max = Integer.parseInt(maxArticles);
  } catch (Exception ex) {
    max = 1;
  }

  List syndEntryList = new ArrayList();
  List resultList = new ArrayList();

  try {
    FeedFetcherCache feedInfoCache = HashMapFeedInfoCache.getInstance();
	  FeedFetcher feedFetcher = new HttpURLFeedFetcher(feedInfoCache);
    
    Iterator iter = sourceUrls.iterator();

    while (iter.hasNext()) {
      URI uri = (URI) iter.next();
      SyndFeed feed = feedFetcher.retrieveFeed(uri.toURL());
      syndEntryList.addAll(feed.getEntries());
    }

    Collections.sort(syndEntryList, new Comparator() {
      public int compare(Object obj1, Object obj2) {
        SyndEntry entry1 = (SyndEntry) obj1;
        SyndEntry entry2 = (SyndEntry) obj2;

            // added check to avoid nullpointer on feeds without publishedDate
          if(entry2.getPublishedDate() != null)
            return entry2.getPublishedDate().compareTo(entry1.getPublishedDate());
          else
            return 0;
      }
    });

    int n;
    
    if (max < syndEntryList.size()) {
      n = max;
    } else {
      n = syndEntryList.size();
    }

    for (int i = 0; i < n; i++) {
      resultList.add(syndEntryList.get(i));
    }
  } catch (Exception ex) {
    System.err.println(ex);
  }

  request.setAttribute(id, resultList);
%>