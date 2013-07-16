package com.escenic.framework.community.struts.actions;

import com.escenic.domain.Link;
import com.escenic.domain.ContentDescriptor;
import com.escenic.domain.ContentSummary;
import com.escenic.domain.PropertyDescriptor;
import com.escenic.storage.Storage;

import com.ndc.community.api.domain.User;
import com.ndc.escenic.util.EscenicObjects;
import com.ndc.usercontent.api.UserContentPluginProperties;
import com.ndc.usercontent.struts.actions.forms.UploadForm;
import com.ndc.usercontent.struts.actions.upload.MediaContentUpload;

import neo.nursery.BusException;
import neo.nursery.GlobalBus;
import neo.util.MimeTypes;
import neo.xredsys.api.*;
import neo.xredsys.content.type.*;
import neo.xredsys.content.type.LinkImpl;
import neo.xredsys.content.type.Type;
import neo.xredsys.content.type.TypeManager;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.*;
import org.apache.struts.upload.FormFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.util.*;

public class ProfilePictureUpload extends MediaContentUpload {

  private static final String EDIT_MEDIA = "com.escenic.edit-media";
  private static final String COMPONENT_PATH_TYPEMANAGER = "/neo/io/managers/TypeManager";
  private static final String COMPONENT_PATH_STORAGE = "/com/escenic/storage/Storage";
  private static final String COMPONENT_PATH_CONTENT_DESCRIPTOR_FACTORY = "/neo/io/content/ContentDescriptorFactory";
  private static final String RELATION_TYPE_NAME = "PROFILEPICTURES";

  private TypeManager mTypeManager;
  private Storage mStorage;
  private ObjectLoader mObjectLoader;
  private ContentDescriptorFactory mContentDescriptorFactory;

  public ProfilePictureUpload() {
    try {
      mTypeManager = (TypeManager)
          GlobalBus.getGlobalBus().lookupSafe(COMPONENT_PATH_TYPEMANAGER);
      mStorage = (Storage) GlobalBus.getGlobalBus()
          .lookupSafe(COMPONENT_PATH_STORAGE);
      mContentDescriptorFactory =
          (ContentDescriptorFactory) GlobalBus.lookupSafe(COMPONENT_PATH_CONTENT_DESCRIPTOR_FACTORY);
      mObjectLoader = IOAPI.getAPI().getObjectLoader();
    } catch (BusException e) {
      mLogger.error("Globals loading failed!", e);
    }
  }

  public ActionForward execute(final ActionMapping mapping,
                               final ActionForm form,
                               final HttpServletRequest request,
                               final HttpServletResponse response) throws Exception {
    final UploadForm uploadForm = (UploadForm) form;
    final ActionErrors errors = new ActionErrors();
    // check the forwards
    final String successUrl = uploadForm.getSuccessUrl();
    checkSuccessForward(successUrl, mapping);
    final String errorUrl = uploadForm.getErrorUrl();
    checkErrorForward(errorUrl, mapping);

    // check whether article type is specified
    final String articleTypeName = getArticleTypeName(mapping, uploadForm);
    // check the publicationId
    final Publication publication = getPublication(request, uploadForm);
    // check logged in user
    final User user = getUser(request);
    if (user == null) {
      throw new IllegalArgumentException("No loggedin user found");
    }

    // Set the default forward
    ActionForward forward = getErrorForward(errorUrl, mapping, publication, false);
    final ArticleType articleContentType = mTypeManager
        .getArticleType(publication.getId(), articleTypeName);
    if (articleContentType == null) {
      throw new IllegalArgumentException("Article type '"
          + articleTypeName + "' not found for publication ID");
    }

    String fileName = "", mimeType = "", linkFieldName = "";
    final FormFile file = uploadForm.getFile();
    if (file == null) {
      errors.add("error", new ActionMessage("upload.error"));
    } else {
      // check file size
      if (file.getFileSize() > UserContentPluginProperties.getMaxFileUploadSize((long) publication.getId(), articleTypeName)) {
        errors.add("error", new ActionMessage("upload.error.filesize"));
      }
      // check mime type
      fileName = file.getFileName();
      String extension = fileName.substring(
          fileName.lastIndexOf(".") + 1,
          fileName.length()
      ).toLowerCase();
      mimeType = MimeTypes.getMimeType(extension);
      linkFieldName = getLinkFieldAndCheckMime(articleContentType, mimeType, errors);
    }

    // -- checking is done --
    // now create media content
    if (errors.isEmpty()) {
      try {
        ArticleTransaction articleTransaction = createArticle(
            fileName, articleTypeName,
            uploadForm, user, publication
        );
        addLinkField(articleTransaction, linkFieldName, uploadForm, mimeType);

        articleTransaction.update();
        if (articleTransaction.isLocked()) {
          articleTransaction.release();
        }

        getStatisticsPlugin().registerCreateAction(
            (long) publication.getId(),
            user.getId(),
            (long) articleTransaction.getId(),
            (long) articleTransaction.getHomeSectionId(),
            articleTypeName,
            user.getId()
        );

        if (successUrl == null) {
          if ((articleTransaction.getActivateDate() != null)
              && (articleTransaction.getActivateDate().after(new Date()))) {
            // need to reload article to retrieve a valid token for the previewUrl
            forward = new ActionForward(mObjectLoader.getArticle(articleTransaction.getId()).getPreviewUrl().replaceAll(publication.getUrl(), "/"), true);
          } else {
            forward = new ActionForward(articleTransaction.getUrl().replaceAll(publication.getUrl(), "/"), true);
          }
        } else {
          forward = getSuccessForward(successUrl, mapping, publication, true);
        }

        // relate the picture with user profile
        relatePictureWithUserProfile(articleTransaction.getId(), user.getProfileArticleId().intValue());
      } catch (Exception e) {
        mLogger.error(e);
        errors.add("error", new ActionMessage("upload.error"));
      }
    } else {
      // Store the errors
      saveMessages(request, errors);
    }

    return forward;

  }

  private Publication getPublication(final HttpServletRequest pRequest,
                                     final UploadForm pUploadForm) {
    Long publicationId = pUploadForm.getPublicationId() != null ?
        pUploadForm.getPublicationId().longValue() :
        EscenicObjects.getPublicationId(pRequest);
    if (publicationId == null) {
      throw new IllegalArgumentException("form.publicationId is null");
    }
    final Publication publication = getObjectLoader()
        .getPublicationById(publicationId.intValue());
    if (publication == null) {
      throw new IllegalArgumentException("publication is null");
    }

    return publication;
  }

  private String getArticleTypeName(final ActionMapping pMapping,
                                    final UploadForm pUploadForm) {
    Map<String, String> mappingConfiguration = getMappingConfiguration(pMapping);
    String articleTypeName = mappingConfiguration.get("articleType");
    if (StringUtils.isEmpty(articleTypeName)) {
      articleTypeName = pUploadForm.getArticleType();
    }
    if (StringUtils.isEmpty(articleTypeName)) {
      throw new IllegalArgumentException("articleType name is null");
    }

    return articleTypeName;
  }

  private String getLinkFieldAndCheckMime(final ArticleType pArticleContentType,
                                          final String pMimeType,
                                          final ActionErrors pErrors) {
    for (Field field : pArticleContentType.getFields()) {
      if (field.getType().getType() == Type.LINK) {
        LinkImpl linkField = (LinkImpl) field.getType();
        if (linkField.getAllowedMimeTypes().contains(pMimeType)) {
          return field.getName();
        } else {
          pErrors.add("error", new ActionMessage("upload.error.filenotsupported"));
          return null;
        }
      }
    }

    pErrors.add("error", new ActionMessage("upload.error.filenotsupported"));
    return null;
  }

  private void addLinkField(final ArticleTransaction pATransaction,
                            final String pLinkField,
                            final UploadForm pUploadForm,
                            final String pMimeType) throws BusException, IOException {
    String filename = pUploadForm.getFile().getFileName();
    List<Storage.Header> headers = new ArrayList<Storage.Header>();
    headers.add(new Storage.Header(Storage.FILE_NAME, filename));
    headers.add(new Storage.Header(Storage.MIME_TYPE, pMimeType));

    InputStream dataStream = pUploadForm.getFile().getInputStream();
    URI internalURI = mStorage.create(dataStream, headers);
    Link link = new Link(internalURI, EDIT_MEDIA, pMimeType, filename);
    pATransaction.setFieldValue(pLinkField, link);
  }

  private void relatePictureWithUserProfile(final int pPictureId, final int pProfileArticleId) throws Exception {
    if (mLogger.isDebugEnabled()) {
      mLogger.debug("Relating picture with id " + pPictureId + " to user profile article with id " + pProfileArticleId);
    }

    ArticleTransaction articleTransaction = null;

    try {
      Article pictureArticle = IOAPI.getAPI().getObjectLoader().getArticle(pPictureId);
      ContentDescriptor contentDescriptor = mContentDescriptorFactory.createContentDescriptorForArticle(
          pictureArticle.getArticleType(), null, null);
      ContentDescriptor summaryDescriptor = contentDescriptor.getSummaryDescriptor();
      Link contentLink = new Link(pictureArticle.getHashKey().toURI(), Link.EDIT_RELATION, null, "");
      ContentSummary contentSummary = new ContentSummary(summaryDescriptor, contentLink);

      for (PropertyDescriptor propertyDescriptor : summaryDescriptor) {
        String name = propertyDescriptor.getName();
        if (contentDescriptor.getPropertyDescriptor(name) != null) {
          contentSummary.setProperty(name, pictureArticle.getFieldValue(name));
        }
      }

      articleTransaction = (ArticleTransaction) IOAPI.getAPI().getObjectLoader().getArticle(pProfileArticleId).lock();
      List<ContentSummary> summaryList = articleTransaction.getContentSummaries(RELATION_TYPE_NAME);

      if (summaryList == null || summaryList.size() == 0) {
        articleTransaction.addContentSummary(RELATION_TYPE_NAME, contentSummary);
      } else {
        List<ContentSummary> updatedSummaryList = new ArrayList<ContentSummary>();
        updatedSummaryList.add(contentSummary);

        for (ContentSummary summary : summaryList) {
          updatedSummaryList.add(summary);
        }

        articleTransaction.setContentSummaries(RELATION_TYPE_NAME, updatedSummaryList);
      }

      articleTransaction.update();
    } finally {
      releaseArticleTransaction(articleTransaction);
    }
  }

  /**
   * This method is supposed to be called ONLY from a finally block
   *
   * @param pArticleTransaction article transaction
   */
  private void releaseArticleTransaction(final ArticleTransaction pArticleTransaction) {
    if (pArticleTransaction == null) {
      return;
    }

    try {
      if (pArticleTransaction.isLocked()) {
        pArticleTransaction.release();
      }
    } catch (Exception ex) {
      mLogger.error("Error while releasing transaction", ex);
    }
  }
}
