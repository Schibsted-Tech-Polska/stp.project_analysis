<%--
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-core-trailers/src/main/webapp/template/widgets/trailers/view/helpers/articleInNewsletterView.jsp#3 $
 * Last edited by : $Author: shah $ $Date: 2010/10/21 $
 * Version        : $Revision: #3 $
 *
 * Copyright (C) 2010 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="wf-core" uri="http://www.escenic.com/widget-framework/core" %>

<jsp:useBean id="trailers" type="java.util.Map" scope="request"/>
<jsp:useBean id="articleAttributeMap" type="java.util.Map" scope="request"/>

<c:set var="imageVersion" value="${articleAttributeMap.imageVersion}"/>
<c:set var="teaserImageMap" value="${articleAttributeMap.teaserImageMap}"/>
<c:set var="teaserImageArticle" value="${teaserImageMap.imageArticle}"/>

<%-- handle the rendering of first article --%>
<table>
    <tr>
        <c:choose>
            <c:when test="${trailers.showTitleNewsletter}">
                <c:choose>
                    <c:when test="${trailers.imagePositionNewsletter eq 'right'}">
                        <td valign="top" align="left">
                            <h3 style="font-size:11px;margin: 0px 0px 1px 0px;">
                                <a style="margin-left:2px;" href="${articleAttributeMap.url}">
                                    <c:out value="${articleAttributeMap.title}" escapeXml="false"/></a>
                            </h3>
                        </td>
                        <td valign="top" align="left">
                            <c:if test="${not empty teaserImageArticle}">
                                <c:choose>
                                    <c:when test="${trailers.softCrop}">
                                        <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                                             alt="${teaserImageMap.alttext}"
                                             title="${teaserImageMap.caption}"
                                             style="border: 1px solid #000000;"
                                             width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                                             height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                                             alt="${teaserImageMap.alttext}"
                                             style="border: 1px solid #000000;"
                                             title="${teaserImageMap.caption}"
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td valign="top" align="left">
                            <c:if test="${not empty teaserImageArticle}">
                                <c:choose>
                                    <c:when test="${trailers.softCrop}">
                                        <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                                             alt="${teaserImageMap.alttext}"
                                             title="${teaserImageMap.caption}"
                                             style="border: 1px solid #000000;"
                                             width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                                             height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                                             alt="${teaserImageMap.alttext}"
                                             style="border: 1px solid #000000;"
                                             title="${teaserImageMap.caption}"
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </td>
                        <td valign="top" align="left">
                            <h3 style="font-size:11px;margin: 0px 0px 1px 0px;"><a style="margin-left:2px;"
                                                                                   href="${articleAttributeMap.url}"><c:out
                                    value="${articleAttributeMap.title}" escapeXml="false"/></a></h3>
                        </td>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <td valign="top" align="left">
                    <c:if test="${not empty teaserImageArticle}">
                        <c:choose>
                            <c:when test="${trailers.softCrop}">
                                <img src="${teaserImageArticle.fields.alternates.value[imageVersion].href}"
                                     alt="${teaserImageMap.alttext}"
                                     title="${teaserImageMap.caption}"
                                     style="border: 1px solid #000000;"
                                     width="${teaserImageArticle.fields.alternates.value[imageVersion].width}"
                                     height="${teaserImageArticle.fields.alternates.value[imageVersion].height}"
                            </c:when>
                            <c:otherwise>
                                <img src="${teaserImageArticle.fields.binary.value[imageVersion]}"
                                     alt="${teaserImageMap.alttext}"
                                     style="border: 1px solid #000000;"
                                     title="${teaserImageMap.caption}"
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </td>
            </c:otherwise>
        </c:choose>
    </tr>
</table>

<%-- display summary--%>
<c:if test="${trailers.showIntroNewsletter}">
    <p style="display:inline;font-size:10px;margin:0;"><c:out value="${articleAttributeMap.intro}" escapeXml="true"/></p>
</c:if>
<c:if test="${trailers.showComments}">
    <p style="">
        <a href="${articleAttributeMap.url}#commentsList"><c:out value="${articleAttributeMap.numOfComments}" escapeXml="true"/> comments</a>
    </p>
</c:if>
