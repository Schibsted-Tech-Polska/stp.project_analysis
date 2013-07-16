<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/profiling/turnOff.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false"%>

<%
  if(pageContext.getServletContext().getAttribute("neo.util.servlet.RequestInfo.StatisticsSource") != null) {
    pageContext.getServletContext().removeAttribute("neo.util.servlet.RequestInfo.StatisticsSource");
  }
%>