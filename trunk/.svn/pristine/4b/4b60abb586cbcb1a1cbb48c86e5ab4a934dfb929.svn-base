<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getLoginUrl.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="imageVersion" required="true" rtexprvalue="true" %>

<%
  Map<String, String> dimensionMap = new HashMap<String, String>();
  int width = 140;
  int height = 79;

  if (!StringUtils.isEmpty(imageVersion)) {
    if (imageVersion.equalsIgnoreCase("w55")) {
      width = 55;
      height = 45;
    } else if (imageVersion.equalsIgnoreCase("w80")) {
      width = 80;
      height = 58;
    } else if (imageVersion.equalsIgnoreCase("w100")) {
      width = 100;
      height = 75;
    } else if (imageVersion.equalsIgnoreCase("w140")) {
      width = 140;
      height = 88;
    } else if (imageVersion.equalsIgnoreCase("w220")) {
      width = 220;
      height = 135;
    } else if (imageVersion.equalsIgnoreCase("w300")) {
      width = 300;
      height = 185;
    } else if (imageVersion.equalsIgnoreCase("w380")) {
      width = 380;
      height = 235;
    } else if (imageVersion.equalsIgnoreCase("w460")) {
      width = 460;
      height = 286;
    } else if (imageVersion.equalsIgnoreCase("w620")) {
      width = 620;
      height = 385;
    } else if (imageVersion.equalsIgnoreCase("w700")) {
      width = 700;
      height = 435;
    } else if (imageVersion.equalsIgnoreCase("w940")) {
      width = 940;
      height = 585;
    } else {
      if ((imageVersion.charAt(0) == 'w' || imageVersion.charAt(0) == 'W') && imageVersion.length() > 1) {
        String widthString = imageVersion.substring(1);

        try {
          width = Integer.parseInt(widthString);
          height = (int) Math.ceil(0.5625 * width);
        } catch (Exception ex) {
          System.err.println(ex);
        }
      }
    }

    dimensionMap.put("width", Integer.toString(width));
    dimensionMap.put("height", Integer.toString(height));
  }

  request.setAttribute(var, dimensionMap);
%>