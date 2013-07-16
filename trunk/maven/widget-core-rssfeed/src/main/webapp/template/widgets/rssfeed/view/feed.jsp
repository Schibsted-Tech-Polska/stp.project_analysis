<%@ page language="java" pageEncoding="UTF-8" contentType="application/rss+xml; charset=UTF-8" %>
<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-article" prefix="article" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="publication" scope="request" type="neo.xredsys.api.Publication"/>
<jsp:useBean id="section" scope="request" type="neo.xredsys.api.Section"/>
<c:url var="feedUrl" value="${section.url}?${pageContext.request.queryString}"/>
<rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <channel>
        <title><c:out value="${publication.name} - ${section.name}" escapeXml="true"/></title>
        <link>${publication.url}</link>
       
        <description><c:out value="${section.parameters['rss.description']}"/></description>
        <language>en</language>
        <copyright><c:out value="${section.parameters['rss.copyright']}"/></copyright>
        <webMaster><c:out value="${section.parameters['rss.webmaster']}"/></webMaster>
        <pubDate><fmt:formatDate value="${section.lastModified}" pattern="EEE, dd MMM yyyy HH:mm:ss Z"/></pubDate>
        <lastBuildDate><fmt:formatDate value="${section.lastModified}" pattern="EEE, dd MMM yyyy HH:mm:ss Z"/></lastBuildDate>
        <ttl>${section.parameters['rss.ttl']}</ttl>
        <category><c:out value="${section.name}"/></category>
        <c:forEach items="${rssfeed.articles}" begin="0" end="${rssfeed.maxArticles-1}" var="art">
            <jsp:useBean id="art" scope="page" type="neo.xredsys.presentation.PresentationArticle"/>
            <item>
                <title><c:out value="${art.fields.TITLE}" escapeXml="true"/></title>
                <description><c:out value="${art.fields.LEADTEXT}" escapeXml="true" /></description>
                <dc:date><fmt:formatDate value="${art.publishedDateAsDate}" pattern="EEE, dd MMM yyyy HH:mm:ss Z"/></dc:date>
                <guid><c:out value="${art.url}" escapeXml="true"/></guid>
                <image url="http://images.bt.no/btno/multimedia/dynamic/00677/narko_jpg_677933g.jpg"></image>
                <link><c:out value="${art.url}" escapeXml="true"/></link>
                


                
            </item>
        </c:forEach>
    </channel>
</rss>