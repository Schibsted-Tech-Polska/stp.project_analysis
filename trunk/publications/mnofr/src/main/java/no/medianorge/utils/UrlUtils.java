package no.medianorge.utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Static methods included in the mno-utils.tld.
 *
 * Date: 10.05.11
 * Time: 15.38
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class UrlUtils {


    /**
     * Replaces the domain in the url when the origURI differs from the replaceURI.
     *
     * @param request
     * @param url
     * @param origURI ie. http://www.aftenposten.no
     * @param replaceURI ie. http://bil.bt.no
     * @return
     */
    public static String replaceDomain(HttpServletRequest request, String url, String origURI, String replaceURI) {
        Integer replaceStatus;
        /**
         * This mechanism is for effiency avoiding uneeded processing..
         */
        if ((replaceStatus = (Integer) request.getAttribute("skip_rewrite")) != null && replaceStatus == 0) {
            return url;
        } else if (replaceStatus == null && origURI.equalsIgnoreCase(replaceURI)) {
            // URI is equal and just return
            request.setAttribute("skip_rewrite", 0);
            return url;
        } else if (replaceStatus == null) {
            // Initially setting the status if the URI's are unequal
            request.setAttribute("skip_rewrite", 1);
        }
        // Perform substitution
        return url.replaceAll(origURI, replaceURI);
    }

    /**
     * Intializer used for caching purposes
     *
     * @param request
     * @param origURI
     * @param replaceURI
     */
    public static void init(HttpServletRequest request, String origURI, String replaceURI) {
        Integer replaceStatus;
        if ((replaceStatus = (Integer) request.getAttribute("skip_rewrite")) == null) {
            if (origURI.equalsIgnoreCase(replaceURI)) {
                request.setAttribute("skip_rewrite", 0);
            } else {
                request.setAttribute("skip_rewrite", 1);
            }
        }
    }

    public static String createPrettyTitle(String titleInstance, int articleId) {
        if (titleInstance.length() > 0) {
            titleInstance = titleInstance.replaceAll("[+]", "-");
            titleInstance = titleInstance.replaceAll("%21", "");
            titleInstance = titleInstance.replaceAll("%22", "");
            titleInstance = titleInstance.replaceAll("%3A", "");
            titleInstance = titleInstance.replaceAll("%3F", "");
            titleInstance = titleInstance.replaceAll("%C3%A6", "ae");
            titleInstance = titleInstance.replaceAll("�", "ae");
            titleInstance = titleInstance.replaceAll("%C3%B8", "oe");
            titleInstance = titleInstance.replaceAll("%C3%A5", "aa");
            titleInstance = titleInstance.replaceAll("�", "aa");
            titleInstance = titleInstance.replaceAll("%C3%86", "AE");
            titleInstance = titleInstance.replaceAll("�", "AE");
            titleInstance = titleInstance.replaceAll("%C3%98", "OE");
            titleInstance = titleInstance.replaceAll("�", "OE");
            titleInstance = titleInstance.replaceAll("%C3%85", "AA");
            titleInstance = titleInstance.replaceAll("�", "AA");
            titleInstance = titleInstance.replaceAll("%26laquo%3B", "�").trim();
            titleInstance = titleInstance.replaceAll("%26raquo%3B", "�").trim();
            titleInstance = titleInstance.replaceAll("%E2%80%A8", "").trim();//from error log
            titleInstance = titleInstance.replaceAll("%3Cbr%3E", "-").trim();//<br> tag
            /*titleInstance = titleInstance.replaceAll("%3Cbr%2F%3E", "-").trim();//<br/> tag */
            titleInstance = titleInstance.replaceAll("%26ndash%3B", "-").trim();
            titleInstance = titleInstance.replaceAll("-", "-").trim();
            titleInstance = titleInstance.replaceAll("%2F", "/").trim();
            titleInstance = titleInstance.replaceAll("%0", "").trim();//line shift
            titleInstance = titleInstance.replaceAll(" ", "-");

            String newTitle = "";
            Pattern p = Pattern.compile("[a-zA-z0-9_-]");
            Matcher m = p.matcher(titleInstance);
            while (m.find()) {
                int textEnd = m.end() - 1;
                char c = titleInstance.charAt(m.end() - 1);
                newTitle += c;
            }

            return titleInstance.replaceAll("article", "")
                    .replaceAll(".ece", "")
                    .replaceAll("" + articleId, "") + "-" + articleId + ".html";
        } else {
            return null;
        }
    }

    public static String replaceMediaDomain(String originalUrl) {
        if (System.getProperty("media.hash.hosts") != null) {
            String[] mediaHosts = StringUtils.split(System.getProperty("media.hash.hosts"),",");
            int serverNumber = Math.abs(originalUrl.hashCode() % mediaHosts.length);
            int slashslash = originalUrl.indexOf("//") + 2;
            int slash = originalUrl.indexOf('/', slashslash);
            String mediaUrl = originalUrl.substring(0,slashslash) + mediaHosts[serverNumber] + originalUrl.substring(slash);
            return mediaUrl;
        } else {
            return originalUrl;
        }
    }

    /**
     * Encode an url
     *
     * @param url to encode
     * @param encoding the encoding ie. ISO-8859-1
     * @return the encoded url
     * @throws UnsupportedEncodingException
     */
    public static String encodeUrl(String url, String encoding) throws UnsupportedEncodingException {
        return URLEncoder.encode((String) url, encoding);
    }

    /**
     * Base64 encodes a string.
     *
     * @param string to encode
     * @return a encoded string
     */
    public static String base64encode(String string){
        byte[] encoded = Base64.encodeBase64(string.getBytes());
        return new String(encoded);
    }

    /**
     * Base64 decoce a string.
     *
     * @param string to decode
     * @return a decoded string
     */
    public static String base64decode(String encoded){
        byte[] decoded = Base64.decodeBase64(encoded.getBytes());
        return new String(decoded);
    }
}
