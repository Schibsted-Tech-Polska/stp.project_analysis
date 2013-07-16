/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-community/src/main/java/com/escenic/framework/community/struts/actions/BulkDeleteAction.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.community.struts.actions;

import com.escenic.framework.community.struts.forms.BulkDeleteActionForm;
import com.ndc.escenic.ArticleUtil;
import com.ndc.escenic.util.EscenicObjects;
import com.ndc.usercontent.api.exception.UserContentException;
import com.ndc.usercontent.struts.actions.AbstractUserContentAction;
import neo.xredsys.api.NoSuchObjectException;
import neo.xredsys.api.PersistentStoreException;
import neo.xredsys.api.Publication;
import org.apache.struts.action.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class BulkDeleteAction extends AbstractUserContentAction {

  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception,
          IOException, ServletException, UserContentException {

    // typecast the form
    final BulkDeleteActionForm bulkDeleteActionForm = (BulkDeleteActionForm) form;

    // get the publication
    Long publicationId = EscenicObjects.getPublicationId(request);
    if (publicationId == null) {
      throw new IllegalArgumentException("publicationId is null");
    }

    final Publication publication = getObjectLoader().getPublicationById(publicationId.intValue());
    if (publication == null) {
      throw new IllegalArgumentException("publication is null");
    }

    // forwards
    final String successUrl = bulkDeleteActionForm.getSuccessUrl();
    checkSuccessForward(successUrl, mapping);
    final String errorUrl = bulkDeleteActionForm.getErrorUrl();
    checkErrorForward(errorUrl, mapping);

    // set default forward to error
    ActionForward forward = getErrorForward(errorUrl, mapping, publication, false);
    final ActionErrors errors = new ActionErrors();

    final String articleIds = bulkDeleteActionForm.getArticleIds().trim();

    if (articleIds.length() > 0) {
      final String[] articleIdsArray = articleIds.split(",");

      for (String articleIdString : articleIdsArray) {
        long articleId = Integer.parseInt(articleIdString);
        try {
          ArticleUtil.delete(articleId);
        }
        catch (PersistentStoreException e) {
          mLogger.error(e);
          errors.add("error", new ActionMessage("usercontent.persistentstoreexception", e.getMessage()));
        }
        catch (NoSuchObjectException e) {
          mLogger.error(e);
          errors.add("error", new ActionMessage("usercontent.nosuchobjectexception", e.getMessage()));
        }
      }
    }

    //update forward to success if no error found
    if (errors.isEmpty()) {
      forward = getSuccessForward(successUrl, mapping, publication, false);
    } else {
      saveMessages(request, errors);
    }

    return forward;
  }

}
