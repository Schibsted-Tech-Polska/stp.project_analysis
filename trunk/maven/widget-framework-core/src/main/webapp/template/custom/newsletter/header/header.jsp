<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/custom/newsletter/header/header.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="skinName" type="java.lang.String" scope="request" />
<jsp:useBean id="skinUrl" type="java.lang.String" scope="request" />

<fmt:message var="publicationTitle" key="publication.skin.${skinName}.title" />
<table cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td><a href="${publication.url}"><img src="${skinUrl}gfx/logo.png" alt="${publicationTitle}" title="${publicationTitle}" border="0" /></a></td>
  </tr>
</table>