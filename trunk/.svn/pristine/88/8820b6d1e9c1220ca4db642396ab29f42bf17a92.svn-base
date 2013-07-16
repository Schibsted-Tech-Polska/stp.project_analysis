package com.escenic.captcha;

import org.apache.struts.util.MessageResources;
import org.apache.struts.Globals;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CaptchaValidatorFilter implements Filter {
  private FilterConfig mFilterConfig;
  protected final Logger mLogger = Logger.getLogger(getClass());
  private static final String PROPERTY_NAME = "captcha.error.message";
  private static final String CAPTCHA_ERROR_MESSAGE = "Please enter captcha correctly";
  private static final String COMMENT_FORM_NAME = "commentForm";

  public void init(final FilterConfig pFilterConfig) throws ServletException {
    mFilterConfig = pFilterConfig;
  }

  public void doFilter(final ServletRequest pRequest, final ServletResponse pResponse, final FilterChain pFilterChain)
    throws IOException, ServletException {
    String captcha = pRequest.getParameter("captcha");
    boolean result = isCaptchaValid(captcha, (HttpServletRequest) pRequest);

    if (result) {
      pFilterChain.doFilter(pRequest, pResponse);
    } else {
      HttpServletResponse httpServletResponse = (HttpServletResponse) pResponse;
      String errorUrl = pRequest.getParameter("errorUrl");

      MessageResources messages = (MessageResources) pRequest.getAttribute(Globals.MESSAGES_KEY);
      String errorMessage = messages.getMessage(PROPERTY_NAME);

      if (StringUtils.isBlank(errorMessage)) {
        mLogger.warn("The value for the property " + PROPERTY_NAME + " was not found");
        errorMessage = CAPTCHA_ERROR_MESSAGE;
      }

      httpServletResponse.sendRedirect(
        httpServletResponse.encodeRedirectURL(errorUrl + "?captchaErrorMessage=" + errorMessage + "&title="
          + pRequest.getParameter("title") + "&body=" + pRequest.getParameter("body")
          + "&email=" + pRequest.getParameter("email") + "&field(byline)="
          + pRequest.getParameter("field(byline)") + "#" + COMMENT_FORM_NAME));
    }
  }

  private boolean isCaptchaValid(String pCaptcha, HttpServletRequest pRequest) {
    Captcha escenicCaptcha = (Captcha) pRequest.getSession().getAttribute("escenicCaptcha");
    return escenicCaptcha == null || escenicCaptcha.verifyInput(pCaptcha);
  }

  public void destroy() {
  }
}
