<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.math.BigInteger" %>
<%@ tag import="java.security.MessageDigest" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="mno-mobile" uri="http://www.medianorge.no/widget-framework/mno/mobile" %>
<%--
  The purpose of this tag is to curtail a given string, if its length exceeds a specified limit.
--%>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="defaultWireFrame" required="true" rtexprvalue="true" %>

<dxf:load_capabilities />
<c:set var="cookiedomain" value=".aftenposten.no" scope="request"/>
<c:choose>
    <c:when test="${fn:startsWith(pageContext.request.serverName, 'mobil') || fn:startsWith(pageContext.request.serverName, 'm.') ||  fn:startsWith(pageContext.request.serverName, 'touch.')}">
        <c:choose>
            <%--1--%>
            <c:when test="${cookie.cache_key eq null}">
                <c:choose>
                    <c:when test="${fn:startsWith(pageContext.request.serverName, 'mobil') || fn:startsWith(pageContext.request.serverName, 'm.') ||  fn:startsWith(pageContext.request.serverName, 'touch.')}">
                        <c:set var="wireframe" value="mobile" scope="page"/>
                        <mno-mobile:setCacheKeyCookie wireframe="mobile"/>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${not empty param['service']}">
                                <c:set var="wireframe" value="${param['service']}" />
                            </c:when>
                            <c:when test="${not empty param['widget']}">
                                <c:set var="wireframe" value="widget" />
                            </c:when>
                            <c:when test="${not empty defaultWireFrame}">
                                <c:set var="wireframe" value="${defaultWireFrame}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="wireframe" value="default" />
                            </c:otherwise>
                        </c:choose>
                        <mno-mobile:setCacheKeyCookie wireframe="default"/>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <%--2--%>
                    <c:when test="${cookie.cache_key.value eq 'web'}">
                        <c:choose>
                            <c:when test="${not empty param['service']}">
                                <c:set var="wireframe" value="${param['service']}" />
                            </c:when>
                            <c:when test="${not empty param['widget']}">
                                <c:set var="wireframe" value="widget" />
                            </c:when>
                            <c:when test="${not empty defaultWireFrame}">
                                <c:set var="wireframe" value="${defaultWireFrame}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="wireframe" value="default" />
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <%--3--%>
                    <c:otherwise>
                        <c:set var="wireframe" value="mobile" />
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
        <c:choose>
            <c:when test="${not empty param['service']}">
                <c:set var="wireframe" value="${param['service']}" />
            </c:when>
            <c:when test="${not empty param['widget']}">
                <c:set var="wireframe" value="widget" />
            </c:when>
            <c:when test="${not empty defaultWireFrame}">
                <c:set var="wireframe" value="${defaultWireFrame}" />
            </c:when>
            <c:otherwise>
                <c:set var="wireframe" value="default" />
            </c:otherwise>
        </c:choose>
    </c:otherwise>

</c:choose>

<c:if test="${(	pageContext.request.localName=='bttest2.medianorge.no' ||
				pageContext.request.localName=='satest2.medianorge.no' ||
				pageContext.request.localName=='fvntest2.medianorge.no' ||
				pageContext.request.localName=='apmobiltest2.aftenposten.no'
				)
    && capabilities.is_wireless_device}">
	<c:set var="wireframe" value="mobile" scope="page"/>
</c:if>


<c:set var="wireframe_scope" value="${wireframe}" scope="request"/>

<%
request.setAttribute(var, jspContext.getAttribute("wireframe"));
%>




