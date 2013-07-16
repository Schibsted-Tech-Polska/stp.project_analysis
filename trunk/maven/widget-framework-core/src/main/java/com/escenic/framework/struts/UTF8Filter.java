package com.escenic.framework.struts;

/**
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/java/com/escenic/framework/struts/UTF8Filter.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
**/

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
 * The purpose of this filter is to set the character encoding of Struts request and response to UTF-8.
 * This is necessary to inform Struts about the encoding, because the default encoding of struts is ISO-8859-1.
 *
 * @author <a href="mailto:shamim@escenic.com">Shamim Ahmed</a>
 * @version $Revision: #1 $
 *
 */

public class UTF8Filter implements Filter {
  private static final String UTF_8 = "UTF-8";

  public void init(FilterConfig pConfig) {
  }

  public void doFilter(ServletRequest pRequest, ServletResponse pResponse, FilterChain pFilterChain)
      throws ServletException, IOException {
    pRequest.setCharacterEncoding(UTF_8);
    pResponse.setCharacterEncoding(UTF_8);
    pFilterChain.doFilter(pRequest, pResponse);
  }

  public void destroy() {
  }
}
