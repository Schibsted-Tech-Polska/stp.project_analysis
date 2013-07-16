package no.medianorge.xsl;

import org.apache.log4j.Logger;

import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Utility used in import xsl.
 *
 * Date: 02.09.11
 * Time: 09.03
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class ArticleUtilsTest {
    private static final Logger log = Logger.getLogger(ArticleUtilsTest.class);

    /**
     * Checks if a given source already exists in Escenic publication.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String sourceExists(String source, String sourceId, int publicationId){
        return "yes";
    }

    /**
     *  Gets the article state
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getArticleState(String source, String sourceId, int publicationId){
            return "submitted";
    }

    public static String isObjectInPool(String source, String sourceId, int publicationId, String poolName){
        return "yes";
    }


    /**
     *  Gets the next version by checking latest revision.
     *  The method finds the next version nr to be used by checking the article against
     *  the system state ie. "submitted". Next version is the sourceid+"-versionnumber"
     *  The method finds the highest number in the given checkState.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getNextVersion(String source, String sourceId, int publicationId, String checkState){
        return "0";
    }

    public static String getLatestVersionNotInPool(String source, String sourceId, int publicationId, String poolName, String state){
        return "0";
    }

    /**
     *  Gets the next version by checking latest revision.
     *
     * @param source
     * @param sourceId
     * @param publicationId
     * @return
     */
    public static String getNextVersion(String source, String sourceId, int publicationId){
        return "0";
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
        String var=null;
        if (var == null) {
            try {
                    String titleInstance = mTitle;

                    if (titleInstance.length() > 0) {
                        titleInstance = titleInstance.replaceAll(" ", "-");
                        titleInstance = titleInstance.replaceAll("æ", "ae");
                        titleInstance = titleInstance.replaceAll("ø", "oe");
                        titleInstance = titleInstance.replaceAll("å", "aa");
                        titleInstance = titleInstance.replaceAll("Æ", "AE");
                        titleInstance = titleInstance.replaceAll("Ø", "OE");
                        titleInstance = titleInstance.replaceAll("Å", "AA");

                        titleInstance = titleInstance.replaceAll("[+]", "-");
                        titleInstance = titleInstance.replaceAll("%21", "");
                        titleInstance = titleInstance.replaceAll("%22", "");
                        titleInstance = titleInstance.replaceAll("%3A", "");
                        titleInstance = titleInstance.replaceAll("%3F", "");
                        titleInstance = titleInstance.replaceAll("%C3%A6", "ae");
                        titleInstance = titleInstance.replaceAll("%C3%B8", "oe");
                        titleInstance = titleInstance.replaceAll("%C3%A5", "aa");
                        titleInstance = titleInstance.replaceAll("%C3%86", "AE");
                        titleInstance = titleInstance.replaceAll("%C3%98", "OE");
                        titleInstance = titleInstance.replaceAll("%C3%85", "AA");
                        titleInstance = titleInstance.replaceAll("%26laquo%3B", "«").trim();
                        titleInstance = titleInstance.replaceAll("%26raquo%3B", "»").trim();
                        titleInstance = titleInstance.replaceAll("%E2%80%A8", "").trim();//from error log
                        titleInstance = titleInstance.replaceAll("%3Cbr%3E", "-").trim();//<br> tag
                        /*titleInstance = titleInstance.replaceAll("%3Cbr%2F%3E", "-").trim();//<br/> tag */
                        titleInstance = titleInstance.replaceAll("%26ndash%3B", "-").trim();
                        titleInstance = titleInstance.replaceAll("%2F", "/").trim();
                        titleInstance = titleInstance.replaceAll("%0", "").trim();//line shift

                        String newTitle = "";
                        Pattern p = Pattern.compile("[a-zA-z0-9_-]");
                        Matcher m = p.matcher(titleInstance);
                        while (m.find()) {
                            int textEnd = m.end() - 1;
                            char c = titleInstance.charAt(m.end() - 1);
                            newTitle += c;
                        }

                        String articleId = url;
                        int i = articleId.indexOf("/article");
                        if(i != -1){
                            articleId = articleId.substring(i+"/article".length());
                        } else {
                            return url;
                        }

                        String id= articleId.substring(0,articleId.length()-4);

                        var = url.replaceAll("article", "")
                                .replaceAll(".ece", "")
                                .replaceAll("" + id, "")
                                + newTitle + "-" + id + ".html";
                    }
            } catch (Exception e) {
                return url;
            }
        }

        return var.trim().replaceAll("[\n\r ]", "");
    }


    /**
     * Generates a UIID.
     *
     * @return a UUID
     */
    public static String generateUUID(){
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
    public static String trace(String source, int sourceId, int publicationId){
        log.info("source:"+source+", sourceId:"+sourceId+", publicationId:"+publicationId);
        return "yes";
    }

    public static void main(String[] args) {
        System.out.println(generateUUID());

        String articleId = "http://sprek.aftenposten.no/sprek/article11860.ece";
        int i = articleId.indexOf("/article");
        if(i != -1){
            articleId = articleId.substring(i+"/article".length());
        } else {

        }
        String id= articleId.substring(0,articleId.length()-4);
    }
}
