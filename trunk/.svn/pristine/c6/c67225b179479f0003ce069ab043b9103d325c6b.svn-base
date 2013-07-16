<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/renderFormFields.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--The purpose of this tag is to render the fields defined in the content-type definition. Panel
 names can be specified and only the fields within the specified panels will be shown--%>
<%@ tag language="java" body-content="empty" isELIgnored="false" %>
<%@ attribute name="id" required="true" rtexprvalue="false" %>
<%@ attribute name="value" required="true" rtexprvalue="true" %>
<%@ attribute name="maxLength" required="false" rtexprvalue="true" %>
<%@ tag import="java.util.regex.Pattern" %>
<%@ tag import="com.twelvemonkeys.lang.StringUtil" %>
<%@ tag import="com.escenic.framework.util.HtmlUtil" %>

<%
  int length = value.length();

  if (!StringUtil.isEmpty(maxLength)) {
    try {
      length = Integer.parseInt(maxLength);
    } catch (Exception ex) {
      length = value.length();
    }
  }

  String result = HtmlUtil.stripHtml(value);

  if (!StringUtil.isEmpty(result) && result.length() > length) {
    result = result.substring(0, length);
    result += "...";
  }
  
  request.setAttribute(id, result);
%>