<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/group/x620x300-extended-config.jsp#1 $
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

<div id="outer" class="x620x300-extended-config">
  <c:set var="currentAreaName" value="outer" scope="request" />

  <c:set var="area" value="outer" scope="request" />
  <jsp:include page="getitems.jsp" />
  <c:remove var="area" scope="request" />

  <c:set var="elementwidth" value="940" scope="request"/>

  <c:set var="level" value="0" scope="request" />
  <jsp:include page="showitems.jsp" />
  <c:remove var="level" scope="request" />
</div>

<div id="page" class="x620x300-extended-config">
  <div id="header"> <!--pageHeader-->
    <c:set var="currentAreaName" value="header" scope="request" />

    <c:set var="area" value="header" scope="request" />
    <jsp:include page="getitems.jsp" />
    <c:remove var="area" scope="request" />

    <c:set var="elementwidth" value="940" scope="request"/>

    <c:set var="level" value="0" scope="request" />
    <jsp:include page="showitems.jsp" />
    <c:remove var="level" scope="request" />
  </div>

  <div id="content"> <!--pageBody-->
    <div id="areas">
      <div id="main"> <!--mainContent-->
        <c:set var="currentAreaName" value="main" scope="request" />

        <c:set var="area" value="main" scope="request" />
        <jsp:include page="getitems.jsp" />
        <c:remove var="area" scope="request" />

        <c:set var="elementwidth" value="620" scope="request"/>

        <c:set var="level" value="0" scope="request" />
        <jsp:include page="showitems.jsp" />
        <c:remove var="level" scope="request" />

      </div>

      <div id="right"> <!--rightColumn-->
        <c:set var="currentAreaName" value="right" scope="request" />

        <c:set var="area" value="right" scope="request" />
        <jsp:include page="getitems.jsp" />
        <c:remove var="area" scope="request" />

        <c:set var="elementwidth" value="300" scope="request"/>

        <c:set var="level" value="0" scope="request" />
        <jsp:include page="showitems.jsp" />
        <c:remove var="level" scope="request" />
      </div>
    </div>
  </div>

  <div id="footer"> <!--pageFooter-->
    <c:set var="currentAreaName" value="footer" scope="request" />

    <c:set var="area" value="footer" scope="request" />
    <jsp:include page="getitems.jsp" />
    <c:remove var="area" scope="request" />

    <c:set var="elementwidth" value="940" scope="request"/>

    <c:set var="level" value="0" scope="request" />
    <jsp:include page="showitems.jsp" />
    <c:remove var="level" scope="request" />
  </div>

</div>