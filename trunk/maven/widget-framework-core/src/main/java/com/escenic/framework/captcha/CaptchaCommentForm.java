package com.escenic.framework.captcha;

import com.escenic.captcha.Captcha;
import com.escenic.forum.struts.presentation.CommentForm;
import org.apache.log4j.Logger;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import javax.servlet.http.HttpServletRequest;

public class CaptchaCommentForm extends CommentForm {
  private static Logger LOGGER = Logger.getLogger(CaptchaCommentForm.class);

  private String captcha;
  private Boolean isResponseCorrect = null;

  public ActionErrors validate(ActionMapping actionMapping, HttpServletRequest httpServletRequest) {
    ActionErrors errors = super.validate(actionMapping, httpServletRequest);

    //checks the captcha
    if(!isCaptchaValid(httpServletRequest)){
      errors.add("captcha", new ActionMessage("wrong.captcha"));
    }
    httpServletRequest.setAttribute(Globals.ERROR_KEY, errors);
    return errors;
  }


  public String getCaptcha() {
    return captcha;
  }

  public void setCaptcha(String captcha) {
    this.captcha = captcha;
  }

  public void reset(ActionMapping actionMapping, HttpServletRequest httpServletRequest) {
    super.reset(actionMapping, httpServletRequest);
    isResponseCorrect = null;
    if(LOGGER.isDebugEnabled()) {
      LOGGER.debug("reset form");
    }
  }

  private boolean isCaptchaValid(HttpServletRequest pRequest) {
    if(isResponseCorrect != null) {
      return isResponseCorrect;
    }
    if(LOGGER.isDebugEnabled()) {
      LOGGER.debug("Validating captcha started");
    }

    Captcha escenicCaptcha = (Captcha)pRequest.getSession().getAttribute("escenicCaptcha");
    if(escenicCaptcha == null) {
      if(LOGGER.isInfoEnabled()) {
        LOGGER.info("Not able to find the captcha(escenicCaptcha) in session during validation. Will return true.");
      }
      return true;
    }
    isResponseCorrect = escenicCaptcha.isInputValid(getCaptcha());
    return isResponseCorrect;
  }
}
