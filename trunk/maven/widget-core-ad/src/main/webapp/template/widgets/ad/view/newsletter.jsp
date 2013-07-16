<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-ad/src/main/webapp/template/widgets/ad/view/newsletter.jsp#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--declare the map that will contain relevant field values--%>
<jsp:useBean id="ad" type="java.util.Map" scope="request"/>

<%-- render html --%>
<c:if test="${not empty widgetContent.relatedElements.images.items}">
  <c:set var="logoPicture" value="${widgetContent.relatedElements.images.items[0]}"/>
  <c:if test="${fn:trim(logoPicture.content.articleTypeName eq 'picture')}">
    <table class="${ad.wrapperStyleClass}" cellspacing="0" cellpadding="0" border="0">
      <tr>
        <td width="${ad.width_newsletter}" height="${ad.height_newsletter}">
          <a href="${ad.url_newsletter}" onclick="return openLink(this.href,'${ad.target}')">
            <img src="${logoPicture.content.fields.binary.value.href}" alt="${ad.linkTitle_newsletter}"
                 title="${ad.linkTitle_newsletter}" width=""/>
          </a>
        </td>
      </tr>
    </table>
  </c:if>
</c:if>

<c:remove var="ad" scope="request"/>
