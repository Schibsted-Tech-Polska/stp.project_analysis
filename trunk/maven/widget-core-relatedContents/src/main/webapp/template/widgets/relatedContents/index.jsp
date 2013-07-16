<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-relatedContents/src/main/webapp/template/widgets/relatedContents/index.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- this JSP page is the entry point of the relatedContents widget. --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%-- making sure that relatedContents widget is only displayed in article page, not in section page --%>
<c:choose>
  <c:when test="${requestScope['com.escenic.context']=='art'}">
    <%-- call wf-core:view tag to render the appropraite view of the widget --%>
    <wf-core:view widgetName="relatedContents" />
  </c:when>
  <c:otherwise>
    <jsp:include page="view/helpers/error.jsp" />
  </c:otherwise>
</c:choose>