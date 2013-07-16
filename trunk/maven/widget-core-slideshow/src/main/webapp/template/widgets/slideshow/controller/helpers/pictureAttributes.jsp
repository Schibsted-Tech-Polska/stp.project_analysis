<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-slideshow/src/main/webapp/template/widgets/slideshow/controller/helpers/pictureAttributes.jsp#1 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- declare the map that will contain relevant field values / collections --%>
<jsp:useBean id="slideshow" type="java.util.HashMap" scope="request"/>

<c:set var="picture" value="${slideshow.slideshowPictures[0]}"/>

<c:set target="${slideshow}" property="pictureId" value="widget${widgetContent.id}-picture${picture.content.id}" />
<c:set target="${slideshow}" property="pictureCaption" value="${fn:trim(picture.fields.caption)}" />
<c:set target="${slideshow}" property="pictureCredits" value="${fn:trim(picture.fields.photographer)}" />
