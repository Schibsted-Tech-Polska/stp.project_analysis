/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.3/widget-framework-community/src/main/java/com/escenic/framework/community/struts/actions/CustomLoadArticle.java#1 $
 * Last edited by : $Author: shaon $ $Date: 2010/09/21 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.community.struts.actions;

import com.escenic.domain.ContentSummary;
import com.ndc.community.api.domain.User;
import com.ndc.escenic.util.EscenicObjects;
import com.ndc.usercontent.api.exception.UserContentException;
import com.ndc.usercontent.struts.actions.forms.AbstractArticleForm;
import com.ndc.usercontent.struts.actions.forms.ArticleForm;
import com.ndc.usercontent.struts.actions.load.AbstractLoadArticle;
import neo.xredsys.api.Article;
import neo.xredsys.api.IOHashKey;
import neo.xredsys.api.Publication;
import org.apache.struts.action.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.util.List;

/*
 * This is a custom LoadArticle extending AbstractLoadArticle provided by community engine
 * The purpose of this modified form is to handle related pictures of an article
 *
 * @see ccom.escenic.framework.community.struts.forms.CustomArticleForm;
 * @see com.ndc.usercontent.struts.actions.forms.AbstractArticleForm;
 * @see com.ndc.usercontent.struts.actions.forms.ArticleForm
 *
 * @author <a href="mailto:ashis@escenic.com">Ashis Saha</a>
 * @version $Revision: #1 $
 *
 */

public class CustomLoadArticle extends AbstractLoadArticle {

  private static final String PICTURE_RELATION_TYPE_NAME = "PICTUREREL";


  /**
   * @param form
   *            {@link com.ndc.usercontent.struts.actions.forms.ArticleForm}
   * @return Request attribute "articleObject" - Article object
   */
  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception,
      IOException, ServletException, UserContentException {


    final ArticleForm articleForm = (ArticleForm) form;
    final ActionErrors errors = new ActionErrors();

    // Input form
    final String successUrl = articleForm.getSuccessUrl();
    checkSuccessForward(successUrl, mapping);
    final String errorUrl = articleForm.getErrorUrl();
    checkErrorForward(errorUrl, mapping);

    // Get the publication
    Long publicationId = articleForm.getPublicationId() != null ? articleForm.getPublicationId().longValue() : EscenicObjects.getPublicationId(request);
    if (publicationId == null) {
      throw new IllegalArgumentException("form.publicationId is null");
    }
    final Publication publication = getObjectLoader().getPublicationById(publicationId.intValue());
    if (publication == null) {
      throw new IllegalArgumentException("publication is null");
    }

    // Set the default forward
    ActionForward forward = getErrorForward(errorUrl, mapping, publication, false);

    // get the loggedin user
    final User user = getUser(request);
    if (user == null) {
      throw new IllegalArgumentException("No loggedin user found");
    }

    final Integer articleId = articleForm.getArticleId();
    if (articleId != null && articleId != 0) {

      final Article article = getObjectLoader().getArticle(articleId);

      if (article != null) {

        ActionMessages actionMessages = getMessages(request);
        if (actionMessages.size() == 0) {
          // Fill the field in the article form
          fillForm(articleForm, article);
        }
        request.setAttribute("articleObject", article);

        forward = getSuccessForward(successUrl, mapping, publication, false);

      }

    }
    if (!errors.isEmpty()) {
      // Store the errors
      saveMessages(request, errors);
    }
    return forward;
  }

  protected void fillForm(AbstractArticleForm form, Article article) {
    super.fillForm(form, article);

    String image = "";

    // get picture type ContentSummaries of the article
    List<ContentSummary> contentSummaries = article.getContentSummaries(PICTURE_RELATION_TYPE_NAME);

    // for each content summary, find the id of the related article
    for (ContentSummary contentSummary : contentSummaries) {
      URI contentHref = contentSummary.getContentLink().getHref();
      int contentId = IOHashKey.valueOf(contentHref).getObjectId();
      if (image.length() != 0) {
        image += "," + contentId;
      } else {
        image += contentId;
      }
    }

    form.setImage(image);
  }

}
