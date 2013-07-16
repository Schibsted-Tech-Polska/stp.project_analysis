<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/countArticleComments.tag#1 $
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
<%@ tag import="com.escenic.geocode.utils.KMLUtils" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="geoData" required="true" rtexprvalue="true" %>

<%
  List geoFields = new ArrayList();

  if (!StringUtils.isBlank(geoData)) {
    try {
      geoFields = KMLUtils.getGeoFields(geoData);
    } catch (Exception ex) {
      System.err.println(ex);
    }
  }

  request.setAttribute(var, geoFields);
%>