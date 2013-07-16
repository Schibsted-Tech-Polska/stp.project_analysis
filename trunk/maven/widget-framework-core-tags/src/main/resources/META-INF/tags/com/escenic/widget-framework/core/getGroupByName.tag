<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getGroupByName.tag#1 $
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
<%@ tag import="java.util.Map" %>
<%@ tag import="neo.xredsys.api.Section" %>
<%@ tag import="neo.xredsys.presentation.PresentationPool" %>
<%@ tag import="neo.xredsys.presentation.PresentationElement" %>

<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="groupName" required="true" rtexprvalue="true" %>
<%@ attribute name="areaName" required="true" rtexprvalue="true" %>
<%@ attribute name="pool" required="false" rtexprvalue="true" type="neo.xredsys.presentation.PresentationPool" %>

<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>

<bean:define id="presentationLoader" name="com.escenic.presentation.PresentationLoader"
             type="neo.xredsys.presentation.PresentationLoader" />

<%
  PresentationElement targetPE = null;
  PresentationPool ePresentationPool = null;

  if (pool != null) {
    ePresentationPool = pool;
  } else if (request.getAttribute("pool") != null) {
    ePresentationPool = (PresentationPool) request.getAttribute("pool");
  } else {
    Section section = (Section) request.getAttribute("section");
    ePresentationPool = presentationLoader.getActivePool(section.getId());
  }

  if(ePresentationPool!=null) {
    try {
      PresentationElement rootElement = ePresentationPool.getRootElement();
      Map<String, PresentationElement> allAreas = rootElement.getAreas();
      PresentationElement currentArea = allAreas.get(areaName);
      if (currentArea != null) {
        List<PresentationElement> items = currentArea.getItems();
        if (items != null) {
          for (PresentationElement pe : items) {
            if (pe.getType() != null && pe.getType().equals(groupName)) {
              targetPE = pe;
              break;
            }
          }
        }
      }
    } catch (Exception ex) {
      System.err.println(ex);
      ex.printStackTrace();
    }
  }

  request.setAttribute(var, targetPE);
%>

