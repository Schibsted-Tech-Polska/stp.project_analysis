/**
 * File           : $Header: //depot/escenic/widget-framework/branches/1.4/widget-framework-build-tools/src/main/java/com/escenic/widgetframework/ContentResourceModifier.java#1 $
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
import java.util.zip.ZipFile;
import java.util.zip.ZipEntry;
import java.util.*;

public class ContentResourceModifier {
  private static final int BUFFER_SIZE = 10240;
  private static final String SECTION_ELEMENT_NAME = "ioSection";
  private static final String PARENT_ELEMENT_NAME = "parent";
  private static final String ROOT_SECTION_UNIQUE_NAME = "ece_frontpage";
  private static final String UNIQUE_NAME_ATTRIBUTE = "uniqueName";

  public static void main(String... args) throws Exception {
    if (args.length < 1) {
      System.err.println("You must pass the necessary argument");
      System.exit(1);
    }

    // extract the content resource from the merged war file
    File mergedWarFile = new File(args[0]);
		File parentDir = mergedWarFile.getParentFile();
		ZipFile warFile = new ZipFile(mergedWarFile);
		ZipEntry entry = warFile.getEntry("META-INF/escenic/resources/escenic/content");
		Reader reader = new InputStreamReader(warFile.getInputStream(entry));
		File contentFile = new File(parentDir, "content");
		Writer writer = new FileWriter(contentFile);

    char[] buf = new char[BUFFER_SIZE];
		int count;

		while ((count = reader.read(buf)) > 0) {
			writer.write(buf, 0, count);
		}

		reader.close();
		writer.close();

    // create two xml documents
    SAXBuilder saxBuilder = new SAXBuilder();
    Document oldDocument = saxBuilder.build(contentFile);
    Element oldRoot = oldDocument.getRootElement();

    Document newDocument = new Document();
    Element newRoot = new Element(oldRoot.getName());
    newDocument.setRootElement(newRoot);

    // retrieve children from old document and put them in a Map after grouping them according to their
    // parent
    List sectionList = oldRoot.getChildren(SECTION_ELEMENT_NAME);
    Map<String, List> childrenMap = new HashMap<String, List>();
    Element rootSectionElement = null;

    for (Iterator iterator = sectionList.iterator(); iterator.hasNext();) {
      Element sectionElement = (Element) iterator.next();
      String sectionUniqueName = sectionElement.getAttributeValue(UNIQUE_NAME_ATTRIBUTE);

      if (rootSectionElement == null && sectionUniqueName != null && sectionUniqueName.equals(ROOT_SECTION_UNIQUE_NAME)) {
        rootSectionElement= sectionElement;
      }

      List childrenList = new ArrayList();

      for (Iterator iter = sectionList.iterator(); iter.hasNext();) {
        Element elem = (Element) iter.next();
        Element parent = elem.getChild(PARENT_ELEMENT_NAME);

        if (parent != null) {
          String parentUniqueName = parent.getAttributeValue(UNIQUE_NAME_ATTRIBUTE);
          if (parentUniqueName != null && parentUniqueName.equalsIgnoreCase(sectionUniqueName)) {
            childrenList.add(elem);
          }
        }
      }
      
      childrenMap.put(sectionElement.getAttributeValue(UNIQUE_NAME_ATTRIBUTE), childrenList);
    }

    // now add the elements in the new xml document
    if (rootSectionElement != null) {
      LinkedList queue = new LinkedList();
      queue.add(rootSectionElement);

      while (!queue.isEmpty()) {
        Element currentSection = (Element) queue.removeFirst();
        newRoot.addContent(currentSection.detach());
        List childrenList = childrenMap.get(currentSection.getAttributeValue(UNIQUE_NAME_ATTRIBUTE));

        if (childrenList != null && childrenList.size() > 0) {
          for (Iterator iterator = childrenList.iterator(); iterator.hasNext();) {
            Element childElement = (Element) iterator.next();
            newRoot.addContent(childElement.detach());
            queue.add(childElement);
          }
        }
      }
    }

    // output the new document
    FileWriter fileWriter = new FileWriter(contentFile);
    XMLOutputter outputter = new XMLOutputter();
    outputter.setFormat(Format.getPrettyFormat());
    outputter.output(newDocument, fileWriter);
  }
}
