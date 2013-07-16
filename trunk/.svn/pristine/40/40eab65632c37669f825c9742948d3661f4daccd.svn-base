<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>

<%-- some mobile stuff --%>
<c:set var="area" value="top" scope="request" />
<c:set var="currentAreaName" value="top" scope="request" />
<jsp:include page="getitems.jsp" />
<c:remove var="area" scope="request" />
<c:set var="level" value="0" scope="request" />
<jsp:include page="showitems.jsp" />
<%-- more mobile stuff --%>

<%-- some mobile stuff --%>
<c:set var="area" value="main" scope="request" />
<c:set var="currentAreaName" value="main" scope="request" />
<jsp:include page="getitems.jsp" />
<c:remove var="area" scope="request" />
<c:set var="level" value="0" scope="request" />
<dxf:div cssClass="tabletMainArea">
    <c:choose>
        <c:when test="${requestScope['com.escenic.context']=='art'}">
            <dxf:div cssClass="articleConfig">
                <jsp:include page="showitems.jsp" />
            </dxf:div>
        </c:when>
        <c:otherwise>
            <jsp:include page="showitems.jsp" />
        </c:otherwise>
    </c:choose>
</dxf:div>

<%-- more mobile stuff --%>

<%-- Using main area, but calling it right --%>
<c:set var="area" value="right" scope="request" />
<c:set var="currentAreaName" value="main" scope="request" />
<jsp:include page="getitems.jsp" />
<c:remove var="area" scope="request" />
<c:set var="level" value="0" scope="request" />
<dxf:div cssClass="tabletRightArea">
    <jsp:include page="showitems.jsp" />
</dxf:div>
<%-- more mobile stuff --%>

<dxf:div style="clear:both"/>


<%-- some mobile stuff --%>
<c:set var="area" value="bottom" scope="request" />
<c:set var="currentAreaName" value="bottom" scope="request" />
<jsp:include page="getitems.jsp" />
<c:remove var="area" scope="request" />
<c:set var="level" value="0" scope="request" />
<dxf:div cssClass="footer">
    <jsp:include page="showitems.jsp" />
</dxf:div>
<%-- more mobile stuff --%>