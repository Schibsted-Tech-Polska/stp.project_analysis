package no.medianorge.decorator;

import neo.xredsys.presentation.PresentationArticle;
import neo.xredsys.presentation.PresentationArticleDecorator;
import org.apache.log4j.Logger;

import java.util.Random;

public class PictureURLDecorator extends PresentationArticleDecorator {
    protected final Logger mLogger = Logger.getLogger(getClass());
    private String[] mPictureHosts;
    private PresentationArticle pArticle;

    public PictureURLDecorator(PresentationArticle pPresentationArticle, String[] pPictureHosts) {
        super(pPresentationArticle);
        pArticle = pPresentationArticle;
        mPictureHosts = pPictureHosts;
    }

    public String getUrl() {
        String originalUrl = super.getUrl();
        if (mLogger.isDebugEnabled()) {
            mLogger.debug("Original picture url = " + originalUrl);
        }
        if (mLogger.isDebugEnabled()) {
            mLogger.debug("The following media url hosts are configured: ");
            for (String host:mPictureHosts) {
                mLogger.debug(host);
            }
        }
        int serverNumber = Math.abs(originalUrl.hashCode() % mPictureHosts.length);
        int slashslash = originalUrl.indexOf("//") + 2;
        int slash = originalUrl.indexOf('/', slashslash);
        String imageUrl = originalUrl.substring(0,slashslash) + mPictureHosts[serverNumber] + originalUrl.substring(slash);
        if (mLogger.isDebugEnabled()) {
            mLogger.debug("New picture url = " + imageUrl);
        }
        return imageUrl;
    }
}
