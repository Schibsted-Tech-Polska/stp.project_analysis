<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-navigation/src/main/webapp/template/widgets/navigation/controller/sectiontitle.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the sectiontitle view of navigation widget --%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- the general controller has already set a HashMap named 'navigation' in the requestScope --%>
<jsp:useBean id="navigation" type="java.util.HashMap" scope="request"/>
<c:choose>
  <c:when test="${empty navigation.sectionuniquename}">
    <c:set target="${navigation}" property="sectionname" value="${section.name}"/>
    <c:set target="${navigation}" property="sectionurl" value="${section.url}"/>        
  </c:when>
<c:otherwise>
  <section:use uniqueName="${navigation.sectionuniquename}">    
    <c:set target="${navigation}" property="sectionname" value="${section.name}"/>
    <c:set target="${navigation}" property="sectionurl" value="${section.url}"/>
  </section:use>
</c:otherwise>
</c:choose>

<%--fetching the values of the sectionheader and sectionlinktext which may contain static text and bean properties as well--%>
<c:set var="sectionHeader" scope="request" value="${navigation.sectionheader}" />
<wf-core:evalField id="sectionHeader" inputFieldValue="${sectionHeader}" />
<c:set target="${navigation}" property="sectionheader" value="${sectionHeader}"/>
<c:remove var="sectionHeader" scope="request"/>

<c:set var="sectionLinkText" scope="request" value="${navigation.sectionlinktext}" />
<wf-core:evalField id="sectionlinktext" inputFieldValue="${sectionLinkText}" />
<c:set target="${navigation}" property="sectionlinktext" value="${sectionLinkText}"/>
<c:remove var="sectionLinkText" scope="request"/>





