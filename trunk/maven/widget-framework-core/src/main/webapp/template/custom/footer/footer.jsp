<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/custom/footer/footer.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="skinName" type="java.lang.String" scope="request"/>
<jsp:useBean id="skinUrl" type="java.lang.String" scope="request"/>

<fmt:message var="publicationTitle" key="publication.skin.${skinName}.title" />

<div class="footer">
  <p>
    <strong>© Copyright 2009 <c:out value="${publicationTitle}" escapeXml="true"/></strong><br/>
    This demonstration website is provided by Escenic AS. The Escenic product family is an advanced platform for web publishing and content management. The Escenic product portfolio includes solutions for professional publishers in sales, marketing and in the media industry. For more information on our products and services, visit <a href="http://www.escenic.com" onclick="return openLink(this.href,'_blank')">www.escenic.com</a>.
  </p>
</div>
