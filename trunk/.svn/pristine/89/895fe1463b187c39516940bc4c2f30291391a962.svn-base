<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/webapp/template/framework/carousel/default.jsp#2 $
 * Last edited by : $Author: shah $ $Date: 2010/10/20 $
 * Version        : $Revision: #2 $
 *
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="collection" uri="http://www.escenic.com/taglib/escenic-collection" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<%--
  this JSP page expects the following objects in the request scope if any of them is missing, then this page will not work --%>
<jsp:useBean id="configCarouselGroup" type="neo.xredsys.presentation.PresentationElement" scope="request" />
<jsp:useBean id="resourceUrl" type="java.lang.String" scope="request" />

<c:set var="carouselGroupAreaName" value="carouselGroup-area" />
<c:set var="carouselGroupArea" value="${configCarouselGroup.areas[carouselGroupAreaName]}" />
<c:set var="carouselGroupItems" value="${carouselGroupArea.items}" />

<c:set var="autoplay" value="${configCarouselGroup.options.autoplay}"/>
<c:set var="autoplayInterval" value="${fn:trim(configCarouselGroup.options.autoplayInterval)}"/>
<c:choose>
  <c:when test="${empty autoplayInterval}">
    <c:set var="autoplayInterval" value="${5000}" />
  </c:when>
  <c:otherwise>
    <fmt:formatNumber var="autoplayInterval" value="${autoplayInterval}" maxFractionDigits="0" type="number" pattern="###"/>
    <c:set var="autoplayInterval" value="${autoplayInterval*1000}" />
  </c:otherwise>
</c:choose>

<c:set var="heightOption" value="${configCarouselGroup.options.heightOption}"/>

<c:set var="height" value="${fn:trim(configCarouselGroup.options.height)}"/>
<c:if test="${not empty height}">
  <fmt:formatNumber var="height" value="${height}" maxFractionDigits="0" type="number" pattern="###"/>
</c:if>

<c:set var="showNavigation" value="${configCarouselGroup.options.showNavigation}"/>
<c:set var="showPreviousNext" value="${configCarouselGroup.options.showPreviousNext}"/>

<c:set var="configCarouselGroupSerialNo" value="${requestScope.configCarouselGroupSerialNo+1}" scope="request"/>

<collection:createList id="carouselGroupItemsList" type="java.util.ArrayList"/>

<c:forEach var="carouselGroupItem" items="${carouselGroupItems}" varStatus="status">
  <c:choose>
    <c:when test="${carouselGroupItem.type=='tabPaneGroup'}">
      <c:set var="tabPaneGroupId" value="${requestScope.tabPaneGroupId + 1}" scope="request"/>
      <collection:add collection="${carouselGroupItemsList}" value="${carouselGroupItem}" />
    </c:when>
    <c:when test="${not empty carouselGroupItem.content and
                    fn:startsWith(carouselGroupItem.content.articleTypeName,'widget_')}">
      <collection:add collection="${carouselGroupItemsList}" value="${carouselGroupItem}" />
    </c:when>
  </c:choose>
</c:forEach>

<c:set var="carouselGroupWidth" value="${fn:trim(configCarouselGroup.options.width)}"/>
<c:if test="${empty carouselGroupWidth or carouselGroupWidth=='auto'}">
  <c:set var="carouselGroupWidth" value="${requestScope['elementwidth']}" />
</c:if>

<c:set var="customStyleClass" value="${fn:trim(configCarouselGroup.options.customStyleClass)}"/>
<c:set var="styleClass" value="carouselGroup ${customStyleClass}" />
<c:set var="styleId" value="${fn:trim(configCarouselGroup.options.styleId)}"/>
<c:remove var="customStyleClass" scope="page" />

<c:if test="${not empty carouselGroupItemsList}">
  <div class="${styleClass}"
       <c:if test="${not empty styleId}">id="${styleId}"</c:if>
       <c:if test="${not empty carouselGroupWidth and carouselGroupWidth!='auto'}">style="width:${carouselGroupWidth}px;"</c:if> >

    <c:remove var="styleClass" scope="page" />
    <c:remove var="styleId" scope="page" />
    <c:remove var="carouselGroupWidth" scope="page" />

    <c:set var="groupId" value="crouselGroup${configCarouselGroupSerialNo}"/>
    <c:set var="muberOfItems" value="${fn:length(carouselGroupItemsList)}"/>

      <%-- carousel content pane --%>
    <div class="content">
      <div id="view${groupId}"
           <c:if test="${heightOption eq 'fixed' and not empty height}">style="height:${height}px;"</c:if> >
        <c:forEach var="carouselGroupItem" items="${carouselGroupItemsList}" varStatus="status">
          <div class="carouselSlide" style="${status.first?'display:block;':'display:none;'}">
            <c:choose>
              <c:when test="${carouselGroupItem.type=='tabPaneGroup'}">
                <c:set var="customStyleClass" value="${fn:trim(carouselGroupItem.options.customStyleClass)}"/>
                <c:set var="styleClass" value="tabPaneGroup ${customStyleClass}" />
                <c:set var="styleId" value="${fn:trim(carouselGroupItem.options.styleId)}"/>

                <c:set var="tabPaneGroupAreaName" value="tabPaneGroup-area" />
                <c:set var="tabPaneGroupItems" value="${carouselGroupItem.areas[tabPaneGroupAreaName].items}"/>

                <div class="${styleClass}"  <c:if test="${not empty styleId}">id="${styleId}"</c:if> >
                  <c:set var="items" value="${tabPaneGroupItems}" scope="request"/>
                  <c:set var="paneGroupWidth" value="${carouselGroupWidth}" scope="request" />
                  <jsp:include page="../group/showPaneGroupItems.jsp"/>
                  <c:remove var="paneGroupWidth" scope="request" />
                </div>

                <c:remove var="tabPaneGroupItems" scope="page"/>
                <c:remove var="customStyleClass" scope="page" />
                <c:remove var="styleClass" scope="page" />
                <c:remove var="styleId" scope="page" />
              </c:when>
              <c:when test="${not empty carouselGroupItem.content and
                            fn:startsWith(carouselGroupItem.content.articleTypeName,'widget_')}">
                <c:set var="widgetName" value="${fn:substringAfter(carouselGroupItem.content.articleTypeName, 'widget_')}" scope="request"/>
                <c:set var="element" value="${carouselGroupItem}" scope="request"/>
                <c:choose>
                  <c:when test="${requestScope.isConfigSection}">
                    <c:if test="${element.content.state == 'published'}">
                      <div class="widget-div-main" id="widget-div-main-${element.content.id}">
                        <h1><c:out value="${element.content.fields.title.value}" escapeXml="true"/></h1>
                      </div>
                      <wf-core:getArticleFieldsMap articleTypeName="${contentType}" publicationId="${publication.id}" content="${element.content}" var="panelsMap"/>
                      <c:if test="${fn:length(panelsMap)>0}">
                        <div class="widget-div-popup" id="widget-div-popup-${element.content.id}">
                          <button class="popup-button" type="button" id="popup-button-${element.content.id}" >Hide</button>
                          <c:forEach var="panel" items="${panelsMap}">
                            <div class="popup-panel">
                              <h3>${panel.key}</h3>
                              <c:if test="${fn:length(panel.value)>0}">
                                <ul>
                                  <c:forEach var="field" items="${panel.value}">
                                    <li><span style="color:black;"><c:out value="${field.key}" escapeXml="true"/> </span>=<span style="color:cornflowerblue;"><c:out value="${field.value}" escapeXml="false"/></span></li>
                                  </c:forEach>
                                </ul>
                              </c:if>
                            </div>
                          </c:forEach>
                        </div>
                        <script language="javascript" type="text/javascript">
                          var configWidgetShowingPopupId = null;
                          var configWidgetSelectedMainDivId = null;
                          $(function(){
                            showWidgetOnClick('${element.content.id}');
                          });
                          $('#popup-button-${element.content.id}').click(function(e) {
                            hideWidget('${element.content.id}');
                          });
                        </script>
                      </c:if>
                    </c:if>
                  </c:when>
                  <c:otherwise>
                    <wf-core:include widgetName="${widgetName}" />
                  </c:otherwise>
                </c:choose>
              </c:when>
            </c:choose>
          </div>
        </c:forEach>
      </div>
    </div>

      <%-- carousel bottom controller --%>
    <div class="controller">
      <c:if test="${showNavigation}">
        <div id="${groupId}" class="navigation" style="width:${14*muberOfItems}px;">
          <c:forEach begin="0" end="${muberOfItems-1}" varStatus="status">
            <a onclick="showIndex${groupId}(${status.count-1})">&nbsp;</a>
          </c:forEach>
        </div>
      </c:if>
      <c:if test="${showPreviousNext}">
        <div class="previousNext">
          <div class="previous" title="Previous" onclick="showItem${groupId}(-1)">&nbsp;</div>
          <div class="next" title="Next" onclick="showItem${groupId}(1)">&nbsp;</div>
        </div>
      </c:if>
    </div>

    <script type="text/javascript">
      // <![CDATA[
      var timercarouselGroup${groupId};
      var  carouselGroupCounter${groupId} = 0;

      function startCarouselGroup${groupId}(){
      <c:if test="${showNavigation}">
        adjustNavigation${groupId}(carouselGroupCounter${groupId});
      </c:if>

      <c:if test="${muberOfItems>1}">
        var childNodes=document.getElementById("view${groupId}").children;
        for(i=0;i<childNodes.length;i++){
          if(i==carouselGroupCounter${groupId}){
            childNodes[i].setAttribute("style", "display:block;");
          }
          else{
            childNodes[i].setAttribute("style", "display:none;");
          }
        }

        carouselGroupCounter${groupId} =(carouselGroupCounter${groupId}+1)%${muberOfItems};
      <c:if test="${autoplay}">
        timercarouselGroup${groupId} = setTimeout('startCarouselGroup${groupId}()',${autoplayInterval});
      </c:if>
      </c:if>
      }

      function showItem${groupId}(increment){
      <c:if test="${autoplay}">
        if(timercarouselGroup${groupId} != null){
          clearTimeout(timercarouselGroup${groupId});
        }
      </c:if>

        carouselGroupCounter${groupId} = carouselGroupCounter${groupId}-1+increment;
        if(carouselGroupCounter${groupId}<0){
          carouselGroupCounter${groupId} += ${muberOfItems};
        }
        carouselGroupCounter${groupId} = (carouselGroupCounter${groupId})%${muberOfItems};

      <c:if test="${showNavigation}">
        adjustNavigation${groupId}(carouselGroupCounter${groupId});
      </c:if>

      <c:if test="${muberOfItems>1}">
        var childNodes = document.getElementById("view${groupId}").children;
        for(i=0;i<childNodes.length;i++){
          if(i==carouselGroupCounter${groupId}){
            childNodes[i].setAttribute("style", "display:block;");
          }
          else{
            childNodes[i].setAttribute("style", "display:none;");
          }
        }
        carouselGroupCounter${groupId} =(carouselGroupCounter${groupId}+1)%${muberOfItems};

      <c:if test="${autoplay}">
        timercarouselGroup${groupId} = setTimeout('startCarouselGroup${groupId}()',${autoplayInterval});
      </c:if>

      </c:if>
      }

      function showIndex${groupId}(index){
        showItem${groupId}( index+1-carouselGroupCounter${groupId} );
      }

      function adjustNavigation${groupId}(index){
        var childNodes=document.getElementById("${groupId}").children;
        for(i=0;i<childNodes.length;i++){
          if(i==index){
            childNodes[i].setAttribute("class", "active");
          }
          else{
            childNodes[i].setAttribute("class", "");
          }
        }
      }

      startCarouselGroup${groupId}();
      // ]]>
    </script>
  </div>
</c:if>

