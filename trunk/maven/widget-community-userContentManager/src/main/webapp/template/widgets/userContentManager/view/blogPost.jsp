<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userContentManager/src/main/webapp/template/widgets/userContentManager/view/blogPost.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>

<%-- use the map that contains relevant field values--%>
<jsp:useBean id="userContentManager" type="java.util.HashMap" scope="request"/>

<profile:present>
  <script type="text/javascript" src="${requestScope['resourceUrl']}js/userContentManager.js"></script>
  <script type="text/javascript" src="${requestScope['resourceUrl']}js/jquery.tablesorter.js"></script>
  <script type="text/javascript">
    // <![CDATA[
    $(document).ready(function() {
      $.tablesorter.addParser({
        id: 'dateSorter',
        is: function(s) {
          return false;
        },
        format: function(s) {
          ret = s;
          if(s.indexOf('class')>0){
            str = s.substring(s.indexOf('class'));
            if(str.indexOf('=')>0){
              str = str.substring(str.indexOf('='));
              if((str.indexOf('"')>0) && (str.indexOf("'")>0)){
                if(str.indexOf('"')> str.indexOf("'")){
                  str = str.substring(str.indexOf("'")+1);
                  ret = str.substring(0,str.indexOf("'"));
                }
                else{
                  str = str.substring(str.indexOf('"')+1);
                  ret = str.substring(0,str.indexOf('"'));
                }
              }
              else  if(str.indexOf('"')>0){
                str = str.substring(str.indexOf('"')+1);
                ret = str.substring(0,str.indexOf('"'));
              }
              else  if(str.indexOf("'")>0){
                  str = str.substring(str.indexOf("'")+1);
                  ret = str.substring(0,str.indexOf("'"));
                }
            }
          }
          return ret;
        },
        type: "text"
      });


      $.tablesorter.addParser({
        id: 'titleSorter',
        is: function(s) {
          return false;
        },
        format: function(s) {
          ret = '';
          isOn = true;
          for(i=0;i<s.length;i++){
            c = s.charAt(i);
            if(c=='<'){
              isOn = false;
            }
            if(isOn){
              if(c>='!' &&  c <= '~')
              {
                ret = ret.concat(c);
              }
            }
            if(c=='>'){
              isOn = true;
            }
          }
          return ret.toLowerCase();
        },
        type: "text"
      });

      <c:choose>
        <c:when test="${userContentManager.showDeleteButton and userContentManager.showCreationDate}">
          $("table.itemlist").tablesorter({
            headers: {
              0: {
                sorter: false
              },
              1: {
                sorter: 'titleSorter'
              },
              2: {
                sorter:'dateSorter'
              },
              3: {
                sorter: false
              }
            }
          });
        </c:when>
        <c:when test="${userContentManager.showDeleteButton}">
          $("table.itemlist").tablesorter({
            headers: {
              0: {
                sorter: false
              },
              1: {
                sorter: 'titleSorter'
              },
              2: {
                sorter: false
              }
            }
          });
        </c:when>
        <c:when test="${userContentManager.showCreationDate}">
          $("table.itemlist").tablesorter({
            headers: {
              0: {
                sorter: 'titleSorter'
              },
              1: {
                sorter:'dateSorter'
              },
              2: {
                sorter: false
              }
            }
          });
        </c:when>
        <c:otherwise>
          $("table.itemlist").tablesorter({
            headers: {
              0: {
                sorter: 'titleSorter'
              },
              1: {
                sorter: false
              }
            }
          });
        </c:otherwise>
      </c:choose>
    });
    // ]]>
  </script>

  <c:set var="allClasses">${userContentManager['styleClass']}<c:if test="${not empty userContentManager['customStyleClass']}"> ${userContentManager['customStyleClass']}</c:if></c:set>

  <div class="${allClasses}" <c:if test="${not empty userContentManager['styleId']}">id="${userContentManager['styleId']}"</c:if>>
    <div class="header">
      <div class="left">
        <h2>
            <c:out value="${userContentManager.archiveHeading}" escapeXml="true"/>
          <span class="counter">(<c:out value="${userContentManager.newsCount}" escapeXml="true"/>)</span>
        </h2>
      </div>
      <div class="right">
        <c:set var="statusFilterDropdownId" value="statusFilterDropdown${widgetContent.id}"/>
        <label for="${statusFilterDropdownId}">
          <fmt:message key="userContentManager.widget.blogPost.filter.title" />
        </label>
        <select id="${statusFilterDropdownId}" name="view"
                onchange="changeBlogPostsFilter('${userContentManager.currentUrl}', '${statusFilterDropdownId}');">
          <option value="all" <c:if test="${userContentManager.statusParam=='all'}">selected="selected"</c:if>>All</option>
          <option value="published" <c:if test="${userContentManager.statusParam=='published'}">selected="selected"</c:if>>Published</option>
          <option value="draft" <c:if test="${userContentManager.statusParam=='draft'}">selected="selected"</c:if>>Draft</option>
        </select>
      </div>
    </div>

    <div class="contents">
      <c:set var="hiddenDeleteFieldId" value="userContentManagerDelete${widgetContent.id}"/>
      <c:set var="selectorCheckboxName" value="userContentManagerSelectCheckbox${widgetContent.id}"/>
      <fmt:message var="newsEditLinkTitle" key="userContentManager.widget.blogPost.edit.linkTitle" />

      <table class="itemlist" cellspacing="1" cellpadding="0" border="0">
        <thead>
          <tr class="heading">
            <c:if test="${userContentManager.showDeleteButton}">
              <th class="select">
                <input type="checkbox" class="checkbox" onchange="changeAllBlogPostsCheckStatus('${selectorCheckboxName}', '${hiddenDeleteFieldId}', this);" />
              </th>
            </c:if>

            <th class="title">
              <fmt:message key="userContentManager.widget.blogPost.titleHeaderText"/>
            </th>

            <c:if test="${userContentManager.showCreationDate}">
              <th class="date">
                <fmt:message key="userContentManager.widget.blogPost.creationTimeHeaderText"/>
              </th>
            </c:if>

            <c:if test="${userContentManager.showEditColumn}">
              <th class="edit">
                <fmt:message key="userContentManager.widget.blogPost.editHeaderText"/>
              </th>
            </c:if>
          </tr>
        </thead>

        <tbody>
          <c:forEach  var="news" items="${userContentManager['newsAll']}" varStatus="status">
            <tr>
              <c:if test="${userContentManager.showDeleteButton}">
                <td class="select">
                  <input type="checkbox" class="checkbox" name="${selectorCheckboxName}" value="${news.id}"
                         onchange="resetCheckedListValue('${selectorCheckboxName}', '${hiddenDeleteFieldId}');"/>
                </td>
              </c:if>

              <td class="title">
                <c:choose>
                  <c:when test="${news.state == 'published'}">
                      <span class="publishedNews">
                        <a href="${news.contentUrl}"><c:out value="${news.title}" escapeXml="true"/></a>
                      </span>
                  </c:when>
                  <c:otherwise>
                    <span class="draftNews"><c:out value="${news.title}" escapeXml="true"/></span>
                  </c:otherwise>
                </c:choose>
              </td>

              <c:if test="${userContentManager.showCreationDate}">
                <td class="date">
                    <span class="${news.dateString}">
                       <c:out value="${news.creationTimeText}" escapeXml="true"/>
                    </span>
                </td>
              </c:if>

              <c:if test="${userContentManager.showEditColumn}">
                <td class="edit" title="${newsEditLinkTitle}">
                  <wf-community:getEditBlogPostLink linkText="&nbsp;"
                                                 styleClass="edit" articleId="${news.id}" />
                </td>
              </c:if>

            </tr>
          </c:forEach>
        </tbody>
      </table>

      <div class="buttons">
        <c:if test="${userContentManager.showDeleteButton and (userContentManager.newsCount>0)}">
          <c:set var="formId" value="userContentManagerNewsForm${widgetContent.id}"/>

          <html:form action="${userContentManager['bulkDeleteArticleAction']}" method="post" styleId="${formId}">
            <html:hidden property="articleIds" value="" styleId="${hiddenDeleteFieldId}"/>
            <html:hidden property="successUrl" value="${userContentManager['bulkDeleteArticleSuccessUrl']}"/>
            <html:hidden property="errorUrl" value="${userContentManager['bulkDeleteArticleErrorUrl']}"/>
          </html:form>

          <a href="#" class="deleteContents" onclick="deleteArticles('${formId}');">
            <fmt:message key="userContentManager.widget.blogPost.deleteBlogPostText"/>
          </a>
          <c:set var="noArticleSelectionError">
            <fmt:message key="userContentManager.widget.blogPost.noBlogPostSelected"/>
          </c:set>
           <script type="text/javascript">
              // <![CDATA[
              function deleteArticles(formId){
                var fromObj = $('#'+formId)[0];
                 if(fromObj.articleIds.value.length>0){
                     fromObj.submit();
                 }
                else{
                    alert('${noArticleSelectionError}');
                 }
              }
              // ]]>
            </script>
        </c:if>

        <a href="${userContentManager.addNewsUrl}" class="addContent">
          <fmt:message key="userContentManager.widget.blogPost.addBlogpostText"/>
        </a>
      </div>

    </div>
  </div>
</profile:present>

<c:remove var="userContentManager" scope="request" />