package no.mno.contentstudio.plugin.articleImport;

import no.mno.ece.plugin.articleImport.http.ResponseData;
import no.mno.ece.plugin.articleImport.utils.XmlUtilities;
import org.apache.commons.io.IOUtils;

import java.io.InputStream;
import java.io.StringWriter;
import java.util.Properties;

import org.custommonkey.xmlunit.XMLTestCase;
import org.custommonkey.xmlunit.XMLUnit;

public class XmlUtilitiesTest extends XMLTestCase {

    private ResponseData data;
    private Properties testProperties;

    protected void setUp() throws Exception {
        XMLUnit.setIgnoreComments(true);
        XMLUnit.setIgnoreWhitespace(true);
        XMLUnit.setIgnoreAttributeOrder(true);
        XMLUnit.setNormalizeWhitespace(true);
        XMLUnit.setNormalize(true);

        testProperties = new Properties();
        InputStream in = getClass().getClassLoader().getResourceAsStream("testArticleImport.properties");
        testProperties.load(in);
    }

    public void testEnsureImportedArticleIsOfCorrectTypeDoesNotGenerateError() throws Exception {
        data = createTestdata("testdata_ensureTypeCorrect.xml");
        XmlUtilities.ensureArticleIsOfType(data, "news");
        assertFalse(data.containsErrors());
    }

    public void testEnsureImportedArticleIsOfWrongTypeGeneratesError() throws Exception {
        data = createTestdata("testdata_ensureTypeWrong.xml");
        XmlUtilities.ensureArticleIsOfType(data, "news");
        assertTrue(data.containsErrors());
    }

    public void testRemoveEntriesShouldNotChangeXmlWhenNoEntryIsGiven() throws Exception {
        data = createTestdata("testdata_removeEntries.xml");
        XmlUtilities.removeEntriesFromArticle(data, new String[0]);
        String expected = readXmlFileToString("expected_removeNoEntry.xml");
        String result = data.getResponseBody();

        assertXMLEqual(expected, result);
    }

    public void testRemoveEntriesShouldRemoveOneGivenEntryFromDom() throws Exception {
        data = createTestdata("testdata_removeEntries.xml");
        XmlUtilities.removeEntriesFromArticle(data, new String[]{"com.escenic.displayId"});
        String expected = readXmlFileToString("expected_removeOneEntry.xml");
        String result = data.getResponseBody();

        assertXMLEqual(expected, result);
    }

    public void testRemoveEntriesShouldRemoveMoreThanOneGivenEntryFromDom() throws Exception {
        data = createTestdata("testdata_removeEntries.xml");
        XmlUtilities.removeEntriesFromArticle(data, new String[]{"com.escenic.displayId", "FRONTPAGETITLE"});
        String expected = readXmlFileToString("expected_removeMoreThanOneEntry.xml");
        String result = data.getResponseBody();

        assertXMLEqual(expected, result);
    }

    public void testCopyArticleAuthorsToBylineShouldNotChangeBylineWhenNoAuthorExist() throws Exception {
        data = createTestdata("testdata_copyNoAuthor.xml");
        XmlUtilities.copyArticleAuthorsToByline(data);
        String expected = readXmlFileToString("testdata_copyNoAuthor.xml");
        String result = data.getResponseBody();

        assertXMLEqual(expected, result);
    }

    public void testCopyArticleAuthorsToBylineShouldCopyOneAuthorToByline() throws Exception {
        data = createTestdata("testdata_copyOneAuthor.xml");
        XmlUtilities.copyArticleAuthorsToByline(data);
        String expected = readXmlFileToString("expected_copyOneAuthor.xml");
        String result = data.getResponseBody();

        assertXMLEqual(expected, result);
    }

    public void testCopyArticleAuthorsToBylineShouldCopyTwoAuthorsToByline() throws Exception {
        data = createTestdata("testdata_copyTwoAuthors.xml");
        XmlUtilities.copyArticleAuthorsToByline(data);
        String expected = readXmlFileToString("expected_copyTwoAuthors.xml");
        String result = data.getResponseBody();
        assertXMLEqual(expected, result);
    }

    public void testRemoveInlinePhotos() throws Exception {
        data = createTestdata("testdata_removeInlinePhotos.xml");
        XmlUtilities.removeInlinePhotos(data);
        String expected = readXmlFileToString("expected_removeInlinePhotos.xml");
        String result = data.getResponseBody();
        assertXMLEqual(expected, result);
    }

    public void testRemoveInlineLinks() throws Exception {
        data = createTestdata("testdata_removeInlineLinks.xml");
        XmlUtilities.removeInlineLinks(data, testProperties.getProperty("bt.webservice.url"));
        String expected = readXmlFileToString("expected_removeInlineLinks.xml");
        String result = data.getResponseBody();
        assertXMLEqual(expected, result);
    }

    public void testSetStateToDraft() throws Exception {
        data = createTestdata("testdata_changeState.xml");
        XmlUtilities.setStateToDraft(data);
        String expected = readXmlFileToString("expected_changeState.xml");
        String result = data.getResponseBody();
        assertXMLEqual(expected, result);
    }


    private String readXmlFileToString(String filename) throws Exception {
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream(filename);
        StringWriter writer = new StringWriter();
        IOUtils.copy(inputStream, writer, "UTF-8");
        return writer.toString();
    }

    private ResponseData createTestdata(String filename) throws Exception {
        ResponseData data = new ResponseData();
        String textXml = readXmlFileToString(filename);
        data.setResponseBody(textXml);
        return data;
    }
}
