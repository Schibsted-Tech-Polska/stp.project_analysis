package no.mno.ece.plugin.articleImport;

import com.escenic.studio.plugins.PluginTask;
import no.mno.ece.plugin.articleImport.http.ApacheCommonsCommunicator;
import no.mno.ece.plugin.articleImport.http.Communicator;
import no.mno.ece.plugin.articleImport.http.CommunicatorException;
import no.mno.ece.plugin.articleImport.http.ResponseData;
import no.mno.ece.plugin.articleImport.utils.XmlUtilities;
import org.apache.commons.httpclient.*;
import org.apache.log4j.Logger;


import java.util.Properties;

import javax.swing.*;

/**
 * This class contains the logic for importing and saving articles.
 */
public class ArticleImportTask extends PluginTask<String>{

    private final Logger logger = Logger.getLogger(getClass());

    private Properties properties = new Properties();

    private Communicator localClient;
    private Communicator remoteClient;

    private static final int TIMEOUT = 3000;

    private String selectedPublication;
    private String givenArticle;

    private String[] entriesToRemove = {"com.escenic.sourceid", "com.escenic.inlineRelations", "ece-auto-gen", "com.escenic.displayId", "com.escenic.homeSection", "com.escenic.lockURI", "com.escenic.authors", "STORYREL", "FACTBOXREL", "TEASERREL", "TOPMEDIAREL", "PICTUREREL", "LINKREL", "com.escenic.sections", "com.escenic.publication", "com.escenic.displayUri"};

    public ArticleImportTask(Properties properties, String selectedPublication, String givenArticle) {
        this.properties = properties;
        this.selectedPublication = selectedPublication;
        this.givenArticle = givenArticle;

        String rUsername = properties.getProperty(selectedPublication + ".username");
        String rPassword = properties.getProperty(selectedPublication + ".password");
        remoteClient = new ApacheCommonsCommunicator(rUsername, rPassword, TIMEOUT);

        String lUsername = properties.getProperty("local.username");
        String lPassword = properties.getProperty("local.password");
        localClient = new ApacheCommonsCommunicator(lUsername, lPassword, TIMEOUT);
    }

    @Override
    public String getTitle() {
        return "Article Import";
    }

    @Override
    public String doInBackground() throws Exception {

        String remoteWebserviceUrl = properties.getProperty(selectedPublication + ".webservice.url");
        String getArticle = properties.getProperty(selectedPublication + ".webservice.getArticle");
        ResponseData getResponse = getArticleFromRemoteWebservice(remoteWebserviceUrl + getArticle, givenArticle);
        logResponse("Response when GETting article " + givenArticle + " from " + remoteWebserviceUrl + getArticle, getResponse);
        if(getResponse.containsErrors()) {
            return getResponse.getErrorMessage();
        }

        XmlUtilities.ensureArticleIsOfType(getResponse, "news");
        if(getResponse.containsErrors()) {
            return getResponse.getErrorMessage();
        }

        XmlUtilities.copyArticleAuthorsToByline(getResponse);
        XmlUtilities.removeEntriesFromArticle(getResponse, entriesToRemove);
        XmlUtilities.removeInlinePhotos(getResponse);
        XmlUtilities.removeInlineLinks(getResponse, remoteWebserviceUrl);
        XmlUtilities.setStateToDraft(getResponse);
        if(getResponse.containsErrors()) {
            return getResponse.getErrorMessage();
        }

        String articleToSave = getResponse.getResponseBody();

        String localWebserviceUrl = properties.getProperty("local.webservice.url");
        String postNewsArticle = properties.getProperty("local.webservice.postNewsArticle");
        ResponseData postResponse = postArticleToLocalWebservice(localWebserviceUrl + postNewsArticle, articleToSave);
        logResponse("Response when POSTing news article " + givenArticle + " to " + localWebserviceUrl + postNewsArticle, postResponse);
        if(postResponse.containsErrors()) {
            return postResponse.getErrorMessage();
        }

        return postResponse.getInfoMessage();
    }

    private ResponseData getArticleFromRemoteWebservice(String url, String articleId) {
        ResponseData getResponse = new ResponseData();
        boolean successfulGet = true;
        try {
            getResponse = remoteClient.getArticle(url, articleId);
        } catch (CommunicatorException e) {
            successfulGet = false;
        }
        String errorMessage = "En feil oppstod ved forsøk på å hente artikkel med id " + articleId + " fra " + url + ".";
        if(!successfulGet) {
            getResponse.addErrorMessage(errorMessage);
            getResponse.addErrorMessage("Ikke mulig å oppnå kontakt med server.");
        } else if(getResponse.getHttpStatus() == HttpStatus.SC_NOT_FOUND) {
            getResponse.addErrorMessage(errorMessage);
            getResponse.addErrorMessage("Angitt artikkel eksisterer ikke på serveren.");
        } else if(getResponse.getHttpStatus() != HttpStatus.SC_OK) {
            getResponse.addErrorMessage(errorMessage);
            getResponse.addErrorMessage("Statuskode fra server: " + getResponse.getHttpStatus() + ".");
        }
        return getResponse;
    }

    private ResponseData postArticleToLocalWebservice(String postArticleWebserviceUrl, String articleToSave) {
        ResponseData postResponse = new ResponseData();
        boolean successfulPost = true;
        try {
            postResponse = localClient.postNewsArticle(postArticleWebserviceUrl, articleToSave);
        } catch (CommunicatorException e) {
            successfulPost = false;
        }
        String errorMessage = "En feil oppstod ved forsøk på å lagre artikkel med id " + givenArticle + " på " + postArticleWebserviceUrl + ".";
        if(!successfulPost) {
            postResponse.addErrorMessage(errorMessage);
            postResponse.addErrorMessage("Ikke mulig å oppnå kontakt med server.");
        } else if(postResponse.getHttpStatus() != HttpStatus.SC_CREATED) {
            postResponse.addErrorMessage(errorMessage);
            postResponse.addErrorMessage("Statuskode fra server: " + postResponse.getHttpStatus() + ".");
        }
        return postResponse;
    }

    @Override
    public void succeeded(String statusMessage) {
        JOptionPane.showMessageDialog(null, statusMessage);
    }

    private void logResponse(String title, ResponseData response) {
        logger.debug(title);
        logger.debug("Status: " + response.getHttpStatus());
        logger.debug("Body: " + response.getResponseBody());
    }

}
