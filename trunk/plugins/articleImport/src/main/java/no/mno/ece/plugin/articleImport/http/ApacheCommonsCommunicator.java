package no.mno.ece.plugin.articleImport.http;

import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.auth.AuthScope;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpConnectionParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

public class ApacheCommonsCommunicator implements Communicator {

    private final Logger logger = Logger.getLogger(getClass());

    private HttpClient client;

    public ApacheCommonsCommunicator(String userName, String password, int timeout) {
        this.client = new HttpClient();
        client.getParams().setParameter(HttpConnectionParams.CONNECTION_TIMEOUT, timeout);
        client.getParams().setParameter(HttpConnectionParams.SO_TIMEOUT, timeout);
        client.getParams().setAuthenticationPreemptive(true);
        Credentials creds = new UsernamePasswordCredentials(userName, password);
        client.getState().setCredentials(AuthScope.ANY, creds);
    }

    public ResponseData getArticle(String url, String articleId) throws CommunicatorException {
        GetMethod method = new GetMethod(url + articleId);
        method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(3, false));
        method.setRequestHeader("Accept-Language", "no");
        method.setRequestHeader("Accept", "application/vnd.escenic.content+xml");

        int statusCode;
        try {
            statusCode = client.executeMethod(method);
        } catch (IOException e) {
            logger.error("Exception occurred when trying to GET article " + articleId + ".", e);
            throw new CommunicatorException("HTTP GET error");
        }

        ResponseData data = new ResponseData();
        data.setHttpStatus(statusCode);
        String responseBody = getResponseBody(method);
        data.setResponseBody(responseBody);

        return data;
    }

    public ResponseData postNewsArticle(String url, String article) throws CommunicatorException {
        PostMethod method = new PostMethod(url);
        method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(3, false));
        method.setRequestHeader("Accept-Language", "no");
        method.setRequestHeader("Content-Type", "application/xml; charset=UTF-8");
        try {
            method.setRequestEntity(new StringRequestEntity(article, "application/xml", "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            logger.error("Setting the request entity on post method failed due to unsupported encoding.", e);
        }

        int statusCode = 0;
        try {
            statusCode = client.executeMethod(method);
        } catch (IOException e) {
            logger.error("Exception occurred when trying to POST article " + article + ".", e);
            throw new CommunicatorException("HTTP POST error");
        }

        ResponseData data = new ResponseData();
        data.setHttpStatus(statusCode);
        String responseBody = getResponseBody(method);
        data.setResponseBody(responseBody);
        if(statusCode == HttpStatus.SC_CREATED) {
            String newArticleId = getNewArticleId(method);
            data.addInfoMessage("Artikkelen ble lagret med artikkel-id " + newArticleId + ".");
        }
        return data;
    }

    private String getResponseBody(HttpMethod method) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(method.getResponseBodyAsStream(), "UTF-8"));
            StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null){
                buffer.append(line);
            }
            reader.close();
            return buffer.toString();
        } catch (Exception e) {
            logger.debug("Exception occurred when trying to read the responseBody of the httpMethod", e);
        }
        return "";
    }

    private String getNewArticleId(HttpMethod method) {
        String newArticleId = "<ukjent>";
        Header locationHeader = method.getResponseHeader("Location");
        if(locationHeader != null) {
            String location = locationHeader.getValue();
            newArticleId = location.substring(location.lastIndexOf("/") + 1, location.length());
        }
        return newArticleId;
    }

}
