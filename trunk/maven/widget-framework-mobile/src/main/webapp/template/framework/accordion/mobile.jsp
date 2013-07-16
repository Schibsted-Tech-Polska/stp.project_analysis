<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib uri="http://mobiletech.no/jsp/dextella-frame" prefix="dxf"%>
<%@taglib uri="http://mobiletech.no/jsp/dextella-frame-widgets" prefix="dxw"%>

<c:set var="accordionContentCount" value="1" scope="request"/>
<dxw:accordion itemId="${accordionId}" fallbackType="show">
  <jsp:include page="../group/showitems.jsp" />
</dxw:accordion>
<c:remove var="accordionContentCount"/>