package com.escenic.framework.decorator;
/**
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-core/src/main/java/com/escenic/framework/decorator/BodyIterator.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
**/

import neo.xredsys.presentation.PresentationArticleDecorator;
import neo.xredsys.presentation.PresentationArticle;
import neo.xredsys.presentation.PresentationTag;

import java.util.List;
import java.util.ArrayList;
import java.io.InputStream;
import java.io.ByteArrayInputStream;

import org.jdom.input.SAXBuilder;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;

import org.apache.log4j.Logger;

public class BodyIterator extends PresentationArticleDecorator {
  private Logger LOGGER = Logger.getLogger(getClass());
  private List<String> bodyElements = new ArrayList<String>();
  private int pageSize = Integer.MAX_VALUE;
  private PresentationArticle presentationArticle;

  public BodyIterator(PresentationArticle pa) {
    super(pa);
    presentationArticle = pa;
    setPageSize();
    populateBodyElements();
  }

  public List<PresentationTag> getTags() {
    return presentationArticle.getTags();
  }

  public List getBodyElements() {
    return bodyElements;
  }

  private void setPageSize() {
    try{
      pageSize = Integer.parseInt(super.getFieldElement("pageSize"));
      if(pageSize <= 0) {
        if(LOGGER.isInfoEnabled()) {
          LOGGER.info("Illegal value(" +  pageSize + "). Will use Integer.MAX_VALUE.");
        }
        pageSize = Integer.MAX_VALUE;

      }
    } catch(NumberFormatException e) {
      LOGGER.warn(e + " not able to parse pageSize: " + super.getFieldElement("pageSize") + " Using Integer.MAX_VALUE" );
    }
  }

  private synchronized void populateBodyElements() {
    if(bodyElements.size() <= 0) {
      String body = "<html>" + super.getFieldElement("body") + "</html>";
      SAXBuilder parser = new SAXBuilder();
      try{
        XMLOutputter outputter = new XMLOutputter();
        InputStream input = new ByteArrayInputStream(body.getBytes("UTF-8"));
        Document doc = parser.build(input);
        List elements = doc.getRootElement().getChildren();
        String page ="";
        int paragraphCounter = 0;
        for (Object el : elements) {
          Element element = (Element)el;
          if(LOGGER.isDebugEnabled()) {
            LOGGER.debug("Reading element: " + element);
          }
          if(element.getName().equalsIgnoreCase("p")) {
            paragraphCounter++;
            if(LOGGER.isDebugEnabled()) {
              LOGGER.debug("Increased paragraph counter to " + paragraphCounter + ". Page size is " + pageSize);
            }
          }
          page = page + outputter.outputString(element);
          if(paragraphCounter >= pageSize) {
            if(LOGGER.isDebugEnabled()) {
              LOGGER.debug("Adding page: " + page);
            }
            bodyElements.add(page);
            page = "";
            paragraphCounter = 0;
          }

        }
        if(page.length() > 0) {
          bodyElements.add(page);
        }
      } catch(Exception e){
        LOGGER.error("Exception while parsing" , e);
      }
    }
  }
}
