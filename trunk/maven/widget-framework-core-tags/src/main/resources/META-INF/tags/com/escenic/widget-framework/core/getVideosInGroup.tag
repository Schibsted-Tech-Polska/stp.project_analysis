<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getVideosInGroup.tag#1 $
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
<%@ tag import="org.apache.commons.lang.StringUtils" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="group" required="true" rtexprvalue="true" type="neo.xredsys.presentation.PresentationElement" %>
<%@ attribute name="contentTypes" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="max" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="beginIndex" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="endIndex" required="false" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="fileExtensions" required="false" rtexprvalue="true" type="java.lang.String" %>

<%
  final String VIDEO_CONTENT_TYPES = "simpleVideo, youtubeVideo";

  List<PresentationArticle> videos = new ArrayList<PresentationArticle>();
  int maxInt = Integer.MAX_VALUE;

  if (max != null) {
    try {
      maxInt = Integer.parseInt(max);
    } catch (Exception ex) {
      maxInt = Integer.MAX_VALUE;
    }
  }

  if(contentTypes == null || contentTypes.trim().equals("")) {
    contentTypes = VIDEO_CONTENT_TYPES;
  }

  if(fileExtensions == null || fileExtensions.trim().equals("")) {
    fileExtensions = "";
  }

  if (group != null) {
    Map<String, PresentationElement> areas = group.getAreas();
    int counter = 0;
    
    if (areas != null) {
      for (PresentationElement area : areas.values()) {
        for (PresentationElement item : area.getItems()) {
          if (item.getItems().size() <= 0 && counter < maxInt) {
            if (contentTypes.contains(item.getContent().getArticleTypeName()) && matchFileExtension(item.getContent(), fileExtensions)) {
              videos.add(item.getContent());
              counter++;
            } else if (item.getContent().getRelatedElements().get("videoRel") != null) {
              List<PresentationElement> storyRelatedVideos = item.getContent().getRelatedElements().get("videoRel").getItems();
              for (PresentationElement storyRelatedVideo : storyRelatedVideos) {
                if (contentTypes.contains(storyRelatedVideo.getContent().getArticleTypeName()) &&
                    matchFileExtension(storyRelatedVideo.getContent(), fileExtensions) && counter < maxInt) {

                  videos.add(storyRelatedVideo.getContent());
                  counter++;
                }
              }
            }
          }
        }
      }
    }
  }

  if(videos.size()>0 && beginIndex!=null) {
    int beginIndexInt = 0;
    try {
      beginIndexInt = Integer.parseInt(beginIndex);
    } catch (Exception ex) {
      beginIndexInt = 0;
    }

    int endIndexInt = videos.size()-1;
    if(endIndex!=null) {
      try {
        endIndexInt = Integer.parseInt(endIndex);
      } catch (Exception ex) {
        endIndexInt = videos.size()-1;
      }
    }

    if(endIndexInt>videos.size()-1) {
      endIndexInt = videos.size()-1;      
    }

    if(beginIndexInt!=0 || endIndexInt!=videos.size()-1) {
      videos = videos.subList(beginIndexInt, endIndexInt+1);
    }
  }
  
  request.setAttribute(var, videos);
%>

<%!
  boolean matchFileExtension(PresentationArticle pVideoArticle, String pFileExtensions) {
    boolean matchFound = false;
    final String SIMPLE_VIDEO_CONTENT_TYPE = "simpleVideo";

    if(StringUtils.isEmpty(pFileExtensions)) {
      return true;
    }

    if(!pVideoArticle.getArticleTypeName().equalsIgnoreCase(SIMPLE_VIDEO_CONTENT_TYPE)) {
      return false;
    }

    Object binaryFieldObject = pVideoArticle.getFields().get("BINARY").getValue();

    if(binaryFieldObject instanceof Map)  {
      Map binaryFieldMap = (Map) binaryFieldObject;
      String videoUrl = binaryFieldMap.get("href").toString();
      String videoFileExtension = StringUtils.substringAfterLast(videoUrl, ".");

      return StringUtils.containsIgnoreCase(pFileExtensions, videoFileExtension);
    }

    return matchFound;
  }
%>