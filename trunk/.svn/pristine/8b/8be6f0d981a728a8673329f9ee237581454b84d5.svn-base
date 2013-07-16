<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/renderFormFields.tag#1 $
 * Last edited by : $Author: shah $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%--The purpose of this tag is to render the fields defined in the content-type definition. Panel
 names can be specified and only the fields within the specified panels will be shown--%>
<%@ tag language="java" body-content="empty" isELIgnored="false" %>

<%@ attribute name="articleType" type="neo.xredsys.content.type.ArticleType" required="true" rtexprvalue="true" %>
<%@ attribute name="panelNames" type="java.lang.String" required="false" rtexprvalue="true" %>
<%@ attribute name="excludeFields" type="java.lang.String" required="false" rtexprvalue="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<c:forEach var="panel" items="${articleType.panels}">
  <c:choose>
    <c:when test="${empty panelNames}">
      <c:set var="showCurrentPanel" value="true"/>
    </c:when>
    <c:otherwise>
      <c:forTokens var="panelName" items="${panelNames}" delims=",">
        <c:if test="${fn:trim(fn:toUpperCase(panelName)) eq panel.name}">
          <c:set var="showCurrentPanel" value="true"/>
        </c:if>
      </c:forTokens>
    </c:otherwise>
  </c:choose>

  <fieldset class="${panel.name}">
    <c:forEach var="field" items="${panel.fields}">
      <jsp:useBean id="field" type="neo.xredsys.content.type.Field" scope="page"/>

      <logic:empty name="org.apache.struts.taglib.html.BEAN" property='field(${field.name})'>
        <logic:notEmpty name="field" property="defaultValue">
          <bean:define id="value" name="field" property="defaultValue" type="String"/>
        </logic:notEmpty>
      </logic:empty>
      <logic:notEmpty name="org.apache.struts.taglib.html.BEAN" property='field(${field.name})'>
        <bean:define id="value" name="org.apache.struts.taglib.html.BEAN" property='field(${field.name})'
                     type="String"/>
      </logic:notEmpty>

      <c:set var="showCurrentField" value="true"/>

      <c:if test="${not empty excludeFields}">
        <c:forTokens var="fieldName" items="${excludeFields}" delims=",">
          <c:if test="${fn:trim(fn:toUpperCase(fieldName)) eq field.name}">
            <c:set var="showCurrentField" value="false"/>
          </c:if>
        </c:forTokens>
      </c:if>

      <c:choose>
        <c:when test="${field.type.type == 6 or !showCurrentPanel or !showCurrentField}">
          <html:hidden property='field(${field.name})' value="${value}"/>
        </c:when>
        <c:otherwise>
          <dl>
            <dt>
              <label for='field(${field.name})'>
                <c:out value="${field.label}"/>
              </label>
            </dt>

            <dd>
              <c:choose>
                <c:when test="${field.type.type == 1}">
                  <c:choose>
                    <c:when test="${field.mimetype eq 'application/xhtml+xml'}">
                      <html:textarea styleClass="textarea" styleId='field(${field.name})'
                                     rows='${field.rows}'
                                     property='field(${field.name})'>
                        <c:out value="${value}" escapeXml="true"/>
                      </html:textarea>
                      <script type="text/javascript">
                        tinyMCE.init({
                          theme : "simple",
                          width: "96%",
                          height: "180",
                          mode : "textareas",
                          elements : 'field(${field.name})'
                        });
                      </script>
                    </c:when>
                    <c:otherwise>
                      <c:choose>
                        <c:when test="${field.rows == 0}">
                          <c:choose>
                            <c:when test="${empty value}">
                              <html:text styleClass="text-field" styleId='field(${field.name})'
                                         property='field(${field.name})'/>
                            </c:when>
                            <c:otherwise>
                              <html:text value="${value}" styleClass="text-field" styleId='${field.name}'
                                         property='field(${field.name})'/>
                            </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                          <html:textarea styleClass="textarea" styleId='field(${field.name})'
                                         property='field(${field.name})'
                                         rows='${field.rows}'/>
                        </c:otherwise>
                      </c:choose>
                    </c:otherwise>
                  </c:choose>
                </c:when>
                <c:when test="${field.type.type == 2}">
                  <html:text styleClass="text-field" styleId='field(${field.name})'
                             property='field(${field.name})'/>
                </c:when>
                <c:when test="${field.type.type == 4}">
                  <c:choose>
                    <c:when test="${value == true}">
                      <c:set var="status" value="checked"/>
                    </c:when>
                    <c:otherwise>
                      <c:set var="status" value=""/>
                    </c:otherwise>
                  </c:choose>
                  <input type="checkbox" name="field(${field.name})" ${status}/>&#160;&#160;
                  <c:if test="${not empty field.description}">
                    <c:out value="${field.description}"escapeXml="true"/>
                  </c:if>
                </c:when>
                <c:when test="${field.type.type == 5}">
                  <bean:define id="type" name="field" property="type" type="neo.xredsys.content.type.Enumeration"/>
                  <c:if test="${type.multiple}">
                    <c:set var="multipleStatus" value="multiple"/>
                  </c:if>

                  <select name="field(${field.name})" ${multipleStatus}>
                    <c:forEach var="option" items="${type.options}">
                      <c:set var="optionValue" value="<ecs_selection>${option.value}</ecs_selection>"/>
                      <c:if test="${fn:containsIgnoreCase(value, optionValue)}">
                        <c:set var="selectionStatus" value="selected"/>
                      </c:if>

                      <option value="${option.value}" ${selectionStatus}>
                        <c:out value="${option.label}" escapeXml="true"/>
                      </option>

                      <c:remove var="selectionStatus"/>
                    </c:forEach>
                  </select>
                  <c:remove var="multipleStatus"/>
                </c:when>
              </c:choose>
              <%
                String[] values = field.getParameters("com.ndc.usercontent.constraint");
                String fieldName = StringUtils.lowerCase(field.getName());

                if (values != null) {
                  for (String parameterValue : values) {
                    if (!StringUtils.isEmpty(parameterValue) && parameterValue.equalsIgnoreCase("notEmpty()")) {
                      String styleClassName = "compulsory asterisk-" + fieldName;
                      out.print("<span class='" + styleClassName + "'>*</span>");
                      break;
                    }
                  }
                }
              %>

              <logic:messagesPresent message="true" property="${field.name}">
                <html:messages bundle="Validation" id="errorMessage" message="true" property="${field.name}">
                  <p id="errorfield(${field.name})" class="error"><c:out value="${errorMessage}" escapeXml="true"/></p>
                </html:messages>
              </logic:messagesPresent>
            </dd>
          </dl>
        </c:otherwise>
      </c:choose>
      <c:remove var="showCurrentField"/>
      <c:remove var="value"/>
    </c:forEach>
  </fieldset>
  <c:remove var="showCurrentPanel"/>
</c:forEach>