<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileSlideshow/src/main/webapp/template/widgets/mobileSlideshow/view/default.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--This page generates the default HTML markup for the mobileSlideshow widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<%--declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="mobileSlideshow" type="java.util.Map" scope="request"/>

<c:if test="${not empty mobileSlideshow.mobileSlideshowPictures}">
  <dxf:div cssClass="${mobileSlideshow.wrapperStyleClass}" id="${mobileSlideshow.styleId}">
    <jsp:include page="helpers/gallery.jsp" />
  </dxf:div>
</c:if>

<c:remove var="mobileSlideshow" scope="request"/>

