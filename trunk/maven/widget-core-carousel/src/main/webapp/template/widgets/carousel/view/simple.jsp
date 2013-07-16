<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-carousel/src/main/webapp/template/widgets/carousel/view/simple.jsp#2 $
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>
<%@ taglib prefix="article" uri="http://www.escenic.com/taglib/escenic-article" %>
<%@ taglib prefix="section" uri="http://www.escenic.com/taglib/escenic-section" %>

<jsp:useBean id="carousel" type="java.util.Map" scope="request"/>
<c:set var="uniqueId" value="${widgetContent.id}"/>



<c:if test="${not empty carousel.attributeMapList}">
  <div class="${carousel.wrapperStyleClass}" <c:if test="${not empty carousel.styleId}">id="${carousel.styleId}"</c:if>>

    <!-- custom styles for this widget -->
    <jsp:include page="./helpers/styles.jsp"/>

    <!-- main display for image and overlay -->
    <div id="mainDisplayContainer${uniqueId}" class="mainDisplayContainer mainDisplayContainer${uniqueId}" >
      <a id="articleAnchor${uniqueId}" href="#"><img id="mainImage${uniqueId}" class="mainImage" src="http://static.flowplayer.org/tools/img/blank.gif" alt=""/></a>
      <c:if test="${carousel.showFilmstrip == 'false'}">
        <c:set var="filmstripVisibilityClass" value="hiddenContainer"/>
      </c:if>

      <div class="filmstrip filmstrip_${carousel.filmstripPosition} filmstrip${uniqueId} ${filmstripVisibilityClass}">

        <c:set var="uniqueId" value="${pageScope.uniqueId}" scope="request"/>
        <c:set var="navigationHtml">
          <jsp:include page="helpers/navigationMarkup.jsp"/>
        </c:set>
        <c:remove var="uniqueId" scope="request"/>

        <c:if test="${carousel.filmstripPosition == 'top'}">
          <c:out value="${navigationHtml}" escapeXml="false"/>
        </c:if>

        <c:if test="${carousel.showNavigationArrows == 'true'}">
          <c:if test="${carousel.records.filmstripPattern == 'Horizontal'}">
            <a id="carousel-filmstrip-browse-left-${uniqueId}" class="prevPage browseFilmstripHorizontal browseFilmstrip${uniqueId} leftFilmstrip">&nbsp;</a>
          </c:if>
          <c:if test="${carousel.records.filmstripPattern == 'Vertical'}">
            <a id="carousel-filmstrip-browse-left-${uniqueId}" class="prevPage browseFilmstripVertical browseFilmstrip${uniqueId} topFilmstrip">&nbsp;</a>
          </c:if>
        </c:if>


        <div id="carouselScrollableContainer${uniqueId}" class="scrollable scrollable${uniqueId}" >
          <div class="items items${carousel.records.filmstripPattern}">

            <c:forEach items="${carousel.attributeMapList}" var="item" varStatus="status">
              <c:set var="className" value="${status.first?'active':''}"/>
              <div class="item item${uniqueId} ${className}">
                <img src="${item.thumbnailImageUrl}"
                     style="width: ${carousel.records.thumbnailImageWidth}px; height: ${carousel.records.thumbnailImageHeight}px;"
                     alt="${item.imageAlttext}"
                     width="${carousel.records.thumbnailImageWidth}"
                     height="${carousel.records.thumbnailImageHeight}" />

                <c:if test="${carousel.filmstripTitleStyle != 'hidden'}">
                  <c:set var="sideStyle" value="titleSide titleSide${uniqueId}"/>
                  <c:set var="filmstripTitleStyleClass" value="${carousel.filmstripTitleStyle=='over' ? 'titleOver':sideStyle}"/>
                  <div class="${filmstripTitleStyleClass}">
                    <h4><c:out value="${item.flimstripTitle}" escapeXml="true"/></h4>
                  </div>
                </c:if>
                
              </div>
            </c:forEach>
          </div>
        </div>

        <c:if test="${carousel.showNavigationArrows == 'true'}">
          <c:if test="${carousel.records.filmstripPattern == 'Horizontal'}">
            <a id="carousel-filmstrip-browse-right-${uniqueId}" class="nextPage browseFilmstripHorizontal browseFilmstrip${uniqueId} rightFilmstrip">&nbsp;</a>
          </c:if>
          <c:if test="${carousel.records.filmstripPattern == 'Vertical'}">
            <a id="carousel-filmstrip-browse-right-${uniqueId}" class="nextPage browseFilmstripVertical browseFilmstrip${uniqueId} bottomFilmstrip<c:if test="${carousel.showNavigationIndicators == 'true'}"> indicators</c:if>">&nbsp;</a>
          </c:if>
        </c:if>

        <c:if test="${carousel.filmstripPosition != 'top'}">
          <c:out value="${navigationHtml}" escapeXml="false"/>
        </c:if>

      </div>


      <c:if test="${carousel.showOverlay == 'true'}">
        <c:set var="uniqueId" value="${pageScope.uniqueId}" scope="request"/>
        <jsp:include page="helpers/overlayMarkup.jsp"/>
        <c:remove var="uniqueId" scope="request"/>      
      </c:if>
      
      <c:if test="${carousel.showPrevNextArrows == 'true' and fn:length(carousel.attributeMapList)>1}">
        <c:set var="uniqueId" value="${pageScope.uniqueId}" scope="request"/>
        <jsp:include page="helpers/prevNextArrowsMarkup.jsp"/>
        <c:remove var="uniqueId" scope="request"/>
      </c:if>
      
      <a id="playButtonr${uniqueId}" class="playButton ${carousel.records.playButtonStyleName}" style="display:none;">&nbsp;</a>

    </div>

    <!--html for overlay-->

    <div style="width:0px; height:0px; visibility:hidden;">
      <c:set var="itemIndex" value="${0}" scope="page"/>
      <c:forEach var="attrMap" items="${carousel.attributeMapList}">
        <c:if test="${carousel.showOverlay == 'true'}">
          <div id="overlayHtml_${uniqueId}_0_${itemIndex}">
            <c:choose>
              <c:when test="${empty attrMap.relatedItems}">
                <c:set var="infoWrapperClass" value="infoWrapperFull${carousel.records.overlayPattern}"/>
              </c:when>
              <c:otherwise>
                <c:set var="infoWrapperClass" value="infoWrapperPartial${carousel.records.overlayPattern}"/>
              </c:otherwise>
            </c:choose>
            <div class="${infoWrapperClass}">
              <div class="info">
                <h2><a href="${attrMap.url}"><c:out value="${attrMap.title}" escapeXml="true"/></a></h2>
                <c:if test="${carousel.showLeadText == 'true'}">
                  <p><c:out value="${attrMap.leadtext}" escapeXml="true"/></p>
                </c:if>
                <c:if test="${carousel.showCommentCount}">
                  <c:url var="commnetsLinkUrl" value="${attrMap.url}">
                    <c:param name="tabPane" value="Comments"/>
                  </c:url>
                  <p><a href="${commnetsLinkUrl}#commentsList"><c:out value="${attrMap.commentCount}" escapeXml="true"/></a></p>
                </c:if>
              </div>
            </div>

            <c:if test="${not empty attrMap.relatedItems}">
              <div class="relatedItems${carousel.records.overlayPattern}">
                <ul class="relatedItemList">
                  <c:forEach var="content" items="${attrMap.relatedItems}">
                    <li><a href="${content.url}"><c:out value="${content.title}" escapeXml="true"/></a></li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>
          </div>
        </c:if>

        <div id="carouselImgaeUrl_${uniqueId}_0_${itemIndex}">
          <c:out value="${attrMap.imageUrl}" escapeXml="true"/>
        </div>
        <div id="articleUrl_${uniqueId}_0_${itemIndex}">
          <c:out value="${attrMap.url}" escapeXml="true"/>
        </div>

        <a id="playButton_${uniqueId}_0_${itemIndex}" href="${attrMap.url}?playVideo=true" style="${attrMap.isVideo?'display:block;':'display:none;'}"></a>
        <c:set var="itemIndex" value="${itemIndex + 1}"/>
      </c:forEach>
      <c:remove var="itemIndex" scope="page"/>
    </div>

    <script type="text/javascript">
      // <![CDATA[
      var api_${uniqueId};
      var obj_${uniqueId};

      // execute your scripts when the DOM is ready. this is a good habit
      jQuery(function() {
        // initialize scrollable
        // clickable
        api_${uniqueId} = jQuery("#carouselScrollableContainer${uniqueId}").scrollable({vertical:${carousel.records.filmstripPattern =='Vertical'}, size:${carousel.maxScrollpaneItems}}).navigator({api:true, navi:".indicator"});
        /* set navigaion indicator width so that it is rightly set at middle */
        <c:if test="${carousel.showNavigationIndicators == 'true'}">
          jQuery("#nav${uniqueId} div.indicator").css( {"width": (20 * api_${uniqueId}.getPageAmount())+"px"}  );
        </c:if>

        /* set navigation arrows disabled status correctly */
        <c:if test="${carousel.showNavigationArrows == 'true'}">
          jQuery("#carousel-filmstrip-browse-left-${uniqueId}").removeClass('disabled').addClass('disabled');
          if(api_${uniqueId}.getPageAmount() > 1){
            jQuery("#carousel-filmstrip-browse-right-${uniqueId}").removeClass('disabled');
          }
          else {
           jQuery("#carousel-filmstrip-browse-right-${uniqueId}").removeClass('disabled').addClass('disabled');
          }
        </c:if>
      });

      jQuery(function()
      {
        var tabIndex_${uniqueId} = 0;
        var lastClickedIndex_${uniqueId}=-1;
        obj_${uniqueId} = this;
        function displayClickedCarouselItem_${uniqueId}(){

          jQuery("#mainImage${uniqueId}").css({"display":"block"});
          jQuery("#video${uniqueId}").css({"display":"none"});
          var index = api_${uniqueId}.getClickIndex();
          if(index!=lastClickedIndex_${uniqueId})
          {
            lastClickedIndex_${uniqueId} = index;
            var mainDisplayContainerId = "mainDisplayContainer${uniqueId}";
            var mainImageId = "mainImage${uniqueId}";
            var articleAnchorId = "articleAnchor${uniqueId}";
            var articleUrlContainerId = "articleUrl_${uniqueId}_" + tabIndex_${uniqueId} + "_" + index;
            var imageUrlContainerId = "carouselImgaeUrl_${uniqueId}_" + tabIndex_${uniqueId} + "_" + index;

            var mainDisplayContainer = jQuery("#"+mainDisplayContainerId).fadeTo("fast", 0.5);
            var imageUrl = jQuery("#"+imageUrlContainerId)[0].innerHTML;
            var img = new Image();
            // call this function after it's loaded
            img.onload = function() {

              // make wrapper fully visible
              mainDisplayContainer.fadeTo("fast", 1);
              // change the image
              jQuery("#"+mainImageId).attr("src", imageUrl);

              <c:if test="${carousel.showOverlay == 'true'}">
                var elem = document.getElementById("oerlayContainer${uniqueId}");
                var htmlContainerId = "overlayHtml_${uniqueId}_" + tabIndex_${uniqueId} + "_" + index;
                elem.innerHTML = jQuery("#"+htmlContainerId)[0].innerHTML;
              </c:if>

              // update article ancho url
              jQuery("#" + articleAnchorId).attr("href", jQuery("#"+articleUrlContainerId)[0].innerHTML);

              // update url of a video
              var urlContainerId = "playButton_${uniqueId}_" + tabIndex_${uniqueId} + "_" + index;
              jQuery("#playButtonr${uniqueId}").attr("href",jQuery("#"+urlContainerId)[0].getAttribute("href"));
              jQuery("#playButtonr${uniqueId}").attr("style",jQuery("#"+urlContainerId)[0].getAttribute("style"));
            };
            img.src = imageUrl;
          }
        }

        jQuery("#carouselScrollableContainer${uniqueId} .items div").click(function() {
          displayClickedCarouselItem_${uniqueId}();
          // when page loads simulate a "click" on the first image
        }).filter(":first").click();

        // change the active item index by pIndexOffset
        this.changeDisplayItemCarousel_${uniqueId} = function(pApi, pIndexOffset){
          var index = pApi.getClickIndex();
          var size = pApi.getSize();
          var nextIndex = (index + pIndexOffset) % size;
          nextIndex = nextIndex < 0 ? nextIndex + size : nextIndex;
          pApi.click(nextIndex);
          displayClickedCarouselItem_${uniqueId}();
        }

        // prev-next button
        <c:if test="${carousel.showPrevNextArrows == 'true' and fn:length(carousel.attributeMapList)>1}">
          jQuery("#prevCarouselItemButton_${uniqueId}").click(function(){
            if(obj_${uniqueId}){
              obj_${uniqueId}.changeDisplayItemCarousel_${uniqueId}(api_${uniqueId}, -1);
            }
          });

          jQuery("#nextCarouselItemButton_${uniqueId}").click(function(){
            if(obj_${uniqueId}){
              obj_${uniqueId}.changeDisplayItemCarousel_${uniqueId}(api_${uniqueId}, 1);
            }
          });
        </c:if>
      });

      var mouseOverCarousel = false;
      function carouselPlayPause(link){
        if (link.innerHTML == 'Play'){
          link.innerHTML = 'Pause';
          mouseOverCarousel = false;
        }
        else  if (link.innerHTML == 'Pause'){
          link.innerHTML = 'Play';
          mouseOverCarousel = true;
        }
      }

      function carouselMouseOut(){
        mouseOverCarousel = false;
      }
              
      startSlideShow_${uniqueId}();
      function startSlideShow_${uniqueId}(){
        <c:if test="${carousel.autoplay}">
          setTimeout('startSlideShow_${uniqueId}()',${carousel.autoplayInterval});
          if(!mouseOverCarousel){
            if(obj_${uniqueId}){
              obj_${uniqueId}.changeDisplayItemCarousel_${uniqueId}(api_${uniqueId}, 1);
            }
          }
        </c:if>
      }

      // ]]>
    </script>
  </div>
</c:if>

<c:remove var="carousel" scope="request"/>

