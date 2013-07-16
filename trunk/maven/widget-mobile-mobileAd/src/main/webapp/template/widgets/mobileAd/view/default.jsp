<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileAd/src/main/webapp/template/widgets/mobileAd/view/default.jsp#2 $
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
<%--JSLT related important tags--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>

<jsp:useBean id="mobileAd" type="java.util.HashMap" scope="request"/>


<dxf:div cssClass="${mobileAd.wrapperStyleClass}" id="${mobileAd.styleId}">
  <dxf:a href="${mobileAd.url}" title="${mobileAd.aTitle}">
    <c:choose>
      <c:when test="${mobileAd.renderImage eq 'true'}">

        <dxf:img size="${mobileAd.size}" src="${mobileAd.adImage.content.fields.binary.value.original}"
                 alt="${mobileAd.adImage.content.fields.alttext.value}"/>
      </c:when>
      <c:otherwise>
        <c:out value="${mobileAd.aText}" escapeXml="true"/>
      </c:otherwise>
    </c:choose>
  </dxf:a>
</dxf:div>
