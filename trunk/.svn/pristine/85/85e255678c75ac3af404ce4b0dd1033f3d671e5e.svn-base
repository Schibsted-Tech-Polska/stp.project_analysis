/**
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-build-tools/src/main/java/com/escenic/widgetframework/ContentTypeMerger.java#1 $
 * Last edited by : $Author: shah $ $Date: 2010/10/18 $
 * Version        : $Revision: #1 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
**/
package com.escenic.widgetframework;

import org.jdom.input.SAXBuilder;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.jdom.output.Format;

import java.io.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

public class ContentTypeMerger {
  private static final String CONTENT_TYPE_PATH = "src/main/webapp/META-INF/escenic/publication-resources/escenic/content-type";
  private static final String CORE_MODULE_NAME = "widget-framework-core";

  public static void main(String... args) throws Exception {
    if (args.length < 2) {
      System.err.println("You must pass the necessary arguments");
      System.exit(1);
    }

    final String[] widgetTypes = {"core", "community", "mobile"};
    File baseDir = new File(args[0]);
    File outputDir = new File(args[1]);
    String coreContentTypePath = CORE_MODULE_NAME + "/" + CONTENT_TYPE_PATH;
    File coreContentTypeFile = new File(baseDir, coreContentTypePath);

    if (coreContentTypeFile.exists() && coreContentTypeFile.isFile()) {
      SAXBuilder saxBuilder = new SAXBuilder();

      for (String widgetType : widgetTypes) {
        InputStream inputStream = new FileInputStream(coreContentTypeFile);
        Document mergedDocument = saxBuilder.build(inputStream);

        if (!widgetType.equalsIgnoreCase("core")) {
          String moduleName = "widget-framework-" + widgetType;
          File moduleDir = new File (baseDir, moduleName);

          if (moduleDir.exists() && moduleDir.isDirectory()) {
            File moduleContentTypeFile = new File (moduleDir, CONTENT_TYPE_PATH);
            if (moduleContentTypeFile.exists() && moduleContentTypeFile.isFile()) {
              Document moduleContentTypeDocument = saxBuilder.build(moduleContentTypeFile);
              mergeDocuments(moduleContentTypeDocument, mergedDocument);
            }
          }
        }

        File[] widgets = baseDir.listFiles(new WidgetFilenameFilter(widgetType));

        for (File widget : widgets) {
          if (widget.isDirectory()) {
            File widgetContentTypeFile = new File(widget, CONTENT_TYPE_PATH);
            if (widgetContentTypeFile.exists() && widgetContentTypeFile.isFile()) {
              Document widgetDocument = saxBuilder.build(widgetContentTypeFile);
              mergeDocuments(widgetDocument, mergedDocument);
            }
          }
        }

        String outputFileName = "content-type-" + widgetType;
        File outputFile = new File(outputDir, outputFileName);
        XMLOutputter outputter = new XMLOutputter();
        outputter.setFormat(Format.getPrettyFormat());
        outputter.output(mergedDocument, new FileWriter(outputFile));

      }
    }
  }

  private static void mergeDocuments(final Document pSourceDocument, final Document pTargetDocument) {
    Element sourceDocumentRoot = pSourceDocument.getRootElement();
    Element targetDocumentRoot = pTargetDocument.getRootElement();
    List childrenList = sourceDocumentRoot.getChildren();
    List copiedList = new ArrayList(childrenList);

    for (Iterator iterator = copiedList.iterator(); iterator.hasNext();) {
      Element child = (Element) iterator.next();
      targetDocumentRoot.addContent(child.detach());
    }

  }

  private static class WidgetFilenameFilter implements FilenameFilter {
    private String widgetType;
    private String widgetModulePrefix;

    WidgetFilenameFilter(String type) {
      widgetType = type;
      widgetModulePrefix = "widget-" + widgetType + "-";
    }

    public boolean accept(File parentDir, String name) {
      return name.startsWith(widgetModulePrefix);
    }
  }
}
