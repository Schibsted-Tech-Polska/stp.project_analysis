<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-webAnalytics/src/main/webapp/template/widgets/webAnalytics/controller/controller.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  This JSP page is the entry point of the webAnalytics widget. It just delegates to a view JSP page with necessary parameters
  which eventually renders all the HTML for the webAnalytics widget.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--create a hashmap named 'webAnalytics' that will contain relevant field values --%>
<jsp:useBean id="webAnalytics" class="java.util.HashMap" scope="request" />

<%-- constants --%>
<%-- retreive necessary parameters --%>
<c:set target="${webAnalytics}" property="view" value="${fn:trim(widgetContent.fields.view)}"/>



