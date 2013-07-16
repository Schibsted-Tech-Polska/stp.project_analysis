<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-community-userContentManager/src/main/webapp/template/widgets/userContentManager/view/pictures.jsp#2 $
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="profile" uri="http://www.escenic.com/taglib/escenic-profile" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="wf-community" uri="http://www.escenic.com/widget-framework/community" %>

<%-- use the map that contains relevant field values--%>
<jsp:useBean id="userContentManager" type="java.util.HashMap" scope="request"/>

<profile:present>
  <script type="text/javascript" src="${requestScope['resourceUrl']}js/userContentManager.js"></script>

  <c:set var="allClasses">${userContentManager['styleClass']}<c:if
          test="${not empty userContentManager['customStyleClass']}"> ${userContentManager['customStyleClass']}</c:if></c:set>
  <div class="${allClasses}"
       <c:if test="${not empty userContentManager['styleId']}">id="${userContentManager['styleId']}"</c:if>>
    <div class="header">
      <div class="left">
        <h2>
          <fmt:message key="userContentManager.widget.pictures.allPictures.headline"/>
          <span class="counter">(${userContentManager['pictureCount']})</span>
        </h2>
      </div>
      <div class="right">
      </div>
    </div>
    <div class="contents">
      <c:set var="formId" value="userContentManagerPicturesForm${widgetContent.id}"/>
      <c:set var="hiddenDeleteFieldId" value="userContentManagerPictureDelete${widgetContent.id}"/>
      <c:set var="selectorCheckboxName" value="userContentManagerSelectCheckbox${widgetContent.id}"/>

      <div class="picturesList">
        <c:forEach items="${userContentManager['pictures']}" var="picture">

          <div class="pictureContainer left">
            <c:if test="${userContentManager['allowDeletionPictures']=='true'}">
              <div class="select">
                <input type="checkbox" class="checkbox" name="${selectorCheckboxName}" value="${picture['id']}"
                       onchange="resetCheckedListValue('${selectorCheckboxName}', '${hiddenDeleteFieldId}');"/>
              </div>
            </c:if>

              <div class="picture">
                <a href="${picture['contentUrl']}">
                  <img src="${picture['src']}"
                       alt="${picture['altText']}" title="${picture['caption']}"
                       width="${picture['width']}" height="${picture['height']}"/>
                </a>
              </div>

            <div class="info">
              <c:if test="${userContentManager['showCaptionPictures']=='true'}">
                <h4>
                  <a href="${picture['contentUrl']}"><c:out value="${picture['caption']}" escapeXml="true"/></a>
                </h4>
              </c:if>
              <c:if test="${userContentManager['showCreationTimePictures']=='true'}">
                <p class="date"><c:out value="${picture['creationTimeText']}" escapeXml="true"/></p>
              </c:if>

              <div class="links">
                <c:if test="${userContentManager['showEditLinkPictures']=='true'}">
                  <wf-community:getEditPictureLink articleId="${picture['id']}"
                                                linkText="${userContentManager['editLinkTextPictures']}"/>
                </c:if>
                <c:if test="${userContentManager['showPostLinkPictures']=='true'}">
                  <a href="${userContentManager['addPictureUrl']}?pictureId=${picture['id']}&width=${userContentManager['inlinePictureWidth']}"><c:out value="${userContentManager['postLinkTextPictures']}" escapeXml="true"/></a>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <html:form action="${userContentManager['bulkDeleteArticleAction']}" method="post" styleId="${formId}">
        <html:hidden property="articleIds" value="" styleId="${hiddenDeleteFieldId}"/>
        <html:hidden property="successUrl" value="${userContentManager['bulkDeleteArticleSuccessUrl']}"/>
        <html:hidden property="errorUrl" value="${userContentManager['bulkDeleteArticleErrorUrl']}"/>

        <div class="buttons">
          <c:if test="${userContentManager['allowDeletionPictures'] == 'true' and userContentManager['pictureCount']+0 > 0}">
            <a href="#" class="deleteContents"
               onclick="deleteArticles('${formId}');">${userContentManager['deletePicturesLinkTextPictures']}</a>
            <c:set var="noArticleSelectionError">
              <fmt:message key="userContentManager.widget.pictures.noPictureSelected"/>
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

            <a href="${userContentManager['addPictureUrl']}"
               class="addContent">${userContentManager['addPictureLinkTextPictures']}</a>

        </div>
      </html:form>
    </div>
  </div>
</profile:present>