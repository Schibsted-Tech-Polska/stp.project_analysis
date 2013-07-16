package com.escenic.processor;

import neo.xredsys.presentation.PresentationArticleDecorator;
import neo.xredsys.presentation.PresentationArticle;

import no.medianorge.util.UrlDecorator;
import org.apache.log4j.Logger;
import java.io.UnsupportedEncodingException;

/**
 * Created by IntelliJ IDEA.
 * User: torillkj
 * Date: 11.nov.2010
 * Time: 12:16:14
 *
 * Changed by Geir A.
 *
 */
public class TitleURLArticleDecorator extends PresentationArticleDecorator {
    private final Logger mLogger = Logger.getLogger(getClass());
    private String mTitle;

    public TitleURLArticleDecorator(PresentationArticle pPresentationArticle) {
        super(pPresentationArticle);
    }

    /**
     * This overriden method will return the url of the article with title in
     * it.
     *
     * @return The modified URL which contains the title of the article in it
     *         plus spaces substituted with <b>"_"</b> and <b>"ece"</b>
     *         extension is substituted with <b>"html"</b>.
     * @see neo.xredsys.presentation.PresentationArticleDecorator#getUrl()
     */
    public String getUrl() {
        if (mTitle == null) {
            try {
                    // If link is defined, - use THIS.
                    String myLink = super.getFieldElement("link");
                    if (!myLink.equals("")){
                        mTitle = myLink;
                    } else {
                        // Create a pretty url.
                        String prettyTitle = UrlDecorator.getPrettyTitle(getTitle());
                        if (prettyTitle.length() > 0) {
                            mTitle = super.getUrl().replaceAll("article", "")
                                    .replaceAll(".ece", "")
                                    .replaceAll("" + super.getArticleId(), "")
                                    + prettyTitle + "-" + super.getArticleId() + ".html";
                        }
                    }
            } catch (UnsupportedEncodingException e) {
                mLogger.error("Error while encoding url. Turn on debug for more information. Exception: "
                        + e, e);
                return super.getUrl(); // To change body of overridden methods
            }
        }
        return mTitle;
    }

}

