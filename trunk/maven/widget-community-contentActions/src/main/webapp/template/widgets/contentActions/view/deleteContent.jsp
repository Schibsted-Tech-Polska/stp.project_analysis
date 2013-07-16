<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-contentActions/src/main/webapp/template/widgets/contentActions/view/deleteContent.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the changePassword view of the contentActions widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="community" uri="http://www.escenic.com/taglib/escenic-community" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<%-- the general controller has already set a HashMap named 'contentActions' in the requestScope --%>
<jsp:useBean id="contentActions" type="java.util.Map" scope="request"/>

<div class="${contentActions.wrapperStyleClass}" <c:if test="${not empty contentActions.styleId}">id="${contentActions.styleId}"</c:if>>
  <div class="header">
    <h5>
      <fmt:message key="contentActions.widget.deleteContent.headline"/>
    </h5>
  </div>  

  <div class="content">
    <profile:present>
      <c:if test="${not empty param.articleId}">
        <c:choose>
          <c:when test="${param.contentActions != 'success'}">
             <article:use articleId="${param.articleId}">
               <h2>
                 <fmt:message key="contentActions.widget.deleteContent.confirm">
                   <fmt:param>
                     "<a href="${article.url}"><c:out value="${article.title}" escapeXml="true"/></a>"
                   </fmt:param>
                 </fmt:message>
               </h2>

               <h4>
                 <fmt:message key="contentActions.widget.deleteContent.warning"/>
               </h4>

               <section:use uniqueName="${user.userName}">
                 <community:user id="currentUser" sectionId="${section.id}"/>
               </section:use>

               <html:form action="${contentActions.action}" styleClass="${contentActions.view}">
                 <html:hidden property="articleId" value="${param.articleId}"/>
                 <html:hidden property="homeSectionId" value="${currentUser.section.id}"/>
                 <html:hidden property="successUrl" value="${contentActions.successUrl}"/>
                 <html:hidden property="errorUrl" value="${contentActions.errorUrl}"/>

                 <div class="bottom">
                   <html:submit tabindex="1" property="deleteStorySubmit" styleClass="button">
                     <fmt:message key="contentActions.widget.deleteContent.submitButton.label"/>
                   </html:submit>

                   <html:cancel onclick="window.location='${article.url}';return false;" styleClass="button">
                    <fmt:message key="contentActions.widget.deleteContent.cancelButton.label" />
                   </html:cancel>                   
                 </div>
               </html:form>
             </article:use>
          </c:when>
          <c:when test="${not empty param.contentActions and param.contentActions == 'success'}">
            <h1>
              <fmt:message key="contentActions.widget.deleteContent.success.message" />
            </h1>
          </c:when>
        </c:choose>
      </c:if>
    </profile:present>

    <profile:notPresent>
      <h1>
        <fmt:message key="contentActions.widget.notLoggedInUser"/>
      </h1>

      <h4>
        <wf-community:getLoginUrl var="loginUrl" sectionUniqueName="login"/>
        <fmt:message key="contentActions.widget.deleteContent.notLoggedInUser">
          <fmt:param>
            <a href="${loginUrl}"><fmt:message
                key="contentActions.widget.login.linkText"/></a>
          </fmt:param>
        </fmt:message>
      </h4>
    </profile:notPresent>
  </div>
</div>


<c:remove var="contentActions" scope="request"/>