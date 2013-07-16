<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileLogo/src/main/webapp/template/widgets/mobileLogo/view/default.jsp#2 $
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
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>

<jsp:useBean id="mobileLogo" type="java.util.HashMap" scope="request"/>


<dxf:div cssClass="${mobileLogo.wrapperStyleClass}" id="${mobileLogo.styleId}">
  <dxf:a href="${mobileLogo.url}" title="${mobileLogo.aTitle}">
    <c:choose>
      <c:when test="${mobileLogo.renderImage eq 'true'}">

        <dxf:img size="${mobileLogo.size}" src="${mobileLogo.logoPicture.content.fields.binary.value.original}"
                 alt="${mobileLogo.logoPicture.content.fields.alttext.value}"/>
      </c:when>
      <c:otherwise>
        <c:out value="${mobileLogo.aText}" escapeXml="true"/>
      </c:otherwise>
    </c:choose>
  </dxf:a>
</dxf:div>
