<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<c:set var="windowState" value="open"/>
<c:if test="${windowInitialState eq false}">
  <c:set var="windowState" value="closed"/>
</c:if>

<c:choose>
  <c:when test="${inGridContainer eq 'true'}">
    <c:set var="inGridContainer" value="false" scope="request"/>
    <c:remove var="inGridContainer"/>
    <dxw:gridItem>
      <dxw:window itemId="${windowGroupId}" title="${windowGroupName}" initialState="${windowState}">
        <jsp:include page="../group/showitems.jsp" />
      </dxw:window>
    </dxw:gridItem>
    <c:set var="inGridContainer" value="true" scope="request"/>
  </c:when>
  <c:otherwise>
    <dxw:window itemId="${windowGroupId}" title="${windowGroupName}" initialState="${windowState}">
      <jsp:include page="../group/showitems.jsp" />
    </dxw:window>
  </c:otherwise>
</c:choose>

