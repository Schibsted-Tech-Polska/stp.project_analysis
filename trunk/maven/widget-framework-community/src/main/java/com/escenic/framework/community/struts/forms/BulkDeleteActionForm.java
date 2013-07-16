/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-community/src/main/java/com/escenic/framework/community/struts/forms/BulkDeleteActionForm.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.community.struts.forms;

import org.apache.struts.action.ActionForm;

public class BulkDeleteActionForm extends ActionForm {
  private String mArticleIds = "";
  private String mSuccessUrl = null;
  private String mErrorUrl = null;

  public String getArticleIds(){
    return mArticleIds;
  }
  public void setArticleIds(String pArticleIds){
    this.mArticleIds = pArticleIds;
  }

  public String getSuccessUrl(){
    return this.mSuccessUrl;
  }
  public void setSuccessUrl(String pSuccessUrl){
    this.mSuccessUrl = pSuccessUrl;
  }

  public String getErrorUrl(){
    return this.mErrorUrl;
  }
  public void setErrorUrl(String pErrorUrl){
    this.mErrorUrl = pErrorUrl;
  }
}
