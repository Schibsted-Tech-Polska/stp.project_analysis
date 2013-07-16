<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileTextSize/src/main/webapp/template/widgets/mobileTextSize/view/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
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
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<jsp:useBean id="mobileTextSize" type="java.util.HashMap" scope="request"/>

<dxf:div cssClass="${mobileTextSize.wrapperStyleClass}" id="${mobileTextSize.styleId}" >
  <dxw:textsize itemId="textsize-${widgetContent.id}" targetCssClass="${mobileTextSize.targetClass}" currentClassVar="fallbackClass" defaultSize="${mobileTextSize.defaultFont}">
 <jsp:attribute name="preFragment" >
	    </jsp:attribute>
    <jsp:attribute name="inFragment">
        <dxf:span cssClass="${dx_class_name}">A</dxf:span>
    </jsp:attribute>
	    <jsp:attribute name="postFragment">
	        &nbsp;
	    </jsp:attribute>
  </dxw:textsize>
</dxf:div>

<c:remove var="mobileTextSize" scope="request"/>
