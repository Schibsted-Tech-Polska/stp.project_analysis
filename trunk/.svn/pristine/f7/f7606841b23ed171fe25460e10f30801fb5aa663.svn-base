package no.medianorge.xsl;

import neo.xredsys.api.*;
import neo.xredsys.api.Pool;
import no.medianorge.util.UrlDecorator;
import org.apache.log4j.Logger;

import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Utility used in import xsl.
 * <p/>
 * Date: 02.09.11
 * Time: 09.03
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class ArticleUtils {
    private static final Logger log = Logger.getLogger(ArticleUtils.class);

    /**
     * Checks if a given source already exists in Escenic publication.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String sourceExists(String source, String sourceId, int publicationId) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article = null;
        try {
            article = ol.getArticle(source, sourceId, publicationId);
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
        }
        if (article != null) {
            if (log.isDebugEnabled()) {
                log.debug("sourceExists source:" + source + ",sourceId:" + sourceId + ",publicationId:" + publicationId + " exists");
            }
            return "yes";
        } else {
            return "no";
        }
    }

    public static String isObjectInPool(String source, String sourceId, int publicationId, String poolName) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article;
        try {
            article = ol.getArticle(source, sourceId, publicationId);
            Pool[] pools = article.getPools();
            for (Pool pool : pools) {
                if (poolName.equalsIgnoreCase(pool.getName())) {
                    return "yes";
                }
            }
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
        }
        return "no";
    }

    /**
     * Gets the article state
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getArticleState(String source, String sourceId, int publicationId) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article = null;
        try {
            article = ol.getArticle(source, sourceId, publicationId);
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
        }
        if (article != null) {
            if (log.isDebugEnabled()) {
                log.debug("getState source:" + source + ",sourceId:" + sourceId + ",publicationId:" + publicationId + " exists, state: " + article.getState().getName());
            }
            return article.getState().getName();

        } else {
            return "missing";
        }
    }

    /**
     * Gets the next version by checking latest revision.
     * The method finds the next version nr to be used by checking the article against
     * the system state ie. "submitted". Next version is the sourceid+"-versionnumber"
     * The method finds the highest number in the given checkState.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @param poolName
     * @param state
     * @return
     */
    public static String getLatestVersionNotInPool(String source, String sourceId, int publicationId, String poolName, String state) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article = null;
        int loopVar = 0;
        try {
            boolean doLoop = true;
            do {
                String sourceIdVersion = (loopVar > 0 ? "-" + loopVar : "");
                if ((article = ol.getArticle(source, sourceId + sourceIdVersion, publicationId)) != null) {
                    String stateVal = article.getState().getName();
                    Pool[] pools = article.getPools();
                    boolean inPool = false;
                    for (Pool pool : pools) {
                        if (poolName.equalsIgnoreCase(pool.getName())) {
                            inPool = true;
                        }
                    }
                    // if article is not in the pool
                    if (!inPool && state.equals(stateVal)) {
                        return Integer.toString(loopVar);
                    }
                    loopVar++;
                    // Security break
                    if (loopVar > 100) {
                        break;
                    }
                } else {
                    return Integer.toString(loopVar);
                }
            } while (doLoop);
            return Integer.toString(loopVar);
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
            return Integer.toString(loopVar);
        }
        if (article != null) {
            if (log.isDebugEnabled()) {
                log.debug("getLatestVersionNotInPool source:" + source + ",sourceId:" + sourceId + ",publicationId:" + publicationId + ",loopVar: " + loopVar);
            }
            return Integer.toString(loopVar);
        } else {
            return Integer.toString(loopVar);
        }
    }


    /**
     * Gets the next version by checking latest revision.
     * The method finds the next version nr to be used by checking the article against
     * the system state ie. "submitted". Next version is the sourceid+"-versionnumber"
     * The method finds the highest number in the given checkState.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getNextVersion(String source, String sourceId, int publicationId, String checkState) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article = null;
        int loopVar = 0;
        try {
            boolean doLoop = true;
            do {
                String sourceIdVersion = (loopVar > 0 ? "-" + loopVar : "");
                if ((article = ol.getArticle(source, sourceId + sourceIdVersion, publicationId)) != null) {
                    String state = article.getState().getName();
                    if (checkState.equalsIgnoreCase(state)) {
                        return Integer.toString(loopVar);
                    }
                    loopVar++;
                    // Security break
                    if (loopVar > 100) {
                        break;
                    }
                } else {
                    return Integer.toString(loopVar);
                }
            } while (doLoop);
            return Integer.toString(loopVar);
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
            return Integer.toString(loopVar);
        }
        if (article != null) {
            if (log.isDebugEnabled()) {
                log.debug("getNextVersion source:" + source + ",sourceId:" + sourceId + ",publicationId:" + publicationId + " exists, state: " + article.getState().getName());
            }
            return Integer.toString(loopVar);
        } else {
            return Integer.toString(loopVar);
        }
    }

    /**
     * Gets the next version by checking latest revision.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getNextVersion(String source, String sourceId, int publicationId) {
        ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
        Article article = null;
        int loopVar = 0;
        try {
            boolean doLoop = true;
            do {
                String sourceIdVersion = (loopVar > 0 ? "-" + loopVar : "");
                if ((article = ol.getArticle(source, sourceId + sourceIdVersion, publicationId)) != null) {
                    loopVar++;
                    // Security break
                    if (loopVar > 100) {
                        break;
                    }
                }
            } while (doLoop);
            return Integer.toString(loopVar);
        } catch (PersistentStoreException e) { // Just eat exceptions
            log.debug("PersistentStoreException: ", e);
        } catch (NoSuchObjectException e) { // Just eat exceptions
            log.debug("NoSuchObjectException: ", e);
            return Integer.toString(loopVar);
        }
        if (article != null) {
            if (log.isDebugEnabled()) {
                log.debug("getNextVersion source:" + source + ",sourceId:" + sourceId + ",publicationId:" + publicationId);
            }
            return Integer.toString(loopVar);
        } else {
            return Integer.toString(loopVar);
        }
    }

    /**
     * Gets a pretty url
     *
     * @param mTitle
     * @param url
     * @param articleId
     * @return
     */
    public String getPrettyUrl(String mTitle, String url) {
        String var = null;
        try {
            String titleInstance = UrlDecorator.getPrettyTitle(mTitle);

            if (titleInstance.length() > 0) {
                String articleId = url;
                int i = articleId.indexOf("/article");
                if (i != -1) {
                    articleId = articleId.substring(i + "/article".length());
                } else {
                    return url;
                }
                String id = articleId.substring(0, articleId.length() - 4);
                var = url.replaceAll("article", "")
                        .replaceAll(".ece", "")
                        .replaceAll("" + id, "")
                        + titleInstance + "-" + id + ".html";
            }
        } catch (Exception e) {
            return url;
        }
        return var.replaceAll("[\n\r ]", "");
    }


    /**
     * Generates a UIID.
     *
     * @return a UUID
     */
    public static String generateUUID() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }

    /**
     * Method just for testing the method implementation in the xsl.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String trace(String source, int sourceId, int publicationId) {
        log.info("source:" + source + ", sourceId:" + sourceId + ", publicationId:" + publicationId);
        return "yes";
    }

    public static void main(String[] args) {
        System.out.println(generateUUID());

        String articleId = "http://sprek.aftenposten.no/sprek/article11860.ece";
        int i = articleId.indexOf("/article");
        if (i != -1) {
            articleId = articleId.substring(i + "/article".length());
        } else {

        }
        String id = articleId.substring(0, articleId.length() - 4);
    }
}
