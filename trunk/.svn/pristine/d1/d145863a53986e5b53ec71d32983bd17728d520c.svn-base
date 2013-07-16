<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileWarning/src/main/webapp/template/widgets/mobileWarning/view/default.jsp#1 $
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

<jsp:useBean id="mobileWarning" type="java.util.HashMap" scope="request"/>
<c:if test="${mobileWarning.showJavaScriptWarning or mobileWarning.showCssWarning}">
  <dxf:div cssClass="${mobileWarning.wrapperStyleClass}" id="${mobileWarning.styleId}" >
    <%-- View specific content fields --%>
    <c:if test="${mobileWarning.showCssWarning}">
      <dxw:warning itemId="cssWarning-${widgetContent.id}">
        <jsp:attribute name="nocss">
          <dxf:div cssClass="warning-img-div">
            <img src="${mobileWarning.warningIcon}" alt="" title="" width="${mobileWarning.warningIconWidth}" height="${mobileWarning.warningIconHeight}"/>
          </dxf:div>
           <dxf:div cssClass="warning-txt-div">
              <strong><fmt:message key="mobileWarning.widget.error.css.title"/></strong>
              <br/>
              <fmt:message key="mobileWarning.widget.error.css.message"/>
            </dxf:div>
	          <dxf:div cssClass="warning-empty-div">&nbsp;</dxf:div>
	      </jsp:attribute>
      </dxw:warning>
    </c:if>
    <c:if test="${mobileWarning.showJavaScriptWarning}">
      <dxw:warning itemId="javascriptWarning-${widgetContent.id}">
        <jsp:attribute name="nojavascript">
            <dxf:div cssClass="warning-img-div">
              <img src="${mobileWarning.warningIcon}" alt="" title="" width="${mobileWarning.warningIconWidth}" height="${mobileWarning.warningIconHeight}"/>
            </dxf:div>
            <dxf:div cssClass="warning-txt-div">
              <strong><fmt:message key="mobileWarning.widget.error.javascript.title"/></strong>
              <br/>
              <fmt:message key="mobileWarning.widget.error.javascript.message"/>
            </dxf:div>
             <dxf:div cssClass="warning-empty-div">&nbsp;</dxf:div>
        </jsp:attribute>
      </dxw:warning>
    </c:if>
  </dxf:div>
</c:if>

<c:remove var="mobileWarning" scope="request"/>
