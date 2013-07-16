package no.mno.ece.plugin.articleImport.http;

/**
 * Objects of this type contains relevant information about the response from the server,
 * as well as error and info messages which will be displayed for the user.
 */
public class ResponseData {

    private int httpStatus;
    private String responseBody;

    private StringBuffer errorMessage;
    private StringBuffer infoMessage;

    public ResponseData() {
        errorMessage = new StringBuffer();
        infoMessage = new StringBuffer();
    }

    public int getHttpStatus() {
        return httpStatus;
    }

    public void setHttpStatus(int httpStatus) {
        this.httpStatus = httpStatus;
    }

    public String getResponseBody() {
        return responseBody;
    }

    public void setResponseBody(String responseBody) {
        this.responseBody = responseBody;
    }

    public String getErrorMessage() {
        return errorMessage.toString();
    }

    public void addErrorMessage(String message) {
        errorMessage.append(" ");
        errorMessage.append(message);
    }

    public boolean containsErrors() {
        return errorMessage != null && !"".equals(errorMessage.toString().trim());
    }

    public String getInfoMessage() {
        return infoMessage.toString();
    }

    public void addInfoMessage(String message) {
        infoMessage.append(message);
    }
}