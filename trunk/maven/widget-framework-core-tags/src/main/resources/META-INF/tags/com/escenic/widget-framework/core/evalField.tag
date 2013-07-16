<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-widget/evalField.tag#1 $
 * Last edited by : $Author: hassan $ $Date: 2009/11/12 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>

<%--
This tag takes the content-type field data as input and searches for bean properties e.g. section.name, article.title etc.
Please remember that these properties must be enclosed in square brackets i.e. [section.name], [article.title].
--%>
<%@ tag language="java" %>
<%@ tag import="org.apache.commons.beanutils.PropertyUtils" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.lang.reflect.InvocationTargetException" %>

<%@ taglib uri="http://www.escenic.com/widget-framework/core" prefix="wf-core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<%@ attribute name="id"
              description="the object where result be will placed"
              required="true"
              rtexprvalue="true" %>
<%@ attribute name="inputFieldValue"
              description="The input field data of content-type as String"
              type="java.lang.String"
              required="true"
              rtexprvalue="true" %>
<%!
  public String getBeanValue(Object bean, String pPropertyname) {
    Object ePropertyValue = null;
    if (bean != null && !StringUtils.isEmpty(pPropertyname)) {
      try {
        if (StringUtils.contains(pPropertyname, '.')) {
          ePropertyValue = PropertyUtils.getNestedProperty(bean, pPropertyname);
        } else {
          ePropertyValue = PropertyUtils.getSimpleProperty(bean, pPropertyname);
        }
      } catch (IllegalAccessException ex) {
        System.err.println(ex);
      } catch (InvocationTargetException ex) {
        System.err.println(ex);
      } catch (NoSuchMethodException ex) {
        System.err.println(ex);
      }
    }
    return ePropertyValue != null ? ePropertyValue.toString() : "";
  }
%>

<%!
  public String removeArticleInfo(String text) {
    return text.replaceAll("(?i)\\[article[\\. ]*[a-zA-Z\\.]{1,10000}\\]", "");
  }
%>

<jsp:useBean id="beanprops" class="java.util.HashMap" scope="request"/>
<c:set var="outPutFieldValue" scope="request" value="${inputFieldValue}"/>
<jsp:useBean id="publication" type="neo.xredsys.api.Publication" scope="request"/>

<c:set var="beanTokens" value="${fn:split(inputFieldValue, ' ')}" scope="request"/>

<c:forEach var="beantoken" items="${beanTokens}">
  <c:set var="beantoken" value="${fn:trim(beantoken)}"/>
  <c:if test="${fn:contains(beantoken, '[')}">
    <c:set var="beanWithProperty"
           value="${fn:trim(fn:substring(beantoken, fn:indexOf(beantoken, '[') + 1, fn:indexOf(beantoken, ']')))}"
           scope="request"/>
    <c:set var="propertyName" value="${fn:substringAfter(beanWithProperty, '.')}" scope="request"/>
    <%--Now we have the what bean property to retrieve--%>
    <c:choose>
      <c:when test="${requestScope['com.escenic.context']=='sec'}">
        <%--If we are in section context then we have to ignore everyting related to article e.g. article.title etc --%>
        <c:set var="outPutFieldValue" 
               value='<%=removeArticleInfo((String)request.getAttribute("outPutFieldValue"))%>'
               scope="request" />
        <c:choose>
          <c:when test="${fn:startsWith(beanWithProperty, 'section')}">
            <jsp:useBean id="section" scope="request" type="neo.xredsys.api.Section"/>
            <c:set target="${beanprops}" property="${beanWithProperty}"
                   value='<%=getBeanValue(section, (String) request.getAttribute("propertyName"))%>'/>
          </c:when>
          <c:when test="${fn:startsWith(beanWithProperty, 'publication')}">
            <c:set target="${beanprops}" property="${beanWithProperty}"
                   value='<%=getBeanValue(publication, (String) request.getAttribute("propertyName"))%>'/>
          </c:when>
        </c:choose>
      </c:when>
      <c:otherwise>
        <jsp:useBean id="article" scope="request" type="neo.xredsys.presentation.PresentationArticle"/>
        <c:choose>
          <c:when test="${fn:startsWith(beanWithProperty, 'section')}">
            <%--If we are in article context then we have to set the section as article section--%>
            <c:set target="${beanprops}" property="${beanWithProperty}"
                   value='<%=getBeanValue(article.getHomeSection(), (String) request.getAttribute("propertyName"))%>'/>
          </c:when>
          <c:when test="${fn:startsWith(beanWithProperty, 'publication')}">
            <c:set target="${beanprops}" property="${beanWithProperty}"
                   value='<%=getBeanValue(publication, (String) request.getAttribute("propertyName"))%>'/>
          </c:when>
          <c:otherwise>
            <c:set target="${beanprops}" property="${beanWithProperty}"
                   value='<%=getBeanValue(article, (String) request.getAttribute("propertyName"))%>'/>
          </c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>

    <c:remove var="beanWithProperty" scope="request"/>
    <c:remove var="propertyName" scope="request"/>

  </c:if>
</c:forEach>
<c:set var="outPutFieldValue" scope="request"
       value="${fn:replace(outPutFieldValue, '[', '')}"/>
<c:set var="outPutFieldValue" scope="request"
       value="${fn:replace(outPutFieldValue, ']', '')}"/>
<c:forEach var="currentProperty" items="${beanprops}">
  <c:set var="outPutFieldValue" scope="request"
         value="${fn:replace(outPutFieldValue, currentProperty.key, currentProperty.value)}"/>
</c:forEach>

<%
  request.setAttribute(id, request.getAttribute("outPutFieldValue"));
%>

<c:remove var="outPutFieldValue" scope="request" />
<c:remove var="beanprops" scope="request"/>
<c:remove var="beanTokens" scope="request"/>

















