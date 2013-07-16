<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/filterArticleList.tag#1 $
 * Last edited by : $Author: okr $ $Date: 2010/05/11 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="neo.xredsys.presentation.PresentationElement" %>
<%@ tag import="neo.xredsys.presentation.PresentationArticle" %>
<%@ tag import="neo.xredsys.presentation.PresentationProperty" %>
<%@ tag import="java.util.Iterator" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.Enumeration" %>
<%@ tag import="com.escenic.framework.util.WidgetMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="var" required="true" rtexprvalue="true" %>

<%
  /**
   *  This controller tag can be used for setting the
   *  widget content type fields in a map
   *  resulting in a custom WidgetMap in the context
   */

  WidgetMap<String, Object> widgetMap = new WidgetMap<String, Object>();
  PresentationArticle presentationArticle = (PresentationArticle) request.getAttribute("widgetContent");

  for (String fieldName : presentationArticle.getFieldNames())  {
    PresentationProperty presentationProperty = presentationArticle.getFields().get(fieldName);
    if (presentationProperty.getValue() instanceof String) {
      widgetMap.put(fieldName, presentationProperty.toString().trim());
    }
    else {
       widgetMap.put(fieldName, presentationProperty.getValue());
    }
  }

  request.setAttribute(var, widgetMap);
%>