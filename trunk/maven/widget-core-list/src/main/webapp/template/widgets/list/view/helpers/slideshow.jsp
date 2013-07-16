<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-list/src/main/webapp/template/widgets/list/view/helpers/slideshow.jsp#1 $
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

<%-- declare the map that contains relevant field values--%>
<jsp:useBean id="slideshow" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="list" type="java.util.Map" scope="request"/>

<script type="text/javascript" src="${requestScope.resourceUrl}js/simple.gallery.js"></script>

<script type="text/javascript">
  // <![CDATA[
  var mygallery = new simpleGallery({

    wrapperid: "${slideshow.slideshowDivId}",
    dimensions: [${slideshow.width}, ${slideshow.height}],
    imagearray: [${slideshow.imageGallery}],
    autoplay: [${slideshow.autoplay}, ${slideshow.slideDuration}000, 2],
    persist: false,
    fadeduration: 500,
    shownav:true,

    /* custom configurations */
    navStatusText: " ${slideshow.navStatusText} ",
    prevButtonUrl: "${slideshow.prevButtonUrl}",
    nextButtonUrl: "${slideshow.nextButtonUrl}",
    prevButtonTitle:"${slideshow.prevButtonTitle}",
    nextButtonTitle:"${slideshow.nextButtonTitle}",
    infoStyleClass: "${slideshow.infoStyleClass}",
    slideNav: ${list.slideNav},

    oninit:function() { },
    onslide:function(curslide, i) { }
  });
  // ]]>
</script>

<div id="${slideshow.slideshowDivId}" class="slideshowContainer">&nbsp;</div>