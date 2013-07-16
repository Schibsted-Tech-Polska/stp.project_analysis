<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-widget/notPresent.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/06/22 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ tag language="java" import="neo.xredsys.content.type.TypeManager, neo.xredsys.content.type.ArticleType" %>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="name" %>

<bean:define id="pub" name="publication" type="neo.xredsys.api.Publication"/>
<%
  final String widgetPrefixString = "widget_";
  TypeManager typeManager = TypeManager.getInstance();
  boolean found = false;
  try {
    ArticleType type = typeManager.getArticleType(pub.getId(), widgetPrefixString + name);
    if (type != null) {
      found = true;
    }
  }
  catch (Exception ex) {
    found = false;
  }
  if (!found) {
%>
    <jsp:doBody/>
<%
  }
%>
