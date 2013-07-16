<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getPicturesInGroup.tag#1 $
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
<%@ tag import="neo.xredsys.presentation.PresentationElement" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="group" required="true" rtexprvalue="true" type="neo.xredsys.presentation.PresentationElement" %>
<%@ attribute name="contentType" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="max" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="includeArticleRelatedPictures" required="false" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- if includeArticleRelatedPictures == false, then this tag will not include the related pictures from picturerel.
To keep backward compatibility default value of includeArticleRelatedPictures is true. --%>

<%
  List<PresentationElement> pictures = new ArrayList<PresentationElement>();
  int maxInt = Integer.MAX_VALUE;

  if (max != null) {
    try {
      maxInt = Integer.parseInt(max);
    } catch (Exception ex) {
      maxInt = Integer.MAX_VALUE;
    }
  }

  if(contentType == null || contentType.trim().equals("")) {
    contentType = "picture";  
  }

  if(includeArticleRelatedPictures == null){
    includeArticleRelatedPictures = false;
  }

  if (group != null) {
    Map<String, PresentationElement> areas = group.getAreas();
    int counter = 0;
    if (areas != null) {
      for (PresentationElement area : areas.values()) {
        List<PresentationElement> items = area.getItems();

        if (items != null) {
          for (PresentationElement item : items) {
            if (item.getItems().size() <= 0 && counter < maxInt) {
              if (item.getContent().getArticleTypeName().equalsIgnoreCase(contentType)) {
                pictures.add(item);
                counter++;
              } else if (includeArticleRelatedPictures && item.getContent().getRelatedElements().get("pictureRel") != null) {
                List<PresentationElement> storyRelatedPictures = item.getContent().getRelatedElements().get("pictureRel").getItems();
                for (PresentationElement storyRelatedPicture : storyRelatedPictures) {
                  if (storyRelatedPicture.getContent().getArticleTypeName().equalsIgnoreCase(contentType) && counter < maxInt) {
                    pictures.add(storyRelatedPicture);
                    counter++;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  request.setAttribute(var, pictures);
%>