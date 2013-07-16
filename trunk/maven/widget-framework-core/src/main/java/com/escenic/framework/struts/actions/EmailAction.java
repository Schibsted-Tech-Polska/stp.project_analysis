/*
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/java/com/escenic/framework/struts/actions/EmailAction.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 */

package com.escenic.framework.struts.actions;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForm;
import org.apache.struts.Globals;
import org.apache.struts.util.MessageResources;
import com.escenic.framework.struts.forms.EmailForm;
import org.apache.log4j.Logger;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.mail.internet.InternetAddress;
import javax.mail.Address;

import neo.xredsys.email.EmailSender;
import neo.xredsys.email.EmailEvent;
import neo.xredsys.api.IOAPI;
import neo.xredsys.api.ObjectLoader;
import neo.xredsys.api.Article;
import neo.xredsys.api.Section;
import neo.nursery.GlobalBus;

public class EmailAction extends DispatchAction {
  private static final String DEFAULT_BODY = "{0} spotted the following link and thought you should see it : \n{1}";
  private static final String PROPERTY_NAME = "pageTools.widget.email.body";
  protected final Logger mLogger = Logger.getLogger(EmailAction.class);

  public ActionForward sendSimpleMail(final ActionMapping pActionMapping,
                                      final ActionForm pActionForm,
                                      final HttpServletRequest pRequest,
                                      final HttpServletResponse pResponse) throws Exception {
    EmailForm emailForm = (EmailForm) pActionForm;
    String mailto = emailForm.getMailto();

    MessageResources messages = (MessageResources) pRequest.getAttribute(Globals.MESSAGES_KEY);
    String message = messages.getMessage(PROPERTY_NAME);

    if (StringUtils.isBlank(message)) {
      mLogger.warn("The value for the property " + PROPERTY_NAME + " was not found");
      message = DEFAULT_BODY ;
    }
    
    if ((StringUtils.isBlank(emailForm.getFirstName()) && StringUtils.isBlank(emailForm.getSurname()))
      || StringUtils.isBlank(mailto)) {
      mLogger.error("Sender name or recepient email address is empty");
      return pActionMapping.findForward("failure");
    }

     new EmailSenderThread("PageToolsSimpleEmailSender-" + System.currentTimeMillis(), pActionForm, message).start();
     return pActionMapping.findForward("success");
  }

  private class EmailSenderThread extends Thread {
    private static final String mNurseryPath = "/neo/io/services/MailSender";
    private ActionForm mForm = null;
    private String mMessage = null;
    protected final Logger mThreadLogger = Logger.getLogger(getClass());

    private EmailSenderThread(final String pThreadName, final ActionForm pForm, final String pMessage) {
      super(pThreadName);
      mForm = pForm;
      mMessage = pMessage;
    }

    public void run() {
      EmailForm eForm = (EmailForm) mForm;
      String mailto = eForm.getMailto();
      int id = Integer.parseInt(eForm.getId());
      ObjectLoader objectLoader = IOAPI.getAPI().getObjectLoader();
      String type = eForm.getLinkType();
      String url;
      String title;

      if ("art".equalsIgnoreCase(type)) {
        Article art = objectLoader.getArticle(id);
        url = art.getUrl();
        title = art.getTitle();
      } else {
        Section sec = objectLoader.getSection(id);
        url = sec.getUrl();
        title = sec.getName();
      }

      String name = eForm.getFirstName() + " " + eForm.getSurname();
      String mailContent = putPropertyValue(mMessage, name, url);
      String subject = "[From: " + name + "] " + title;

      try {
        EmailSender emailSender = (EmailSender) GlobalBus.lookup(mNurseryPath);
        Address recipient = new InternetAddress(mailto, mailto);
        EmailEvent event = new EmailEvent();
        event.setRecipients(new Address[]{recipient});
        event.setSubject(subject);
        event.setContent(mailContent);
        emailSender.sendMessage(event);
      } catch (Exception ex) {
        mThreadLogger.error("Unable to send mail", ex);
      }
    }

    private String putPropertyValue(String property, String... values) {
      if (values == null || values.length == 0) {
        return property;
      }

      String resultString = property;

      for (int i = 0; i < values.length; i++) {
        String pattern = "\\{" + i + "\\}";
        resultString = resultString.replaceAll(pattern, values[i]);
      }

      return resultString;
    }
  }
}
