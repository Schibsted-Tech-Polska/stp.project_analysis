package com.escenic.framework.servlet.esi;

import com.escenic.presentation.servlet.GenericProcessor;
import com.escenic.servlet.Constants;
import neo.xredsys.presentation.PresentationArticle;
import neo.xredsys.presentation.PresentationLoader;
import neo.xredsys.presentation.PresentationProperty;
import neo.xredsys.presentation.ServletContextConstants;
import org.apache.commons.lang.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

import com.twelvemonkeys.lang.StringUtil;

/**
 * This filter is used to invoke a template file. The idea is to put this in the filter chain so that you can call
 * a URL like this:
 * <p/>
 * http://../section/esi/mytemplate.jsp
 * http://../section/article123.ece/dynamic/mytemplate.jsp
 * <p/>
 * Where "dynamic" is the prefix to check for.
 * <p/>
 * Optionally it is possible to configure a base, which can be for example /template/esi/, so calling:
 * http://../section/article123.ece/dynamic/mytemplate.jsp
 * would call /template/esi/mytemplate.jsp
 *
 * @author marc@escenic.com
 */
public class EsiFilter extends GenericProcessor implements Constants {
  public static final String WIDGET_CONTENT = "widgetContent";
  private String mPrefix = null;
  private String mBase = null;

  public EsiFilter() {
    mLogger.debug("Constructed EsiFilter");
  }

  public void setPrefix(String pPrefix) {
    if (mLogger.isDebugEnabled()) {
      mLogger.debug(String.format("Setting prefix to '%s'", pPrefix));
    }
    mPrefix = pPrefix;
  }

  public void setBase(String pBase) {
    if (mLogger.isDebugEnabled()) {
      mLogger.debug(String.format("Setting base to '%s'", pBase));
    }
    mBase = pBase;
  }

  public boolean doBefore(final ServletContext pContext, final ServletRequest pRequest, final ServletResponse pResponse) throws IOException, ServletException {

    // Get the remaining path
    String path = (String) pRequest.getAttribute(Constants.COM_ESCENIC_CONTEXT_PATH);

    if (mLogger.isDebugEnabled()) {
      mLogger.debug("Entered doBefore, path=" + path);
      Enumeration attNames = pRequest.getAttributeNames();
      while (attNames != null && attNames.hasMoreElements()) {
        String attName = (String) attNames.nextElement();
        mLogger.debug(String.format("Attr %s: %s", attName, pRequest.getAttribute(attName)));
      }
    }

    if (StringUtils.isBlank(path)) {
      return true;
    }

    // Section context doesn't start with / while article does
    if (!path.startsWith("/")) path = "/".concat(path);

    if (StringUtils.isBlank(mPrefix) || path.startsWith(mPrefix)) {

      // Remove the prefix
      if (!StringUtils.isBlank(mPrefix) && path.startsWith(mPrefix)) {
        path = path.substring(mPrefix.length());
        if (mLogger.isDebugEnabled()) mLogger.debug("Stripped prefix, path is now: " + path);
      }

      // Add the base
      if (!StringUtils.isBlank(mBase)) {
        path = mBase.concat(path);
        if (mLogger.isDebugEnabled()) mLogger.debug("Added base, path is now: " + path);
      }

      if (mLogger.isDebugEnabled()) {
        mLogger.debug(String.format("Dispatching to path '%s'", path));
      }

      RequestDispatcher rd = pRequest.getRequestDispatcher(path);
      if (rd != null) {
        if (mLogger.isDebugEnabled()) {
          mLogger.debug("Handling path " + path);
        }

        // Put the supplied parameters on the request scope
        Enumeration paramNames = pRequest.getParameterNames();
        while (paramNames.hasMoreElements()) {
          String paramName = String.valueOf(paramNames.nextElement());
          String paramValue = pRequest.getParameter(paramName);
          Object existingAttr = pRequest.getAttribute(paramName);
          if (existingAttr == null) {
            if (!StringUtils.isBlank(paramValue)) {
              if (mLogger.isDebugEnabled())
                mLogger.debug(String.format("Setting request attribute %s: %s", paramName, paramValue));
              pRequest.setAttribute(paramName, paramValue);
            } else {
              if (mLogger.isDebugEnabled())
                mLogger.debug("NOT setting request attribute since it was empty");
            }
          } else {
            if (mLogger.isDebugEnabled()) mLogger.debug(String.format(
                "NOT setting request attribute %s to %s, it was already set: %s", paramName, paramValue, existingAttr));
          }
        }

        String widgetContentId = pRequest.getParameter("widgetContentId");
        if (!StringUtils.isBlank(widgetContentId)) {
          PresentationLoader pl = (PresentationLoader) pContext.getAttribute(
              ServletContextConstants.PRESENTATION_LOADER);

          if (pl == null) {
            mLogger.error("Could not find the presentation loader on the servlet context!");
            return true;
          }

          if (mLogger.isDebugEnabled()) mLogger.debug("Loading widget with ID " + widgetContentId);

          PresentationArticle widgetContent = pl.getArticle(Integer.parseInt(widgetContentId));
          if (mLogger.isDebugEnabled()) mLogger.debug("Loaded widget");
          pRequest.setAttribute(WIDGET_CONTENT, widgetContent);

          // Set response headers
          if (pResponse instanceof HttpServletResponse) {
            setResponseHeaders((HttpServletResponse) pResponse, widgetContent);
          } else {
            mLogger.warn(String.format("Response object was not an instance of %s but %s", HttpServletResponse.class, pResponse.getClass()));
          }
        }
        rd.forward(pRequest, pResponse);
        return false;
      } else {
        if (mLogger.isDebugEnabled()) {
          mLogger.debug("NOT handling path " + path);
        }
      }
    }

    return true;
  }

  /**
   * Set the Cache-Control headers. It gets the values from the widget article.
   *
   * @param pResponse      the HTTP response object.
   * @param pWidgetContent the widget configuration.
   */
  private void setResponseHeaders(HttpServletResponse pResponse, PresentationArticle pWidgetContent) {

    pResponse.setHeader("X-Escenic-Widget-ID", String.valueOf(pWidgetContent.getId()));

    PresentationProperty maxAgeField = pWidgetContent.getFields().get("maxAge");
    PresentationProperty cacheControlDirectiveField = pWidgetContent.getFields().get("cacheControlDirective");

    if (maxAgeField != null && maxAgeField.getValue() instanceof Number) {
      Number maxAge = (Number) maxAgeField.getValue();

      if (mLogger.isDebugEnabled()) {
        mLogger.debug("Max age: " + maxAge.intValue());
      }

      String cacheControlValue = "";

      if (cacheControlDirectiveField != null && cacheControlDirectiveField.getValue() instanceof String) {
        String value = (String) cacheControlDirectiveField.getValue();

        if (!StringUtil.isEmpty(value)) {
          cacheControlValue = value;
        }
      }
      
      if (StringUtil.isEmpty(cacheControlValue)) {
        cacheControlValue = "private";
      }

      pResponse.setHeader("Cache-Control", String.format("%s,s-maxage=%s", cacheControlValue, maxAge.intValue()));
    } else {
      if (mLogger.isDebugEnabled()) mLogger.debug("Not setting max-age: " + maxAgeField);
    }
  }
}