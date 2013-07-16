<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-actionLinks/src/main/webapp/template/widgets/actionLinks/view/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the actionLinks widget --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- the controller has already set a HashMap named 'actionLinks' in the requestScope --%>
<jsp:useBean id="actionLinks" type="java.util.Map" scope="request"/>

<profile:present>
  <c:if test="${(not empty actionLinks.currentUser) and (fn:length(actionLinks.selectedFields)>0)}">
    <div class="${actionLinks.wrapperStyleClass}" <c:if test="${not empty actionLinks.styleId}">id="${actionLinks.styleId}"</c:if>>
      <c:if test="${actionLinks.showTitle}">
        <h2><c:out value="${actionLinks.headline}" escapeXml="true"/></h2>
      </c:if>
      <div class="links">
        <ul>
          <c:forEach var="currentField" items="${actionLinks.selectedFields}">
            <c:if test="${currentField eq 'profileLink'}">
              <li class="profile">
                <a href="${actionLinks.profileUrl}"><c:out value="${actionLinks.profileLinkText}" escapeXml="true"/></a>
              </li>
            </c:if>
            <c:if test="${currentField eq 'addStoryLink'}">
              <li class="addStory">
                <a href="${actionLinks.addStoryUrl}"><c:out value="${actionLinks.addStoryLinkText}" escapeXml="true"/></a>
              </li>
            </c:if>
            <c:if test="${actionLinks.allowEditStory}">
              <c:if test="${currentField eq 'editStoryLink'}">
                <li class="editStory">
                  <wf-community:getEditBlogPostLink linkText="${actionLinks.editStoryLinkText}" />
                </li>
              </c:if>
              <c:if test="${currentField eq 'deleteStoryLink'}">
                <li class="deleteStory">
                  <a href="${actionLinks.deleteStoryUrl}"><c:out value="${actionLinks.deleteStoryLinkText}"  escapeXml="true"/></a>
                </li>
              </c:if>
            </c:if>
            <c:if test="${currentField eq 'addPictureLink'}">
              <li class="addPicture">
                <a href="${actionLinks.addPictureUrl}"><c:out value="${actionLinks.addPictureLinkText}" escapeXml="true"/></a>
              </li>
            </c:if>
            <c:if test="${actionLinks.allowEditPicture}">
              <c:if test="${currentField eq 'editPictureLink'}">
                <li class="editPicture">
                  <wf-community:getEditPictureLink linkText="${actionLinks.editPictureLinkText}" />
                </li>
              </c:if>
              <c:if test="${currentField eq 'deletePictureLink'}">
                <li class="deletePicture">
                  <a href="${actionLinks.deletePictureUrl}"><c:out value="${actionLinks.deletePictureLinkText}" escapeXml="true"/></a>
                </li>
              </c:if>
            </c:if>
            <c:if test="${currentField eq 'logoutLink'}">
              <li class="logout">
                <a href="${actionLinks.logoutUrl}"><c:out value="${actionLinks.logoutLinkText}" escapeXml="true"/></a>
              </li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
    </div>
  </c:if>
</profile:present>


<c:remove var="actionLinks" scope="request" />