<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-menu/src/main/webapp/template/widgets/menu/view/newsletter.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render horizontal menu, both active only and all subitems menu --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="http://www.escenic.com/taglib/escenic-util" %>

<%-- the controller has already set a HashMap named 'menu' in the requestScope --%>
<jsp:useBean id="menu" type="java.util.HashMap" scope="request"/>

<c:if test="${not empty menu.levels}">
  <c:forEach var="menuLevel" items="${menu.levels}">
    <table cellspacing="0" cellpadding="0" border="0">
      <tr>
        <c:forEach var="menuLevelItem" items="${menuLevel.items}">
          <td style="background:#000000;color:#FFFFFF;border-right:2px solid #FFFFFF;">
            <a href="${menuLevelItem.url}"
               style="font-family: verdana; font-size:14px; font-weight: bold; color: #336699; text-decoration: none;">
              <span style="font-family: verdana; font-size:14px; font-weight: bold; color: #336699; text-decoration: none;margin-right: 15px;">
                  <c:out value="${menuLevelItem.text}" escapeXml="true"/>
              </span>
            </a>
          </td>
        </c:forEach>
      </tr>
    </table>
  </c:forEach>
</c:if>
<c:remove var="menu" scope="request"/>