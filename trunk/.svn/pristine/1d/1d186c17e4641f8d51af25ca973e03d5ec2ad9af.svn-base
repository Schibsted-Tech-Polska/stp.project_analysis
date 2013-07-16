<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/view/newsletter.jsp#2 $
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%--declare the map that contains relevant field values --%>

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>

<table class="${trailers.wrapperStyleClass}" cellpadding="0" cellspacing="0" style>
  <tr>
    <td>
      <table>
        <c:forEach var="articleMap" items="${trailers.articleMapList}" varStatus="loopStatus">
          <!--index=(${loopStatus.index}) and mod value = (${loopStatus.index mod 2})-->
          <c:if test="${loopStatus.first}">
            <tr>
          </c:if>
          <c:if test="${loopStatus.index mod 2 eq 0 and not loopStatus.first}">
            </tr>
            <tr>
          </c:if>
          <td valign="top" style="border-top:1px dashed #D9D9D9;">
            <c:if test="${loopStatus.count <= trailers.trailerColumnCount}">
              <c:if test="${trailers.showSectionName}">
                <h5
                    style="color:#000000;text-transform:uppercase;font-size:12px;font-weight:bold;margin:0 0 1px 0;">
                    <c:out value="${articleMap.homeSectionName}" escapeXml="true"/>
                </h5>
              </c:if>
              <c:set var="articleAttributeMap" value="${articleMap}" scope="request"/>
              <jsp:include page="helpers/articleList.jsp"/>
              <c:remove var="articlePropertyMap" scope="request"/>
            </c:if>
          </td>
          <c:if test="${loopStatus.last}">
            </tr>
          </c:if>
        </c:forEach>
      </table>
    </td>
  </tr>
</table>
<c:remove var="trailers" scope="request"/>