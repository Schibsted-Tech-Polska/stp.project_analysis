package no.mno.ece.plugin.articleImport.http;

/**
 * Interface which defines the responsibility of a communicator. Implementations
 * of this interface is responsible for getting and posting articles.
 */
public interface Communicator {

    public ResponseData getArticle(String url, String articleId) throws CommunicatorException;

    public ResponseData postNewsArticle(String url, String article) throws CommunicatorException ;
}
