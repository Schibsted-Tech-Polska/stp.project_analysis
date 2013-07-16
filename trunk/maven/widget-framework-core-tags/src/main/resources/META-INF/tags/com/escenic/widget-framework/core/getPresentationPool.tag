<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getPresentationPool.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #6 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="neo.xredsys.presentation.PresentationLoader" %>
<%@ tag import="neo.xredsys.presentation.PresentationPool" %>
<%@ tag import="neo.xredsys.api.Section" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="section" required="false" rtexprvalue="true" type="neo.xredsys.api.Section" %>

<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<bean:define id="presentationLoader" name="com.escenic.presentation.PresentationLoader"
             type="neo.xredsys.presentation.PresentationLoader" />

<%
  PresentationPool ePresentationPool = null;

  if (!StringUtils.isEmpty(request.getParameter("poolId")) && request.getAttribute("pool") != null && section != null) {
    Section currentSection = (Section) request.getAttribute("section");

    if (section.getName().equals(currentSection.getName())) {
      ePresentationPool = (PresentationPool) request.getAttribute("pool");
    }   
  }

  if (ePresentationPool == null) {
    if (section == null) {
      section = (Section) request.getAttribute("section");
    }

    try {
      ePresentationPool = presentationLoader.getActivePool(section.getId());
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  request.setAttribute(var, ePresentationPool);  
%>


