<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/newsletter-config.jsp#1 $
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
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<table align="center" cellspacing="0" cellpadding="0" width="628">
  <tr>
    <td width="100%">

      <table cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td width="100%" valign="top">
            <%-- top area --%>
            <c:set var="currentAreaName" value="header" scope="request"/>

            <c:set var="area" value="header" scope="request"/>
            <jsp:include page="getitems.jsp"/>
            <c:remove var="area" scope="request"/>

            <c:set var="elementwidth" value="628" scope="request"/>

            <c:set var="level" value="0" scope="request"/>
            <jsp:include page="showitems.jsp"/>
            <c:remove var="level" scope="request"/>
          </td>
        </tr>
      </table>

      <table cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td width="468" valign="top">
            <%-- main area --%>
            <c:set var="currentAreaName" value="main" scope="request"/>
            <c:set var="area" value="main" scope="request"/>
            <jsp:include page="getitems.jsp"/>
            <c:remove var="area" scope="request"/>

            <c:set var="elementwidth" value="468" scope="request"/>

            <c:set var="level" value="0" scope="request"/>
            <jsp:include page="showitems.jsp"/>
            <c:remove var="level" scope="request"/>
          </td>
          <%-- right area --%>
          <c:set var="currentAreaName" value="right" scope="request"/>

          <c:set var="area" value="right" scope="request"/>
          <jsp:include page="getitems.jsp"/>
          <c:remove var="area" scope="request"/>

          <c:set var="elementwidth" value="300" scope="request"/>

          <c:set var="level" value="0" scope="request"/>
          <c:if test="${not empty items}">
            <td valign="top" width="160">
              <jsp:include page="showitems.jsp"/>
            </td>
          </c:if>
          <c:remove var="level" scope="request"/>
        </tr>
      </table>

      <table>
        <tr>
          <td width="100%" valign="top">
            <c:set var="currentAreaName" value="footer" scope="request"/>
            <c:set var="area" value="footer" scope="request"/>
            <jsp:include page="getitems.jsp"/>
            <c:remove var="area" scope="request"/>

            <c:set var="elementwidth" value="628" scope="request"/>

            <c:set var="level" value="0" scope="request"/>
            <jsp:include page="showitems.jsp"/>
            <c:remove var="level" scope="request"/>
          </td>
        </tr>
      </table>

    </td>
  </tr>
</table>