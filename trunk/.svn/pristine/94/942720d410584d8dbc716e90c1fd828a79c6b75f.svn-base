package no.mno.ece.plugin.articleImport;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * This class contains a main method for testing the article import task.
 */
public class TestImport {

    // The short name of the publication
    private static final String PUBLICATION = "bt";
    // The article's id, must be an article of type news
    private static final String ARTICLE = "1979";

    public static void main(String[] args) throws Exception {
        Properties properties = readPropertiesFile();
        ArticleImportTask task = new ArticleImportTask(properties, PUBLICATION, ARTICLE);
        String statusMessage = task.doInBackground();
        task.succeeded(statusMessage);
    }

    private static Properties readPropertiesFile() {
        Properties properties = new Properties();
        String filename = "articleImport.properties";
        InputStream in = TestImport.class.getClassLoader().getResourceAsStream(filename);
        try {
            properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return properties;
    }
}
