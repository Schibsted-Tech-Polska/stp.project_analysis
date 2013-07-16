<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileTicker/src/main/webapp/template/widgets/mobileTicker/view/default.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<jsp:useBean id="mobileTicker" type="java.util.HashMap" scope="request"/>

<dxw:ticker direction="${mobileTicker.direction}" duration="${mobileTicker.duration}" timeout="${mobileTicker.timeout}"
            itemId="${mobileTicker.styleId}" cssClass="${mobileTicker.wrapperStyleClass}">
  <c:forEach var="item" begin="${mobileTicker.begin}" end="${mobileTicker.end}"
             items="${mobileTicker.articleSummaries}">
    <wf-core:handleLineBreaks var="modifiedTitle" value="${item.fields.title.value}"/>

    <dxw:tickerItem href="${item.content.url}">
      <dxf:out><c:out value="${requestScope.modifiedTitle}" escapeXml="false"/></dxf:out>
    </dxw:tickerItem>

    <c:remove var="modifiedTitle" scope="request"/>
  </c:forEach>
</dxw:ticker>

<c:remove var="mobileTicker" scope="request"/>
