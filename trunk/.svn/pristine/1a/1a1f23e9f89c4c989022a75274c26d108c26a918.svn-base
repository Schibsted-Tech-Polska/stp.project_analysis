<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-poll/src/main/webapp/template/widgets/poll/view/default_form.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%-- the purpose of this page is to render the default view of the poll widget --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>

<%-- the controller has already set a HashMap named 'poll' in the requestScope --%>
<jsp:useBean id="poll" type="java.util.HashMap" scope="request"/>

<c:set var="pollItems" value="${poll.items}"/>

<c:if test="${not empty pollItems}">
  <div class="${poll.wrapperStyleClass}" <c:if test="${not empty poll.styleId}">id="${poll.styleId}"</c:if>>
    <c:if test="${poll.showWidgetName=='true'}">
      <div class="header">
        <h5>
          <c:out value="${poll.widgetName}" escapeXml="true"/>
        </h5>
      </div>
    </c:if>

    <c:forEach var="pollItem" items="${pollItems}">
      <div id="${pollItem.styleId}" class="content">
        <h2 class="${pollItem.inpageHeadlineClass}"><c:out value="${pollItem.headline}" escapeXml="true"/> </h2>

        <p class="${pollItem.inpageQuestionClass}"><c:out value="${pollItem.question}" escapeXml="true"/></p>

        <c:set var="mentometer" value="${pollItem.mentometer}"/>
        
        <html:xhtml/>
        <html:form action="/poll/vote">
          <fieldset>
            <html:hidden property="mentometerId" value="${mentometer.articleID}"/>
            <html:hidden property="publicationId" value="${publication.id}"/>
            <html:hidden property="redirectTo" value="${pollItem.url}"/>
            <c:forEach items="${mentometer.mentometerOption}" var="option" varStatus="status">
              <p>
                <c:set var="radioId" value="poll_${mentometer.articleID}_${status.count}"/>
                <html:radio property="vote" value="${option.articleElement}" styleId="${radioId}"/>
                <label for="${radioId}"><c:out value="${option.title}" escapeXml="true"/></label>
              </p>
            </c:forEach>
            <p class="poll-form-bottom">
              <html:submit styleClass="button">
                <fmt:message key="poll.widget.form.submit.button" />
              </html:submit>
              
              <a href="${pollItem.resultUrl}"><fmt:message key="poll.widget.form.results.linkText" /></a>
            </p>
          </fieldset>
        </html:form>

      </div>
    </c:forEach>
  </div>
</c:if>

<c:remove var="poll" scope="request" />