<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-search/src/main/webapp/template/widgets/search/view/advancedForm.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--
  The purpose of this page is to display the advanced search form
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>
<%@ taglib prefix="view" uri="http://www.escenic.com/taglib/escenic-view" %>

<jsp:useBean id="search" type="java.util.HashMap" scope="request"/>
<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request"/>

<c:choose>
  <c:when test="${empty param.searchString }">
    <c:set var="advancedSearchStyleClass" value="display:block;"/>
  </c:when>
  <c:otherwise>
    <c:set var="advancedSearchStyleClass" value="display:none;"/>
  </c:otherwise>
</c:choose>

<%--
<c:set var="allClasses">${search.styleClass}<c:if
    test="${not empty search.customStyleClass}"> ${search.customStyleClass}</c:if></c:set>
--%>

<div class="${search.wrapperStyleClass}"
     <c:if test="${not empty search.styleId}">id="${search.styleId}"</c:if> >

  <div id="advanced-search" style="${advancedSearchStyleClass}">
    <div class="header-block">
      <h2><fmt:message key="search.widget.form.advanced.title"/></h2>
    </div>

    <div class="content-block">
      <script type="text/javascript" src="${resourceUrl}js/searchFormHandler.js"></script>

      <c:set var="searchFromDate" value="${search.from}"/>
      <c:set var="searchToDate" value="${search.to}"/>
      <c:set var="searchString" value="${search.searchString}"/>
      <c:set var="searchExprErrorParaId" value="emptySearchExpressionError"/>

      <html:xhtml/>
      <html:form styleId="advancedSearchForm" action="/search/advanced" method="get">
        <fieldset>
          <input type="hidden" name="com.escenic.context.path.initial" value=""/>
          <html:hidden property="successUrl" value="${search.successUrl}"/>
          <html:hidden property="errorUrl" value="${search.errorUrl}"/>
          <html:hidden property="publicationId" value="${search.publicationId}"/>
          <html:hidden property="sortString" value="${search.sortString}"/>

          <c:forTokens var="articleType" items="${search.articleTypes}" delims=",">
            <html:hidden property="articleType" value="${fn:trim(articleType)}"/>
          </c:forTokens>

          <html:hidden property="pageLength" value="${search.pageLength}"/>
          <html:hidden property="searchEngineName" value="${search.searchEngineName}"/>

          <c:set var="searchExpressionErrorMessage">
            <html:errors property="searchExpression"/>
          </c:set>

          <c:if test="${not empty fn:trim(searchExpressionErrorMessage)}">
            <p class="error"><c:out value="${fn:trim(searchExpressionErrorMessage)}" escapeXml="true"/></p>
          </c:if>

          <p class="error" id="${searchExprErrorParaId}" style="display:none;">
            <fmt:message key="search.widget.error.query.empty"/>
          </p>

          <table border="0">
            <tr>
              <td class="label">
                <label for="search-all">
                  <fmt:message key="search.widget.advaced.options.withAllWords.label"/>
                </label>
              </td>

              <td>
                <c:choose>
                  <c:when test="${not empty searchString}">
                    <html:text styleId="search-all" styleClass="field" property="all" value="${searchString}"/>
                  </c:when>
                  <c:otherwise>
                    <html:text styleId="search-all" styleClass="field" property="all"/>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>

            <tr>
              <td class="label">
                <label for="search-exactPhrase">
                  <fmt:message key="search.widget.advaced.options.withExactPhrase.label"/>
                </label>
              </td>

              <td>
                <html:text styleId="search-exactPhrase" styleClass="field" property="exactPhrase"/>
              </td>
            </tr>

            <tr>
              <td class="label">
                <label for="search-atLeastOne">
                  <fmt:message key="search.widget.advaced.options.withAtLeastOneWord.label"/>
                </label>
              </td>

              <td>
                <html:text styleId="search-atLeastOne" styleClass="field" property="atLeastOne"/>
              </td>
            </tr>

            <tr>
              <td class="label">
                <label for="search-without">
                  <fmt:message key="search.widget.advaced.options.withoutWords.label"/>
                </label>
              </td>

              <td>
                <html:text styleId="search-without" styleClass="field" property="without"/>
              </td>
            </tr>

            <tr id="search-range">
              <td class="label">
                <label for="searchFromDate">
                  <fmt:message key="search.widget.advaced.options.dateInterval.label"/>
                </label>
              </td>

              <td>
                <html:hidden property="startDay" styleId="searchStartDay"/>
                <html:hidden property="startMonth" styleId="searchStartMonth"/>
                <html:hidden property="startYear" styleId="searchStartYear"/>
                <html:hidden property="toDay" styleId="searchToDay"/>
                <html:hidden property="toMonth" styleId="searchToMonth"/>
                <html:hidden property="toYear" styleId="searchToYear"/>

                <input type="text" class="datepicker" name="from" id="searchFromDate" value="${searchFromDate}"/>
                <label for="searchToDate"> - </label>
                <input type="text" class="datepicker" name="to" id="searchToDate" value="${searchToDate}"/>


                <script type="text/javascript">
                  // <![CDATA[
                  $(document).ready(function() {
                    var currentDate = new Date();
                    var currentDay = currentDate.getDate();
                    var currentMonth = currentDate.getMonth();
                    var currentYear = currentDate.getFullYear();

                    $('.datepicker').datepicker({
                      dateFormat: "yy-mm-dd",
                      changeMonth: true,
                      changeYear: true,
                      minDate: new Date(2000, 1, 01),
                      maxDate: new Date(currentYear, currentMonth, currentDay) });
                  });
                  // ]]>
                </script>

                <c:set var="dateErrorMessages">
                  <html:errors property="startDay"/>
                  <html:errors property="startMonth"/>
                  <html:errors property="startYear"/>
                  <html:errors property="fromDate"/>
                  <html:errors property="toDay"/>
                  <html:errors property="toMonth"/>
                  <html:errors property="toYear"/>
                  <html:errors property="toDate"/>
                </c:set>

                <c:if test="${not empty fn:trim(dateErrorMessages)}">
                  <p class="error"><c:out value="${fn:trim(dateErrorMessages)}" escapeXml="true"/></p>
                </c:if>
              </td>
            </tr>

            <tr class="sections">
              <td class="label">
                <label for="search-section">
                  <fmt:message key="search.widget.advaced.options.section.label"/>
                </label>
              </td>

              <td>
                <html:select styleId="search-section" property="includeSectionId" value="${search.includeSectionId}">
                  <view:iterate id="sec" view="${search.topLevelSearchSections}">
                    <c:if test="${sec.uniqueName != 'ece_incoming' && not fn:startsWith(sec.uniqueName,'config')}">
                      <html:option value="${sec.id}"><c:out value="${sec.name}" escapeXml="true"/></html:option>
                    </c:if>
                  </view:iterate>
                </html:select>

                <c:set var="sectionIdErrorMessage">
                  <html:errors property="includeSectionId"/>
                </c:set>

                <c:if test="${not empty fn:trim(sectionIdErrorMessage)}">
                  <p class="error"><c:out value="${fn:trim(sectionIdErrorMessage)}" escapeXml="true"/></p>
                </c:if>

                &nbsp;

                <c:choose>
                  <c:when test="${search.includeSubSections == 'true'}">
                    <input type="checkbox" name="customIncludeSubSections" checked="true" value="true"
                           id="customIncludeSubSections"/>
                  </c:when>
                  <c:otherwise>
                    <input type="checkbox" name="customIncludeSubSections" value="false" id="customIncludeSubSections"/>
                  </c:otherwise>
                </c:choose>

                <fmt:message key="search.widget.advaced.options.includeSubSections.label"/>
                <input type="hidden" name="includeSubSections" id="includeSubSections" value="${search.includeSubSections}"/>
              </td>
            </tr>

            <tr>
              <td class="label">&nbsp;</td>
              <td>
                <c:set var="searchButtonLabel">
                  <fmt:message key="search.widget.form.submit.button.label"/>
                </c:set>

                <c:set var="searchButtonTitle">
                  <fmt:message key="search.widget.form.submit.button.title"/>
                </c:set>
                <input type="button" class="button" value="${searchButtonLabel}" title="${searchButtonTitle}"
                       onclick="parseDateAndFormSubmit(this.form, '${searchExprErrorParaId}');"/>
              </td>
            </tr>

          </table>
        </fieldset>
      </html:form>
    </div>
  </div>
</div>

