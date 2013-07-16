package com.escenic.framework.util;

import java.util.List;
import java.util.ArrayList;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

import com.twelvemonkeys.lang.StringUtil;

/**
 * This class is a collection of utility methods related to HTML parsing
 * @author shamim@escenic.com
 */
public class HtmlUtil {
  private static final Pattern IMAGE_PATTERN = Pattern.compile("<img([^<]*?)/>");
  private static final Pattern TAG_PATTERN = Pattern.compile("<(.|\n)+?>");

  /**
   * This method parses the input HTML text, finds all <img/> tags in it and
   * puts the source urls of the images in a list
   * @param input the HTML string
   * @return the list of image URLs
   */
  public static List<String> parseHTML(String input) {
    List<String> urlList = new ArrayList<String>();

    if (StringUtil.isEmpty(input)) {
      return urlList;
    }

    try {
      Matcher imageMatcher = IMAGE_PATTERN.matcher(input);

      while (imageMatcher.find()) {
        String attributeGroup = imageMatcher.group(1);
        int index = attributeGroup.indexOf("src=\"");
        if (index > 0) {
          int startIndex = index + 5;
          int endIndex = attributeGroup.indexOf("\"", startIndex);

          if (endIndex > 0) {
            String url = attributeGroup.substring(startIndex, endIndex);
            urlList.add(url);
          }
        }
      }
    } catch (Exception ex) {
      System.err.println(ex);
    }

    return urlList;
  }

  /**
   * This method removes all HTML tags from the input string
   * @param value the input HTML string
   * @return the resulting string
   */
  public static String stripHtml(String value) {
    if (StringUtil.isEmpty(value)) {
      return value;
    }
    
    return TAG_PATTERN.matcher(value).replaceAll("");
  }

  /**
   * private constructor to prevent instantiation
   */
  private HtmlUtil() {
  }
}
