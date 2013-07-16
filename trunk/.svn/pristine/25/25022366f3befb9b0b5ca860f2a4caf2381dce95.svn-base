package no.mno.ece.plugin.articleImport.utils;

import no.mno.ece.plugin.articleImport.http.ResponseData;
import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;
import org.jdom.xpath.XPath;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.regex.Pattern;

/**
 * This class contains static utility methods for checking or manipulating the XML of the
 * imported articles in order to prepare for saving locally.
 */
public class XmlUtilities {

    private static final Logger logger = Logger.getLogger(XmlUtilities.class);

    public static void ensureArticleIsOfType(ResponseData response, String type) {
        Document doc = getArticleXmlDocument(response);
        String mContentDescriptorText = "";
        boolean succeeded = true;
        try {
            Element mContentDescriptorElement = (Element)XPath.selectSingleNode(doc, "/content/mContentDescriptor");
            mContentDescriptorText = mContentDescriptorElement.getTextTrim();
        } catch (Exception e) {
            succeeded = false;
        }
        if(!succeeded) {
            response.addErrorMessage("Feil oppstod ved forsøk på å finne typen på den importerte artikkelen.");
        } else if(!mContentDescriptorText.endsWith(type)) {
            response.addErrorMessage("Importert artikkel er ikke av riktig type (" + type + ").");
        }
    }

    public static void removeEntriesFromArticle(ResponseData response, String[] entryNames) {
        Document doc = getArticleXmlDocument(response);
        for(String entryName : entryNames) {
            try {
                List<Element> entryElements = XPath.selectNodes(doc, "/content//mProperties//entry[string='" + entryName + "']");
                for(Element entryElement : entryElements) {
                    entryElement.getParentElement().removeContent(entryElement);
                }
            } catch (JDOMException e) {
                response.addErrorMessage("Feil oppstod ved forsøk på å fjerne elementet " + entryName + " fra artikkel-XML.");
            }
        }
        updateArticleXml(response, doc);
    }

    public static void copyArticleAuthorsToByline(ResponseData response) {
        Document doc = getArticleXmlDocument(response);
        String authorEntryName = "com.escenic.authors";
        String bylineEntryName = "BYLINE";
        try {
            List<Element> authorElements = XPath.selectNodes(doc, "/content//mProperties//entry[string='" + authorEntryName + "']/list/com.escenic.domain.Link/mTitle");
            for(Element element : authorElements) {
                Element bylineNameElement = (Element)XPath.selectSingleNode(doc, "/content//mProperties//entry[string='" + bylineEntryName + "']");
                Element bylineValueElement = (Element) (XPath.selectSingleNode(bylineNameElement, "string[last()]"));

                if(bylineNameElement == null || bylineValueElement == null) {
                    response.addInfoMessage("Elementet " + bylineEntryName + " ble ikke funnet, og navnet til opprinnelig forfatter av artikkelen har derfor ikke blitt importert.");
                } else {
                    String byline = bylineValueElement.getTextTrim();
                    String separator = "";
                    if(byline != null && !"".equals(byline)) {
                        separator = ", ";
                    }
                    bylineValueElement.setText(byline + separator + element.getTextTrim());
                }
                String articleXml = new XMLOutputter().outputString(doc);
                response.setResponseBody(articleXml);
            }
        } catch (JDOMException e) {
            response.addErrorMessage("Feil oppstod ved kopiering av forfattere av opprinnelig artikkel til feltet " + bylineEntryName + " i importert artikkel.");
        }
        updateArticleXml(response, doc);
    }

    public static void removeInlinePhotos(ResponseData response) {
        Document doc = getArticleXmlDocument(response);
        String bodyTextEntryName = "BODYTEXT";
        try {
            Element bodytextElement = (Element)XPath.selectSingleNode(doc, "/content//mProperties//entry[string='" + bodyTextEntryName + "']//string[last()]");
            String bodytext = bodytextElement.getTextTrim().replaceAll("<img[^>]*>", "");
            bodytextElement.setText(bodytext);
        } catch (Exception e) {
            response.addErrorMessage("Feil oppstod ved forsøk på å fjerne inline-bilder fra brødteksten.");
        }
        updateArticleXml(response, doc);
    }

    public static void removeInlineLinks(ResponseData response, String webserviceUrl) {
        Document doc = getArticleXmlDocument(response);
        String bodyTextEntryName = "BODYTEXT";
        try {
            Element bodytextElement = (Element)XPath.selectSingleNode(doc, "/content//mProperties//entry[string='" + bodyTextEntryName + "']//string[last()]");
            String bodytext = bodytextElement.getText();
            String linkRegex = "<a href=\\\"" + Pattern.quote(webserviceUrl) + "[^<]*</a>";
            bodytext = bodytext.replaceAll(linkRegex, "");
            bodytextElement.setText(bodytext);
        } catch (Exception e) {
            response.addErrorMessage("Feil oppstod ved forsøk på å fjerne inline-lenker fra brødteksten.");
        }
        updateArticleXml(response, doc);
    }

    public static void setStateToDraft(ResponseData response) {
        Document doc = getArticleXmlDocument(response);
        String bodyTextEntryName = "com.escenic.state";
        try {
            Element stateElement = (Element)XPath.selectSingleNode(doc, "/content//mProperties//entry[string='" + bodyTextEntryName + "']//string[last()]");
            stateElement.setText("draft");
        } catch (Exception e) {
            response.addErrorMessage("Feil oppstod ved forsøk på å endre status til draft.");
        }
        updateArticleXml(response, doc);
    }

    private static Document getArticleXmlDocument(ResponseData response) {
        String articleXml = response.getResponseBody();
        Document doc = new Document();
        try {
            SAXBuilder parser = new SAXBuilder();
            InputStream input = new ByteArrayInputStream(articleXml.getBytes("UTF-8"));
            doc = parser.build(input);
        } catch (Exception e) {
            response.addErrorMessage("Feil oppstod ved tolking av artikkel-XML.");
        }
        return doc;
    }

    private static void updateArticleXml(ResponseData response, Document doc) {
        String articleXml = new XMLOutputter().outputString(doc);
        response.setResponseBody(articleXml);
    }

}
