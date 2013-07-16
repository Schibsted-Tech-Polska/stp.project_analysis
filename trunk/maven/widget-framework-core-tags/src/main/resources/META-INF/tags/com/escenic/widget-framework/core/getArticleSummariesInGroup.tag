<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getArticleSummariesInGroup.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ tag import="neo.xredsys.presentation.PresentationElement" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.Map" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="group" required="true" rtexprvalue="true" type="neo.xredsys.presentation.PresentationElement" %>
<%@ attribute name="contentType" required="true" rtexprvalue="true" %>
<%@ attribute name="max" required="false" rtexprvalue="true" %>

<%
    List<PresentationElement> articles = new ArrayList<PresentationElement>();
    int maxInt = Integer.MAX_VALUE;
    contentType = contentType.trim();

    if (max != null) {
        try {
            maxInt = Integer.parseInt(max);
        } catch (Exception ex) {
            maxInt = Integer.MAX_VALUE;
        }
    }

    if (group != null) {
        Map<String, PresentationElement> areas = group.getAreas();
        int counter = 0;

        if (areas != null && areas.size() > 0) {
            for (PresentationElement area : areas.values()) {
                List<PresentationElement> items = area.getItems();

                if (items != null && items.size() > 0) {
                    for (PresentationElement item : items) {

                        // if contentType is empty, then all types of articles are addded, otherwise only mentioned types of articles are added
                        try {
                            if ((item.getItems() == null || item.getItems().size() <= 0) && (contentType.length() == 0 || contentType.contains(item.getContent().getArticleTypeName())) && counter < maxInt) {
                                articles.add(item);
                                counter++;
                            }
                        } catch (Exception e) {
                           System.err.println("Exception while adding articles to list in getArticleSummariesInGroup.tag: " + e.getMessage());
                        }
                    }
                }
            }
        }
    }
    request.setAttribute(var, articles);
%>