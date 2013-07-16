/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/java/com/escenic/framework/struts/forms/EmailForm.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.struts.forms;

import org.apache.struts.action.ActionForm;

public class EmailForm  extends ActionForm {
  private String mMailto = null;
  private String mId = null;
  private String mLinkType = null;
  private String mFirstName = null;
  private String mSurname = null;

   public void setId(String pId){
    mId = pId;
  }
  public String getId(){
    return mId;
  }
   public void setLinkType(String pLinkType){
    mLinkType = pLinkType;
  }
  public String getLinkType(){
    return mLinkType;
  }
   public void setFirstName(String pFirstName){
    mFirstName = pFirstName;
  }
  public String getFirstName(){
    return mFirstName;
  }
  public void setSurname(String pSurname){
    mSurname = pSurname;
  }
  public String getSurname(){
    return mSurname;
  }
   public void setMailto(String pMailto){
    mMailto = pMailto;
  }
  public String getMailto(){
    return mMailto;
  }
}
