package no.medianorge.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Date: 24.11.11
 * Time: 15.18
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public  class UrlDecorator {
    public static String getPrettyTitle(String sourceString) throws UnsupportedEncodingException {
        String titleInstance = URLEncoder.encode(sourceString, "UTF-8");
        titleInstance = titleInstance.replaceAll(",", "_");
        titleInstance = titleInstance.replaceAll("[+]", "-");
        titleInstance = titleInstance.replaceAll("%21", "");
        titleInstance = titleInstance.replaceAll("%2C", "_");
        titleInstance = titleInstance.replaceAll("%22", "");
        titleInstance = titleInstance.replaceAll("%3A", "");
        titleInstance = titleInstance.replaceAll("%3F", "");
        titleInstance = titleInstance.replaceAll("%C3%A6", "a"); //æ
        titleInstance = titleInstance.replaceAll("%C3%B8", "o"); //ø
        titleInstance = titleInstance.replaceAll("%C3%A5", "a"); //å
        titleInstance = titleInstance.replaceAll("%C3%86", "A"); //Æ
        titleInstance = titleInstance.replaceAll("%C3%98", "O"); //Ø
        titleInstance = titleInstance.replaceAll("%C3%85", "A"); //Å
        titleInstance = titleInstance.replaceAll("%26laquo%3B", "«").trim();
        titleInstance = titleInstance.replaceAll("%26raquo%3B", "»").trim();
        titleInstance = titleInstance.replaceAll("%E2%80%A8", "").trim();//from error log
        titleInstance = titleInstance.replaceAll("%3Cbr%3E", "-").trim();//<br> tag
        titleInstance = titleInstance.replaceAll("%26ndash%3B", "-").trim();
        titleInstance = titleInstance.replaceAll("%2F", "/").trim();
        titleInstance = titleInstance.replaceAll("%0", "").trim();//line shift
        titleInstance = URLDecoder.decode(titleInstance, "utf-8");
        String newTitle = "";
        Pattern p = Pattern.compile("[a-zA-z0-9_-]");
        Matcher m = p.matcher(titleInstance);
        while (m.find()) {
            char c = titleInstance.charAt(m.end() - 1);
            newTitle += c;
        }
        return newTitle;
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
        String titleInstance = URLEncoder.encode("Dette er æøåÆØÅ", "UTF-8");
        System.out.println(titleInstance);
        System.out.println(URLDecoder.decode(titleInstance, "UTF-8"));
        String newTitle = URLEncoder.encode(titleInstance, "UTF-8");
        System.out.println(newTitle);
        String x = URLDecoder.decode(newTitle, "UTF-8");
        System.out.println(x);
        System.out.println(URLDecoder.decode(x, "UTF-8"));
    }
}
