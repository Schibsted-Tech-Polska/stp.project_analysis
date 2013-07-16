/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.3/widget-framework-community/src/main/java/com/escenic/framework/community/struts/actions/CustomSaveArticle.java#1 $
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

import com.escenic.domain.ContentDescriptor;
import com.escenic.domain.ContentSummary;
import com.escenic.domain.PropertyDescriptor;
import com.ndc.community.api.domain.User;
import com.ndc.community.api.exceptions.CommunityException;
import com.ndc.escenic.util.EscenicObjects;
import com.ndc.tag.api.exception.TagException;
import com.ndc.usercontent.api.exception.UserContentException;
import com.ndc.usercontent.plugin.validator.FieldValidator;
import com.ndc.usercontent.struts.actions.forms.AbstractArticleForm;
import com.ndc.usercontent.struts.actions.forms.ArticleForm;
import com.ndc.usercontent.struts.actions.save.AbstractSaveArticle;
import neo.nursery.GlobalBus;
import neo.util.xml.TidyUtil;
import neo.xredsys.api.*;
import neo.xredsys.content.type.*;
import neo.xredsys.content.type.Type;
import neo.xredsys.content.type.TypeManager;
import org.apache.struts.action.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/*
 * This is a custom saveArticle action extending the AbstractSaveArticle action provided by community engine
 * The purpose of this modified action is to handle non-legacy related pictures etc. with ECE v5
 *
 * @see com.ndc.usercontent.struts.actions.save.SaveArticle
 * @see com.ndc.usercontent.struts.actions.save.AbstractSaveArticle
 * @see com.ndc.usercontent.struts.actions.forms.ArticleForm
 *
 * @author <a href="mailto:shaon@escenic.com">Ferdous Mahmud Shaon</a>
 * @version $Revision: #1 $
 *
 */


public final class CustomSaveArticle extends AbstractSaveArticle {
  private static final String PICTURE_RELATION_TYPE_NAME = "PICTUREREL";
  private static final String COMPONENT_PATH_CONTENT_DESCRIPTOR_FACTORY = "/neo/io/content/ContentDescriptorFactory"; 

  private ContentDescriptorFactory mContentDescriptorFactory;

  public CustomSaveArticle() {
    mContentDescriptorFactory = (ContentDescriptorFactory) GlobalBus.lookupSafe(COMPONENT_PATH_CONTENT_DESCRIPTOR_FACTORY);
  }

  /**
   * @param form {@link com.ndc.usercontent.struts.actions.forms.ArticleForm}
   * @return ActionMessage - savearticle.error
   */

  public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
      throws Exception, IOException, ServletException, UserContentException, TagException, CommunityException {

    final ArticleForm articleForm = (ArticleForm) form;


    // retrieve mapping configuration
    Map<String, String> mappingConfiguration = getMappingConfiguration(mapping);
    if ((mappingConfiguration.get("articleType") == null) || mappingConfiguration.get("articleType").equals("")) {
      if ((articleForm.getArticleType() == null) || articleForm.getArticleType().equals("")) {
         mLogger.error("articleType name is null");
        throw new IllegalArgumentException("articleType name is null");
      }
      else {
        mappingConfiguration.put("articleType", articleForm.getArticleType());
      }
    }

    // The forwards
    final String successUrl = articleForm.getSuccessUrl();
    final String errorUrl = articleForm.getErrorUrl();

    checkErrorForward(errorUrl, mapping);

    // Get the publication
    Long publicationId = articleForm.getPublicationId() != null ? articleForm.getPublicationId().longValue() : EscenicObjects.getPublicationId(request);

    if (publicationId == null) {
      mLogger.error("form.publicationId is null");
      throw new IllegalArgumentException("form.publicationId is null");
    }

    final Publication publication = getObjectLoader().getPublicationById(publicationId.intValue());

    if (publication == null) {
      mLogger.error("publication is null");
      throw new IllegalArgumentException("publication is null");
    }

    // Set the default forward
    ActionForward forward = getErrorForward(errorUrl, mapping, publication, false);


    // get the loggedin user
    final User user = getUser(request);

    if (user == null) {
      mLogger.error("No loggedin user found");
      throw new IllegalArgumentException("No loggedin user found");
    }


    final ArticleType articleType = TypeManager.getInstance().getArticleType(publicationId.intValue(), mappingConfiguration.get("articleType"));
    if (articleType == null) {
      mLogger.error("articleType object is null");
      throw new IllegalArgumentException("articleType object is null");
    }

    final Integer sectionId = getSectionId(articleForm, user);
    if ((sectionId == null) || (sectionId == 0)) {
      mLogger.error("articleForm.sectionId is null");
      throw new IllegalArgumentException("articleForm.sectionId is null");
    }

    final String state = articleForm.getState();
    if ((state == null) || (state.length() == 0)) {
      mLogger.error("articleForm.state is null");
      throw new IllegalArgumentException("articleForm.state is null");
    }

    final String articleTypeName = articleType.getName();
    if ((articleTypeName == null) || (articleTypeName.length() == 0)) {
      mLogger.error("articleType.name is null");
      throw new IllegalArgumentException("articleType.name is null");
    }

    // Check is the article is correct
    final ActionErrors errors = new ActionErrors(validator.validateForm(articleForm, articleType, publication, user.getId()));


    // Check if the captcha is correct
    if (!checkCaptcha(request)) {
      if(mLogger.isDebugEnabled()) {
        mLogger.debug("characters didn't match with captcha");
      }
      errors.add("CAPTCHA", new ActionMessage("validate.error.captcha", "CAPTCHA"));
    }


    if (errors.isEmpty()) {
      final Integer articleId = articleForm.getArticleId();

      // Open a Article Transaction
      ArticleTransaction articleTransaction;

      if (articleId != null && articleId != 0) {
        // we are going to edit an article with the given articleId
        articleTransaction = (ArticleTransaction) getObjectLoader().getArticle(articleId).lock();
      }
      else {
        // we are going to create a new article
        articleTransaction = (ArticleTransaction) getObjectFactory().createArticle().lock();
      }


      try {
        // Set the form values into articleTransaction
        setElements(articleForm, articleType, articleTransaction);

        // Set some meta data into articleTransaction
        setMetaData(articleTransaction, state.toLowerCase(), articleTypeName, sectionId, publicationId.intValue());


        // set publish/activate and expire date article
        if (mappingConfiguration.get("allowSetPublishDate") != null && mappingConfiguration.get("allowSetPublishDate").equalsIgnoreCase("true")) {
          if(mLogger.isDebugEnabled()) {
            mLogger.debug("set publishDate to: " + articleForm.getDate("publishDate"));
          }

          setPublishDate(articleTransaction, articleForm);
        }


        // set activation date article
        if (mappingConfiguration.get("allowSetActivateDate") != null && mappingConfiguration.get("allowSetActivateDate").equalsIgnoreCase("true")) {
          if(mLogger.isDebugEnabled()) {
            mLogger.debug("set activateDate to: " + articleForm.getDate("activateDate"));
          }

          setActivateDate(articleTransaction, articleForm);
        }


        // set expiration date article
        if (mappingConfiguration.get("allowSetExpireDate") != null && mappingConfiguration.get("allowSetExpireDate").equalsIgnoreCase("true")) {
          if(mLogger.isDebugEnabled()) {
            mLogger.debug("set expireDate to: " + articleForm.getDate("expireDate"));
          }

          setExpireDate(articleTransaction, articleForm);
        }


        // Cleanup the section. Only homesection stays
        cleanSections(articleTransaction, sectionId);

        // Add user section to articleTransaction
        addUserSection(articleTransaction, user);

        // Add article to articleType section
        addTypeSection(articleTransaction, articleForm);

        // Add author to articleTransaction
        addRoleKeeper(articleTransaction, user.getId().intValue());

        // relate pictures to the article
        relatePictures(articleTransaction, articleForm);

        /*
          Save the article.

          In ECE < 5, this had to be done before adding the different article meta information _before_ calling ArticleTransaction#create().
          However, in ECE 5, ArticleTransaction#create _must_ be called after adding role keeper and
          can also handle all the other pieces of meta information in one transaction, hence putting update/create here.
        */
        if (articleId != null && articleId != 0) {
          articleTransaction.update();
        }
        else {
          articleTransaction.create();
        }


        if (articleId != null && articleId != 0) {
          getUserContentPlugin().recordUpdateAction(articleTransaction);

        }
        else {
          getUserContentPlugin().recordCreateAction(articleTransaction);
        }


        // Update form and release article
        articleForm.setArticleId(articleTransaction.getId());

        if (articleTransaction.isLocked()) {
          articleTransaction.release();

          getPresentationLoader().getArticlePresentationManager().drop(articleTransaction.getId());
        }


        request.setAttribute("articleObject", articleTransaction);

        // Done, Forward page
        if (successUrl == null) {
          if ((articleTransaction.getActivateDate() != null) && (articleTransaction.getActivateDate().after(new Date()))) {
            // the article is not active yet, so need to reload article to retrieve a valid token for the previewUrl
            forward = new ActionForward(IOAPI.getAPI().getObjectLoader().getArticle(articleTransaction.getId()).getPreviewUrl().replaceAll(publication.getUrl(), "/"), true);
          }
          else {
            forward = new ActionForward(articleTransaction.getUrl().replaceAll(publication.getUrl(), "/"), true);
          }
        }
        else {
          forward = getSuccessForward(successUrl, mapping, publication, true);
        }
      }
      catch (IllegalArgumentException e) {
        mLogger.error("IllegalArgumentException exception while add a article", e);
        errors.add("error", new ActionMessage("savearticle.error"));
      }
      catch (IllegalOperationException e) {
        mLogger.error("IllegalOperationException exception while add a article", e);
        errors.add("error", new ActionMessage("savearticle.error"));
      }
      catch (UserContentException e) {
        mLogger.error("UserContentException exception while add a article", e);
        errors.add("error", new ActionMessage("savearticle.error"));
      }

      // Here, there used to be a 2500 ms Thread.sleep.
      if(mLogger.isDebugEnabled()) {
        mLogger.debug("saving article="+ articleTransaction.getId() + " without sleeping");
      }
    }


    if (!errors.isEmpty()) {
      // Store the errors
      saveMessages(request, errors);
    }

    return forward;
  }

  private void relatePictures(ArticleTransaction pArticleTransaction, ArticleForm pArticleForm) {
    List<ContentSummary> contentSummaries = new ArrayList<ContentSummary>();
    for (Integer pictureId : pArticleForm.getImages()) {
      contentSummaries.add(createContentSummaryForArticle(pictureId));
    }
    pArticleTransaction.setContentSummaries(PICTURE_RELATION_TYPE_NAME, contentSummaries);
  }

  private ContentSummary createContentSummaryForArticle(final int pPictureId) {
    Article pictureArticle = IOAPI.getAPI().getObjectLoader().getArticle(pPictureId);
    ContentDescriptor contentDescriptor = mContentDescriptorFactory.createContentDescriptorForArticle(
            pictureArticle.getArticleType(), null, null);
    ContentDescriptor summaryDescriptor = contentDescriptor.getSummaryDescriptor();
    com.escenic.domain.Link contentLink = new com.escenic.domain.Link(pictureArticle.getHashKey().toURI(), com.escenic.domain.Link.EDIT_RELATION, null, "");
    ContentSummary contentSummary = new ContentSummary(summaryDescriptor, contentLink);

    for (PropertyDescriptor propertyDescriptor : summaryDescriptor) {
      String name = propertyDescriptor.getName();
      if (contentDescriptor.getPropertyDescriptor(name) != null) {
        contentSummary.setProperty(name, pictureArticle.getFieldValue(name));
      }
    }

    return contentSummary;
  }
}