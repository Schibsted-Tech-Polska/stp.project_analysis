package tools;

/**
 * Created by IntelliJ IDEA.
 * User: torillkj
 * Date: 09.des.2010
 * Time: 13:34:29
 * To change this template use File | Settings | File Templates.
   Denne klassen krever input av to properties: xslFile og (xmlUrl eller xmlFile). Det kreves full path til filene.
   Output er transformering av de to input filene.
   Eksempel paa bruk i jsp:
   <jsp:useBean id="xmlWriter" scope="request" class="tools.XmlTransformer"/>
   <jsp:setProperty name="xmlWriter" property="xmlUrl" value="http://www.navcom.no/aislive/getdata.aspx?usern=bt&passo=bt934x"/>
   <jsp:setProperty name="xmlWriter" property="xslFile" value="/data/webapps/bt/bt/template/externalservices/shipTraffic/aisxml.xsl"/>
   <jsp:getProperty name="xmlWriter" property="presentation"/>
 */

import javax.xml.transform.stream.*;
import javax.xml.transform.*;
import java.net.*;
import java.io.*;
import java.util.*;

public class XmlTransformer {
 String i_xml;
 String e_xml;
 String i_xsl;
 Transformer transformer;
 StreamResult result;
 StreamSource xml;
 StringWriter mStringWriter;
 Hashtable parameters = null;

// private static final boolean DEBUG_ = false;

 public XmlTransformer() {
	i_xml = null;
	e_xml = null;
	i_xsl = null;

	transformer=null;
	result =null;
	xml = null;

	parameters = new Hashtable();
	mStringWriter = new StringWriter();

 }

 public String getPresentation() {
	 go();
	return mStringWriter.toString();
 }

public void setParameters(Hashtable _parameters)
{
	this.parameters = _parameters;
}

public void setXslFile(String inputXslFile) {

//	if (DEBUG_) mStringWriter.write("i_xsl="+inputXslFile);
	i_xsl = inputXslFile;
 }

public void setXMLFile(String inputXMLFile) {
//	if (DEBUG_) mStringWriter.write("i_xml="+inputXMLFile);
	i_xml = inputXMLFile;
 }

 public void setXmlUrl(String inputXMLFile) {
//	if (DEBUG_) mStringWriter.write("e_xml="+inputXMLFile);
	e_xml = inputXMLFile;
 }

 private void go(){
	try {
		mStringWriter = new StringWriter();
		if (i_xml != null)  {
			 xml = new StreamSource(new File(i_xml));
		} else {
			 xml = new StreamSource(e_xml);
		}
		StreamSource xsl = new StreamSource(new File(i_xsl));

		result = new StreamResult(mStringWriter);

		TransformerFactory tfactory = TransformerFactory.newInstance();
		transformer = tfactory.newTransformer(xsl);

		 for (Enumeration e = parameters.keys() ; e.hasMoreElements() ;) {
			 String key = (String)e.nextElement();
			 String value = (String)parameters.get(key);
			 transformer.setParameter(key, value);
		 }


		transformer.transform(xml, result);
		}
		catch (javax.xml.transform.TransformerConfigurationException e) {
//		 if (DEBUG_) mStringWriter.write("feil="+e.getMessage());
		}
		catch(javax.xml.transform.TransformerException _ex) {
//		if (DEBUG_) mStringWriter.write("feil="+_ex.getMessage());
		}

	}

}
