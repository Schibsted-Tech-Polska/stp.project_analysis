/**
 * Parser escenic xml best&aring;ende av tv-program som kommer fra sentralenheten, og gj&oslash;r det om til et format som tv-guiden
 * forst&aring;r.
 *
 * Created on 22. february 2007, 09:53
 *
 */ 

package no.firestore.util;

import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

import java.io.StringReader;
import java.util.*;

/**
 * @author ohogstad
 */
public class TVParser extends DefaultHandler {

    private boolean error;
    private StringBuffer accumulator;
    private String xmlIn;
    private String outputXml;
    private String encoding;
    private String date;
    private String channelName;
    private boolean channelNameFound = false;
    private String beskrivelseString;
    private String tittelString;
    private String klokkeString;
    private String programId;
    private boolean getBeskrivelse = false;
    private boolean getTittel = false;
    private Map<Integer, String> map = null;
    protected final Logger logger = Logger.getLogger(getClass());

    public TVParser(String xmlIn, String encoding, String date) {
        this.xmlIn = xmlIn;
        this.encoding = encoding;
        this.date = date;
        map=new TreeMap();
    }

    public String getXml() {
        if(logger.isDebugEnabled())
            logger.debug("skal hente xml...");
        outputXml = "";
        try {
            accumulator = new StringBuffer();
            XMLReader parser;
            InputSource input;
            try {
                parser = new org.apache.xerces.parsers.SAXParser();
                parser.setFeature("http://xml.org/sax/features/validation", true);
                parser.setContentHandler(this);
                parser.setErrorHandler(this);
                input = new InputSource(new StringReader(xmlIn));
            } catch (Throwable t) {
                t.printStackTrace();
                error = true;
                return "noe er feil: " + t.toString();
            }
            if (!error) {
                try {
                    parser.parse(input);
                } catch (Throwable t) {
                    t.printStackTrace();
                    return "Feil:Feil " + t.toString();
                }
            }
        } catch (Exception e) {
            return "Parse not ok" + e.toString();
        }
        if(logger.isDebugEnabled())
            logger.debug("returnerer xml");
        return outputXml;
    }

    String getId(String timeString) {
        int time;
        String hourMinutes[] = timeString.split(":");
        int hour = Integer.parseInt(hourMinutes[0]);
        int minutes = Integer.parseInt(hourMinutes[1]);
        if (hour < 5)
            time = hour * 60 + 1440 + minutes;
        else
            time = hour * 60 + minutes;
        return "" + time;
    }

    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        if (localName.equalsIgnoreCase("category")) {
            if (!channelNameFound) {
                if (attributes.getValue("name") != null && attributes.getValue("path") != null) {
                    if (attributes.getValue("path").startsWith("//TV//Channels//")) {
                        channelName = attributes.getValue("name");
                        channelNameFound = true;
                    }
                }
            }
        } else if (localName.equalsIgnoreCase("schedule")) {
            if (attributes.getValue("startDateTime") != null) {
                String startTime = attributes.getValue("startDateTime");
                klokkeString = startTime.substring(10).trim();
                programId = getId(klokkeString);
            }
        } else
        if (localName.equalsIgnoreCase("field") && attributes.getValue("name") != null && attributes.getValue("name").equalsIgnoreCase("beskrivelse"))
            getBeskrivelse = true;
        else
        if (localName.equalsIgnoreCase("field") && attributes.getValue("name") != null && attributes.getValue("name").equalsIgnoreCase("tittel"))
            getTittel = true;
        accumulator.setLength(0);
    }

    public void endElement(String namespaceURL, String localName, String qname) {
        if (localName.equalsIgnoreCase("article")) {
            String tempXml = "<program id=\"" + programId + "\">"
                    + "<kl>" + klokkeString + "</kl>"
                    + "<tittel>" + tittelString + "</tittel>"
                    + "<beskrivelse>" + beskrivelseString + "</beskrivelse>"
                    + "</program>";
            map.put(Integer.valueOf(programId),tempXml);
            beskrivelseString = "";
            tittelString = "";
            klokkeString = "";
            programId = "";
        } else if (localName.equalsIgnoreCase("searchresults")) {
            outputXml = "<?xml version=\"1.0\" encoding=\"" + encoding + "\"?><kanal dato=\"" + date + "\" navn=\"" + channelName + "\">";
            for (Map.Entry<Integer, String> integerStringEntry : map.entrySet()) {
                Map.Entry pairs = integerStringEntry;
                outputXml += pairs.getValue();
            }
        } else if (getBeskrivelse) {
            if (accumulator.length() != 0) {
                beskrivelseString = accumulator.toString();
            }
        } else if (getTittel) {
            if (accumulator.length() != 0) {
                tittelString = accumulator.toString();
            }
        }
        getTittel = false;
        getBeskrivelse = false;
    }

    public void characters(char[] buffer, int start, int length) {
        accumulator.append(buffer, start, length);
    }

    public void endDocument() {
        outputXml+="</kanal>";
    }

}