/**
 * File           : $Header: //depot/escenic/widget-framework/trunk/widget-framework-build-tools/src/main/java/com/escenic/widgetframework/CustomContentTypeMerger.java#4 $
 * Last edited by : $Author: shah $ $Date: 2010/12/15 $
 * Version        : $Revision: #4 $
 *
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 **/

package com.escenic.widgetframework;

import org.w3c.dom.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * This class merges widget content type definitions into a single file.
 *
 * @author Shamim Ahmed
 */
public class CustomContentTypeMerger {
    private static final int BUFFER_SIZE = 1024;
    private static final String NAME_ATTRIBUTE = "name";
    private static final String MERGED_FILE_NAME = "content-type-merged";

    public static void main(String... args) throws Exception {
        if (args.length < 2) {
            System.err.println("You must pass the necessary arguments");
            System.exit(1);
        }

        // now scan specified directory for updated widgets
        File updatedWidgetDir = new File(args[1]);
        File[] updatedWidgets = updatedWidgetDir.listFiles();

        if (updatedWidgets == null || updatedWidgets.length == 0) {
            return;
        }

        // read the merged content type file
        File mergedWarFile = new File(args[0]);
        File parentDir = mergedWarFile.getParentFile();
        ZipFile warFile = new ZipFile(mergedWarFile);
        ZipEntry entry = warFile.getEntry("META-INF/escenic/publication-resources/escenic/content-type");
        Reader reader = new InputStreamReader(warFile.getInputStream(entry));
        File contentTypeFile = new File(parentDir, "content-type");
        Writer writer = new FileWriter(contentTypeFile);

        char[] buf = new char[BUFFER_SIZE];
        int count;

        while ((count = reader.read(buf)) > 0) {
            writer.write(buf, 0, count);
        }

        reader.close();
        writer.close();

        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = domFactory.newDocumentBuilder();
        XPathFactory factory = XPathFactory.newInstance();

        Document mergedDocument = builder.parse(contentTypeFile);
        Element mergedDocumentRoot = mergedDocument.getDocumentElement();

        // read content-type resource for each widget
        for (File widget : updatedWidgets) {
            File contentType = new File(widget, "model/content-type");

            if (!contentType.exists()) {
                System.err.println("Could not find content-type definition under modified widget");
                continue;
            }

            Document widgetDocument = builder.parse(contentType);
            NodeList childNodes = widgetDocument.getDocumentElement().getChildNodes();

            for (int i = 0; i < childNodes.getLength(); i++) {
                Node node = childNodes.item(i);

                if (node instanceof Element) {
                    Element element = (Element) node;
                    XPath xpath = factory.newXPath();

                    Attr nameAttribute = element.getAttributeNode(NAME_ATTRIBUTE);
                    boolean foundInDocument = false;

                    if (nameAttribute != null) {
                        XPathExpression expression = xpath.compile("/content-types/" + element.getNodeName() + "[@name='" + nameAttribute.getValue() + "']");
                        Object result = expression.evaluate(mergedDocument, XPathConstants.NODESET);
                        NodeList resultList = (NodeList) result;

                        if (resultList.getLength() > 0) {
                            foundInDocument = true;
                            Node targetNode = resultList.item(0);
                            Node importedNode = mergedDocument.importNode(node, true);
                            mergedDocumentRoot.replaceChild(importedNode, targetNode);
                        }
                    }

                    if (!foundInDocument) {
                        Node importedNode = mergedDocument.importNode(node, true);
                        mergedDocumentRoot.appendChild(importedNode);
                    }
                }
            }
        }

        // perform the transformation and store the result in a ByteArrayOutputStream
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        DOMSource domSource = new DOMSource(mergedDocument);
        StreamResult streamResult = new StreamResult(byteArrayOutputStream);
        transformer.transform(domSource, streamResult);

        // if we're here, transformation was successful
        byte[] outputBytes = byteArrayOutputStream.toByteArray();
        FileOutputStream fileOutputStream = new FileOutputStream(new File(parentDir, MERGED_FILE_NAME));
        fileOutputStream.write(outputBytes);
        byteArrayOutputStream.close();
        fileOutputStream.close();
    }
}