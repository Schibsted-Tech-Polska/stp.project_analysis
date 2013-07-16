<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-pageTools/src/main/webapp/template/widgets/pageTools/view/custom.jsp#1 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<jsp:useBean id="pageTools" type="java.util.Map" scope="request"/>

<div class="${pageTools.wrapperStyleClass}"<c:if test="${not empty pageTools.styleId}"> id="${pageTools.styleId}"</c:if>  >
  <div class="article-links">
    <%--<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;pub=xa-4a9648561eeb57e7">
    <img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share"
    style="border:0"/>
    </a>--%>
    <%--<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4a9648561eeb57e7"></script>--%>
    <jsp:include page="helpers/fontSizeSelector.jsp"/>
    <jsp:include page="helpers/emailPopupBox.jsp"/>                                           
    <jsp:include page="helpers/printContent.jsp"/>
  </div>

</div>

<c:remove var="pageTools" scope="request"/>


 