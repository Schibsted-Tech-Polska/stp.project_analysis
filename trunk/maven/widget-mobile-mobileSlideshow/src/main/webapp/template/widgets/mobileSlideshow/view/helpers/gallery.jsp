<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-mobile-mobileSlideshow/src/main/webapp/template/widgets/mobileSlideshow/view/helpers/gallery.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf" %>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw" %>

<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="mobileSlideshow" type="java.util.HashMap" scope="request"/>

<dxf:div cssClass="bildspel content">
  <dxw:slideShow cssClass="sshow"
                 id="ss1"
                 imageScale="${mobileSlideshow.size}"
                 skipLinks="true">
    <c:set var="imageRepresentation" value="${mobileSlideshow.imageRepresentation}"/>
    <c:forEach var="item" items="${mobileSlideshow.mobileSlideshowPictures}" varStatus="loopStatus">
      <dxw:slideShowImage id="image${item.content.id}"
                          src="${item.content.fields.alternates.value[imageRepresentation].href}"
                          caption="${fn:trim(item.fields.caption.value)}"/>
    </c:forEach>
  </dxw:slideShow>

  <c:if test="${fn:length(mobileSlideshow.mobileSlideshowPictures) > 1}">
    <dxw:slideShowAction slideShowId="ss1" triggerNextVar="theActionNext" triggerBackVar="theActionBack"
                         typeVar="theType"/>
    <dxf:p cssClass="slideshow_navigation">
      <dxf:span cssClass="slideshow_box">&lt;
        <dxf:a rel="prev" href="${theActionBack}" cssClass="left" id="ss1pid">
          <fmt:message key="mobileSlideshow.widget.previous.button.title"/>
        </dxf:a>
      </dxf:span>
      <dxf:span cssClass="slideshow_box">
        <dxf:a rel="next" href="${theActionNext}" cssClass="left" id="ss1nid">
          <fmt:message key="mobileSlideshow.widget.next.button.title"/>
        </dxf:a>
        &gt;</dxf:span>
    </dxf:p>
  </c:if>
</dxf:div>
