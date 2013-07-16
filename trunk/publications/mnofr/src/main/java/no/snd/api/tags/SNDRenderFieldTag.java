package no.snd.api.tags;

import com.escenic.common.util.xml.ParserUtilities;
import java.io.IOException;
import java.io.StringReader;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;
import java.util.Stack;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import neo.util.StringUtil;
import neo.xredsys.api.IOHashKey;
import neo.xredsys.content.type.ArticleType;
import neo.xredsys.content.type.Field;
import neo.xredsys.content.type.TypeManager;
import neo.xredsys.presentation.PresentationArticle;
import neo.xredsys.presentation.PresentationElement;
import neo.xredsys.presentation.PresentationProperty;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Category;
import org.xml.sax.Attributes;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import neo.taglib.article.AbstractArticleTag;


public class SNDRenderFieldTag extends AbstractArticleTag {
	private static final long serialVersionUID = -4147179145198884962L;

	@Override
	public PresentationArticle getDefaultPresentationArticle() {
		PresentationArticle presentationArticle = (PresentationArticle)this.pageContext.getRequest().getAttribute("sndArticle");
		if(presentationArticle == null){
			presentationArticle = super.getDefaultPresentationArticle();
		}
		return presentationArticle;
	}
	
	static final String XHTML_MIME_TYPE = "application/xhtml+xml";
	private static final String ROOT_ELEMENT_NAME = "ece_xhtml_root_element_render_field";
	static final Set EMPTY_HTML_ELEMENTS;
	static final Set UNESCAPED_HTML_ELEMENTS;
	private String mField;
	private String mFieldValue;
	private String mVar;
	private String mVarBody;
	private String mOutput;
	private boolean mInhibitEscaping;
	private int mScope;
	private boolean mErrorOccurred;
	private Queue<Object> mContentQueue;
	private Map<String, PresentationElement> mInlineRelations;

	public SNDRenderFieldTag(){
		this.mInhibitEscaping = false;
		this.mScope = 1;
		this.mErrorOccurred = false;
		this.mContentQueue = new LinkedList();
		this.mInlineRelations = null;
	}

	public int doStartTag() throws JspException {
		this.mScope = getToScope();
		PresentationArticle article = getDefaultPresentationArticle();

		if (article == null) {
			return 0;
		}

		String fieldValue = getFieldValue(article, this.mField);
		if (fieldValue == null) {
			return 0;
		}

		if ((this.mField != null) && (!isInlineItemAllowed(article, this.mField.toUpperCase()))) {
			writeToOutputStream(fieldValue);
			return 0;
		}

		this.mInlineRelations = new HashMap(article.getInlineElements());
		this.mErrorOccurred = (!parseField(fieldValue));
		
		//TODO remove this
		int index = 0;
		System.err.println(mInlineRelations.isEmpty()?"NO mInlineRelations":"THERE IS "+mInlineRelations.size()+" mInlineRelations element: ");
		for(Entry<String, PresentationElement> elem: mInlineRelations.entrySet()){
			System.err.println("elem "+(index++)+": "+elem.getValue().getContent());
		}
		System.err.println();
		index = 0;
		System.err.println(mContentQueue.isEmpty()?"NO mContentQueue":"THERE IS "+mContentQueue.size()+" mContentQueue element: ");
		for(Object elem: mContentQueue){
			System.err.println("elem "+(index++)+": "+elem);
		}
					
		if (this.mErrorOccurred) {
			writeToOutputStream(fieldValue);
			return 0;
		}

		return generateOutput() ? 1 : 0;
	}

	private String getFieldValue(PresentationArticle pArticle, String pFieldName) {
		String fieldValue = null;
		if (pFieldName != null) {
			PresentationProperty field = (PresentationProperty)pArticle.getFields().get(pFieldName.toUpperCase());
			fieldValue = (String)field.getValue();
		} else if (getFieldValue() != null) {
			fieldValue = getFieldValue();
		}
		return fieldValue;
	}

	public int doAfterBody() {
		return generateOutput() ? 2 : 0;
	}

	public int doEndTag() {
		if ((!this.mContentQueue.isEmpty()) && (!this.mErrorOccurred)) {
			while (!this.mContentQueue.isEmpty()) {
				Object item = this.mContentQueue.remove();
				if (!(item instanceof IOHashKey)) {
					writeToOutputStream(item.toString());
				}
			}
		}

		reset();
		return 6;
	}

	String getFieldValueFromArticle(String pFieldName) {
		String fieldValue = "";
		PresentationArticle presentationArticle = getDefaultPresentationArticle();
		Map fieldMap = presentationArticle.getFields();

		if (fieldMap == null) {
			return fieldValue;
		}

		PresentationProperty property = (PresentationProperty)fieldMap.get(pFieldName);

		if (property != null) {
			fieldValue = (String)property.getValue();
		}

		return fieldValue;
	}

	private boolean generateOutput() {
		IOHashKey hashKey = getNextInlineItem();

		if (hashKey == null) {
			return false;
		}

		PresentationElement element = getInlineElement(hashKey);

		Object body = this.mContentQueue.remove();
		if ((!StringUtils.isEmpty(this.mVarBody)) && ((body instanceof String)) && (!StringUtils.isEmpty((String)body))) {
			setAttributeToScope(this.mVarBody, (String)body, this.mScope);
		}

		setAttributeToScope(this.mVar, element, this.mScope);
		return true;
	}

	private PresentationElement getInlineElement(IOHashKey pHashKey) {
		for (Entry entry : this.mInlineRelations.entrySet()) {
			if (((PresentationElement)entry.getValue()).getContent().getHashKey().equals(pHashKey)) {
				return (PresentationElement)entry.getValue();
			}
		}
		return null;
	}

	private void reset() {
		if (this.mContentQueue != null) {
			this.mContentQueue.clear();
		}
		if (this.mInlineRelations != null) {
			this.mInlineRelations.clear();
		}
		this.mScope = 1;
		this.mInhibitEscaping = false;
		this.mErrorOccurred = false;

		if (this.BROWSER.isDebugEnabled()) {
			this.BROWSER.debug("Cleared content queue and hashKeyToPresentationElementMap");
		}
	}

	private IOHashKey getNextInlineItem() {
		while (!this.mContentQueue.isEmpty()) {
			Object object = this.mContentQueue.remove();

			if ((object instanceof IOHashKey)) {
				return (IOHashKey)object;
			}

			writeToOutputStream(object.toString());
		}

		return null;
	}

	private boolean parseField(String pFieldValue) {
		if (StringUtils.isEmpty(pFieldValue)) {
			return false;
		}
		try {
			String fieldValue = "<!DOCTYPE empty PUBLIC \"-//Escenic//Global HTML entities 1.0//EN\" \"file:///empty.dtd\"><ece_xhtml_root_element_render_field>" + pFieldValue + "</" + "ece_xhtml_root_element_render_field" + ">";
			EntityResolver emptyEntityResolver = new EntityResolver() {
				public InputSource resolveEntity(String pPublicId, String pSystemId) throws SAXException, IOException {
					if ("file:///empty.dtd".equals(pSystemId)) {
						return new InputSource(new StringReader(""));
					}
					return null;
				}
			};
			XMLReader parser = ParserUtilities.getXMLReader(emptyEntityResolver);
			parser.setContentHandler(new InlineContentHandler());
			parser.parse(new InputSource(new StringReader(fieldValue)));
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			this.BROWSER.error("Error while parsing field value " + pFieldValue, ex);
		}
		return false;
	}

	private boolean isInlineItemAllowed(PresentationArticle pArticle, String pFieldName) {
		return "application/xhtml+xml".equalsIgnoreCase(getFieldMimeType(pArticle, pFieldName));
	}

	String getFieldMimeType(PresentationArticle pArticle, String pFieldName) {
		String mimeType = null;
		Field field = TypeManager.getInstance().getArticleType(pArticle.getPublicationId(), pArticle.getArticleTypeName()).getField(pFieldName);

		if (field != null) {
			mimeType = field.getMimetype();
		}

		return mimeType;
	}

	void writeToOutputStream(String pString) {
		try {
			this.pageContext.getOut().write(pString);
		} catch (IOException ex) {
			this.BROWSER.error("Error while writing to output stream", ex);
		}
	}

	void setAttributeToScope(String pName, Object pValue, int pScope) {
		this.pageContext.setAttribute(pName, pValue, pScope);
	}

	public String getField() {
		return this.mField;
	}

	public void setField(String pField) {
		this.mField = pField;
	}

	public String getFieldValue() {
		return this.mFieldValue;
	}

	public void setFieldValue(String pFieldValue) {
		this.mFieldValue = pFieldValue;
	}

	public String getVar() {
		return this.mVar;
	}

	public void setVar(String pVar) {
		this.mVar = pVar;
	}

	public String getVarBody() {
		return this.mVarBody;
	}

	public void setVarBody(String pVarBody) {
		this.mVarBody = pVarBody;
	}

	public String getOutput() {
		return this.mOutput;
	}

	public void setOutput(String pOutput) {
		this.mOutput = pOutput;
	}

	private boolean isHtmlOutput() {
		return !"xml".equals(this.mOutput);
	}

	static {
		Set elements = new HashSet();
		elements.add("area");
		elements.add("base");
		elements.add("basefont");
		elements.add("br");
		elements.add("col");
		elements.add("frame");
		elements.add("hr");
		elements.add("img");
		elements.add("input");
		elements.add("isindex");
		elements.add("link");
		elements.add("meta");
		elements.add("param");
		EMPTY_HTML_ELEMENTS = Collections.unmodifiableSet(elements);

		elements = new HashSet();
		elements.add("script");
		elements.add("style");
		UNESCAPED_HTML_ELEMENTS = Collections.unmodifiableSet(elements);
	}

	private class InlineContentHandler extends DefaultHandler {
		private final Stack<String> mInlineItemNameStack = new Stack();
		private final StringBuilder mInterimString = new StringBuilder();
		
		private InlineContentHandler() { }

		public void skippedEntity(String pName) throws SAXException {
			this.mInterimString.append(String.format("&%s;", new Object[] { pName }));
		}

		public void characters(char[] pCharacters, int pStart, int pLength) throws SAXException {
			if (SNDRenderFieldTag.this.mInhibitEscaping) {
				this.mInterimString.append(pCharacters, pStart, pLength);
			} else {
				this.mInterimString.append(StringUtil.escapeHtmlLight(new String(pCharacters, pStart, pLength)));
			}
		}

		public void startElement(String pURI, String pLocalName, String pQName, Attributes pAttributes) throws SAXException {
			if ("ece_xhtml_root_element_render_field".equalsIgnoreCase(pQName)) {
				return;
			}

			if ((SNDRenderFieldTag.this.isHtmlOutput()) && (SNDRenderFieldTag.UNESCAPED_HTML_ELEMENTS.contains(pQName.toLowerCase()))) {
				SNDRenderFieldTag.this.mInhibitEscaping = true;
			}

			IOHashKey hashKey = getHashKey(pLocalName, pQName, pAttributes, SNDRenderFieldTag.this.mInlineRelations);

			if ((!isParsingInlineObject()) && (hashKey != null)) {
				addInterimStringToContentQueue(SNDRenderFieldTag.this.mContentQueue, this.mInterimString);
				SNDRenderFieldTag.this.mContentQueue.add(hashKey);
				this.mInlineItemNameStack.push(pQName);
			} else {
				addStartElement(pURI, pLocalName, pQName, pAttributes);
			}
		}

		public void endElement(String pURI, String pLocalName, String pQName) throws SAXException {
			if ("ece_xhtml_root_element_render_field".equalsIgnoreCase(pQName)) {
				SNDRenderFieldTag.this.mContentQueue.add(this.mInterimString.toString());
				return;
			}

			if ((SNDRenderFieldTag.this.isHtmlOutput()) && (SNDRenderFieldTag.UNESCAPED_HTML_ELEMENTS.contains(pQName.toLowerCase()))) {
				SNDRenderFieldTag.this.mInhibitEscaping = false;
			}

			if (!isParsingInlineObject()) {
				addEndElement(pURI, pLocalName, pQName);
			} else {
				if (((String)this.mInlineItemNameStack.peek()).equalsIgnoreCase(pQName)) {
					this.mInlineItemNameStack.pop();
				}

				if (!isParsingInlineObject()) {
					addInterimStringToContentQueue(SNDRenderFieldTag.this.mContentQueue, this.mInterimString);
				}
			}
		}

		private void addInterimStringToContentQueue(Queue<Object> pContentQueue, StringBuilder pBuilder) {
			pContentQueue.add(this.mInterimString.toString());
			pBuilder.delete(0, this.mInterimString.length());
		}

		private boolean isParsingInlineObject() {
			return !this.mInlineItemNameStack.isEmpty();
		}

		private IOHashKey getHashKey(String pLocalName, String pQName, Attributes pAttributes, Map<String, PresentationElement> pInlineRelations) {
			if (("a".equalsIgnoreCase(pQName)) || ("img".equalsIgnoreCase(pQName))) {
				String id = pAttributes.getValue("id");
				if (!StringUtils.isBlank(id)) {
					return getInlineRelation(id, pInlineRelations);
				}
			}

			return null;
		}

		private IOHashKey getInlineRelation(String pID, Map<String, PresentationElement> pInlineRelations) {
			for (Entry entry : pInlineRelations.entrySet()) {
				if (pID.endsWith((String)entry.getKey())) {
					return ((PresentationElement)entry.getValue()).getContent().getHashKey();
				}
			}

			return null;
		}

		private void addStartElement(String pURI, String pLocalName, String pQName, Attributes pAttributes) {
			this.mInterimString.append("<").append(pQName);

			if (pAttributes.getLength() == 0) {
				this.mInterimString.append(">");
			} else {
				this.mInterimString.append(" ");

				for (int i = 0; i < pAttributes.getLength(); i++) {
					this.mInterimString.append(pAttributes.getQName(i)).append("=").append("\"").append(pAttributes.getValue(i)).append("\"");

					if (i < pAttributes.getLength() - 1) {
						this.mInterimString.append(" ");
					}
				}

				this.mInterimString.append(">");
			}
		}

		private void addEndElement(String pURI, String pLocalName, String pQName) {
			if ((SNDRenderFieldTag.this.isHtmlOutput()) && (SNDRenderFieldTag.EMPTY_HTML_ELEMENTS.contains(pQName.toLowerCase()))) {
				return;
			}
			this.mInterimString.append("</" + pQName + ">");
		}
	}
}
