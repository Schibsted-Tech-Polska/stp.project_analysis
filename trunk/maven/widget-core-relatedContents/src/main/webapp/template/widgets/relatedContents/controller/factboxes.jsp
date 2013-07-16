<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/controller/factboxes.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this is the controller for the related factboxes view of the relatedContents widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>

<%-- the general controller has already set a HashMap named 'relatedContents' in the request scope --%>
<jsp:useBean id="relatedContents" type="java.util.HashMap" scope="request"/>

<%-- fields from factboxes panel --%>
<c:set var="softCropFactBox" value="${fn:trim(widgetContent.fields.softCropFactBox.value)}" />

<c:set var="imageVersionFactBox" value="${fn:trim(widgetContent.fields.imageVersionFactBox.value)}" />
<%-- width of representation --%>
<c:if test="${empty imageVersionFactBox}">
  <c:set var="areaWidth" value="${requestScope.elementwidth > 940 ? '940' : requestScope.elementwidth}" />
  <c:set var="areaWidth" value="${empty areaWidth ? '140' : areaWidth}" />
  <c:set var="imageVersionFactBox" value="w${areaWidth}"/>  
</c:if>

<%-- get related factbox --%>
<c:set var="factboxRelItems" value="${article.relatedElements.factboxRel.items}"/>

<%-- set begin and end index either from advanced panel fields or default --%>
<c:set var="beginIndex" value="${relatedContents.beginIndex}"/>
<c:set var="endIndex" value="${relatedContents.endIndex}"/>
<c:if test="${empty beginIndex or beginIndex >= fn:length(factboxRelItems) or beginIndex > endIndex}">
  <c:set var="beginIndex" value="0" />
</c:if>
<c:if test="${empty endIndex or endIndex >= fn:length(factboxRelItems)}">
  <c:set var="endIndex" value="${fn:length(factboxRelItems) > 0 ? fn:length(factboxRelItems)-1 : 0}"/>
</c:if>

<%-- create an ArrayList with the selected factboxes --%>
<collection:createList id="relatedFactboxes" type="java.util.ArrayList"/>
<c:forEach items="${factboxRelItems}" begin="${beginIndex}" end="${endIndex}" step="1" var="factboxRelItem">
  <c:if test="${factboxRelItem.content.articleTypeName=='factbox'}">

    <%-- retrieve title of the factbox --%>
    <c:set var="relatedFactboxTitle" value="${factboxRelItem.fields.title}"/>
    <%-- retrieve body of the factbox --%>
    <c:set var="relatedFactboxBody" value="${factboxRelItem.fields.body}"/>

    <%-- retrieve the related images of the factbox (if there is any) and put them in a collection --%>
	  <c:set var="factboxRelImages" value="${factboxRelItem.content.relatedElements.imagesRel.items}"/>
    <collection:createList id="relatedFactboxImages" type="java.util.ArrayList"/>
    <c:forEach items="${factboxRelImages}" var="factboxRelImg">
      <c:if test="${factboxRelImg.content.articleTypeName == 'picture'}">
        <collection:add collection="${relatedFactboxImages}" value="${factboxRelImg}"/>
      </c:if>
    </c:forEach>

    <%-- put title, body & img in a hashmap --%>
    <jsp:useBean id="factboxHash" class="java.util.HashMap"/>
    <c:set target="${factboxHash}" property="title" value="${relatedFactboxTitle}"/>
    <c:set target="${factboxHash}" property="body" value="${relatedFactboxBody}"/>
    <c:set target="${factboxHash}" property="inpageTitleClass" value="${factboxRelItem.fields.title.options.inpageClasses}"/>
    <c:set target="${factboxHash}" property="inpageBodyClass" value="${factboxRelItem.fields.body.options.inpageClasses}"/>
    <c:set target="${factboxHash}" property="images" value="${relatedFactboxImages}"/>

    <%-- push the hashmap into the collection --%>
    <collection:add collection="${relatedFactboxes}" value="${factboxHash}"/>
    <c:remove var="factboxHash"/>
  </c:if>
</c:forEach>

<%-- store every information inside the map --%>
<c:set target="${relatedContents}" property="factboxes" value="${relatedFactboxes}"/>
<c:set target="${relatedContents}" property="showTitleFactBox" value="${fn:trim(widgetContent.fields.showTitleFactBox.value)}"/>
<c:set target="${relatedContents}" property="showBodyFactBox" value="${fn:trim(widgetContent.fields.showBodyFactBox.value)}"/>
<c:set target="${relatedContents}" property="showImageFactBox" value="${fn:trim(widgetContent.fields.showImageFactBox.value)}"/>
<c:set target="${relatedContents}" property="imageVersionFactBox" value="${imageVersionFactBox}"/>
<c:set target="${relatedContents}" property="softCropFactBox" value="${fn:trim(widgetContent.fields.softCropFactBox.value)}"/>