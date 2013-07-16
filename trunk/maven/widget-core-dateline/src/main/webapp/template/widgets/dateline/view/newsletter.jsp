<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-dateline/src/main/webapp/template/widgets/dateline/view/newsletter.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- the controller has already set a HashMap named 'dateline' in the requestScope --%>
<jsp:useBean id="dateline" type="java.util.HashMap" scope="request"/>

<table class="${dateline.wrapperStyleClass}" rules="cols" cellspacing="2" cellpadding="2" border="0">
  <tr>
    <td valign="top"
        style="color:#666666;font-family:Arial,Verdana,Helvetica,sans-serif; font-size:12px; font-weight:lighter;">
      <c:out value="${dateline.currentDate}" escapeXml="true"/>
    </td>
    <td valign="top" align="right"
        style="color:#666666;font-family:Arial,Verdana,Helvetica,sans-serif; font-size:12px; font-weight:lighter;">
      <fmt:message key="dateline.widget.default.lastModifiedDate.prefix">
        <fmt:param value="${dateline.lastModifiedDate}"/>
      </fmt:message>
    </td>
  </tr>
</table>
<c:remove var="dateline" scope="request"/>