/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/java/com/escenic/framework/struts/CustomAuthenticatedInsertCommentAction.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.struts;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import neo.xredsys.api.*;
import com.escenic.forum.struts.presentation.AuthenticatedInsertCommentAction;
import com.escenic.forum.struts.presentation.PostingForm;

/*
 * The purpose of this action is to set the homeSection of a logged-in community user as the homeSection of all of his posted comments.
 * By default in AuthenticatedInsertCommentAction, the homeSection of all the comments/postings is as same as their parent forum 
 *
 * @author <a href="mailto:shaon@escenic.com">Ferdous Mahmud Shaon</a>
 * @version $Revision: #1 $
 *
 */

public class CustomAuthenticatedInsertCommentAction extends AuthenticatedInsertCommentAction {
  protected final Logger mLogger = Logger.getLogger(getClass());

  public CustomAuthenticatedInsertCommentAction() {
    super();
  }

  protected int getSectionId(HttpServletRequest pRequest, PostingForm pForm, Person creator) {
    String username = getUser(pRequest).getUserName();
    Publication publication = (Publication)pRequest.getAttribute("publication");

    if(mLogger.isDebugEnabled()) {
      mLogger.debug("Current user is: "+username+" in the publication "+publication.getName());
    }

    Section userHomeSection = IOAPI.getAPI().getObjectLoader().getSectionByUniqueName(publication.getId(), username);

    if(userHomeSection!=null) {
      if(mLogger.isDebugEnabled()) {
        mLogger.debug("Successfully loaded the current user home section with id: "+userHomeSection.getId());
        mLogger.debug("Section "+userHomeSection.getId()+ " will be used as the posting home section");
      }
      return userHomeSection.getId();
    }
    else {
      if(mLogger.isDebugEnabled()) {
        mLogger.debug("Failed to load current user home section. So the forum section will be used as the posting home section");
      }
      return -1;
    }
  }
}
