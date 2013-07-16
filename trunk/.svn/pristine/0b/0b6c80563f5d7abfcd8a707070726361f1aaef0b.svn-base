<%--
 * File           : $Header: //depot/projects/widget-framework/src/main/webapp/WEB-INF/tags/escenic-framework/getLoginUrl.tag#1 $
 * Last edited by : $Author: shaon $ $Date: 2009/03/27 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ tag language="java" body-content="empty" isELIgnored="false"  pageEncoding="UTF-8"%>
<%@ tag import="java.lang.Math" %>
<%@ attribute name="var" required="true" rtexprvalue="false" %>
<%@ attribute name="f" required="true" type="java.lang.Integer" %>
<%@ attribute name="round" required="false" type="java.lang.Boolean" %>


<%
  if(round==null){  
    round = true;
  }
  Double c = (f-32.0)*5.0/9.0 ;
  if(round){
    request.setAttribute(var, Math.round(c)) ;
  }
  else {
    request.setAttribute(var, c) ;
  }
%>
