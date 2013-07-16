<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-widget/include.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
This tag checks if there exists any custom view or controller jsp page for the specified widget and places a boolean value
in request scope accordingly
--%>

<%@ tag import="java.net.URL" %>
<%@ tag language="java" body-content="empty" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="id" required="true" rtexprvalue="true" %>
<%@ attribute name="type" required="true" rtexprvalue="true" %> 
<%@ attribute name="widgetName" required="true" rtexprvalue="true" %>
<%@ attribute name="name" required="true" rtexprvalue="true" %>

<%
  String path = "";
  if(type.equalsIgnoreCase("view")) {
    path = "/template/widgets/" + widgetName + "/view/custom/" + name + ".jsp";
  } else if(type.equalsIgnoreCase("controller")) {
    path = "/template/widgets/" + widgetName + "/controller/" + name + ".jsp";
  }

  URL realPath = config.getServletContext().getResource(path);

  if (realPath != null) {
    request.setAttribute(id, Boolean.TRUE);
  } else {
    request.setAttribute(id, Boolean.FALSE);
  }
%>
