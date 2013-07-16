package com.escenic.framework.pingback;




import neo.xredsys.api.ObjectLoader;
import neo.xredsys.api.IOAPI;
import neo.xredsys.api.Article;
import neo.xredsys.api.ArticleTransaction;
import neo.xredsys.api.Type;
import neo.xredsys.api.IOHashKey;
import neo.xredsys.api.Publication;
import neo.xredsys.api.Section;
import neo.xredsys.content.type.ContentDescriptorFactory;

import neo.nursery.GlobalBus;

import java.net.URI;
import java.net.URL;
import java.util.List;

import com.escenic.domain.ContentSummary;
import com.escenic.domain.ContentDescriptor;
import com.escenic.domain.MIMEType;
import com.escenic.domain.Link;


public class PingbackWebservice {
  public String ping(String sourceURI, String targetURI) {
    try {

      System.out.println("sourceURI: " + sourceURI + " targetURI: " + targetURI);

      ObjectLoader loader = IOAPI.getAPI().getObjectLoader();

      // Find the publication name from the url
      URL url = new URL(targetURI);
      String path = url.getPath();
      System.out.println(path);
      String pubName = path.split("/")[1];
      Publication publication = loader.getPublication(pubName);
      Section section = loader.getSectionByUniqueName(publication.getId(), "pingback");

      // Find the article in Escenic
      String articleIdString = targetURI.substring(targetURI.indexOf("article")+7, targetURI.indexOf(".ece"));
      int articleId = Integer.parseInt(articleIdString);
      Article article = loader.getArticle(articleId);

      // Check that the article has the url given

      System.out.println("Article url: " + article.getUrl());

      if (!article.getUrl().equals(targetURI)) return "No article with url" + targetURI;

      List<ContentSummary> linkSummaries = article.getContentSummaries("PINGBACKREL");

      System.out.println(linkSummaries);

      for (ContentSummary linkSummary: linkSummaries) {
        Article relatedLink = loader.getArticle(IOHashKey.valueOf(linkSummary.getContentLink().getHref()).getObjectId());
        if (relatedLink.getFieldValue("URL").toString().equals(sourceURI)) return "Article already exists in pingback list";
      }

      // Create new Hyperlink

      Article link = IOAPI.getAPI().getObjectFactory().createArticle();
      ArticleTransaction lt = (ArticleTransaction) link.lock();
      Type state = IOAPI.getAPI().getTypeManager().getType(Type.ArticleStateType, "published");
      Type type = IOAPI.getAPI().getTypeManager().getType(Type.ArticleType, "link");
      lt.setState(state);
      lt.setType(type);
      if (section != null) {
        lt.setHomeSectionId(section.getId());
      } else {
        lt.setOwnerPublicationId(publication.getId());
      }
      lt.setTitle(sourceURI);
      lt.setFieldValue("url", new URI(sourceURI));
      lt.create();
      if (lt.isLocked()) {
        lt.release();
      }

      // Relate to article
      ArticleTransaction at = (ArticleTransaction) article.lock();
      URI linkURI = lt.getHashKey().toURI();
      ContentDescriptorFactory factory = (ContentDescriptorFactory) GlobalBus.lookupSafe("/neo/io/content/ContentDescriptorFactory");
      ContentDescriptor contentDescriptor = factory.createContentDescriptorForArticle(lt.getArticleType(), null, null);
      ContentDescriptor descriptor = contentDescriptor.getSummaryDescriptor();
      Link contentLink = new Link(linkURI, Link.EDIT_RELATION, MIMEType.getMIMEforContentType(descriptor.getContentType()), "");
      ContentSummary mContentSummary = new ContentSummary(descriptor, contentLink);
      mContentSummary.setProperty("TITLE", sourceURI);
      at.addContentSummary("PINGBACKREL", mContentSummary);
      at.update();
      if (at.isLocked()) {
        at.release();
      }

    } catch (Exception e) {
      e.printStackTrace();
    }

    return "success";
  }
}
