package no.snd.http;

import no.snd.api.news.client.services.HttpContextThreadLocal;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.cache.CacheConfig;
import org.apache.http.impl.conn.PoolingClientConnectionManager;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;

import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created with IntelliJ IDEA.
 * User: regearne
 * Date: 19.03.13
 * Time: 21:22
 * To change this template use File | Settings | File Templates.
 */
public class CachingHttpClient {
    private CacheConfig cacheConfig;
    PoolingClientConnectionManager poolingClientConnectionManager;
    private org.apache.http.client.HttpClient httpClient;

    public CachingHttpClient() {
        initializeHttp();
    }

    private void initializeHttp() {
        HttpContextThreadLocal.set(new BasicHttpContext());
        SchemeRegistry schemeRegistry = new SchemeRegistry();
        schemeRegistry.register(
                new Scheme("http", 80, PlainSocketFactory.getSocketFactory()));
        schemeRegistry.register(
                new Scheme("https", 443, SSLSocketFactory.getSocketFactory()));

        poolingClientConnectionManager = new PoolingClientConnectionManager(schemeRegistry);
        // Increase max total connection to 200
        poolingClientConnectionManager.setMaxTotal(200);
        // Increase default max connection per route to 20
        poolingClientConnectionManager.setDefaultMaxPerRoute(20);
        // Increase max connections for localhost:80 to 50
        HttpHost localhost = new HttpHost("localhost", 80);
        poolingClientConnectionManager.setMaxPerRoute(new HttpRoute(localhost), 50);

        cacheConfig = new CacheConfig();
        cacheConfig.setMaxCacheEntries(5000);
        cacheConfig.setMaxObjectSize(600000);
        cacheConfig.setSharedCache(false);

        // declaring the httpClient
        httpClient = new org.apache.http.impl.client.cache.CachingHttpClient(new DefaultHttpClient(poolingClientConnectionManager), cacheConfig);
        // Set timeout
        httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 30000);
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 60000);
    }

    public byte[] fetchAsByteArray(String uri){
        HttpGet request = new HttpGet(uri);
        InputStream stream = null;
        try {
            HttpContext context = HttpContextThreadLocal.get();
            HttpResponse response = httpClient.execute(request, context);

            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                try {
//                    EntityUtils.consumeQuietly(response.getEntity());
                    stream = response.getEntity().getContent();
                    return IOUtils.toByteArray(stream);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeQuietly(stream);
            request.releaseConnection();
        }
        return null;
    }

    public static void main(String[] args) {
        CachingHttpClient hc = new CachingHttpClient();
        byte[] b = hc.fetchAsByteArray("http://www.aftenposten.no/incoming/article5363753.ece/BINARY/ap-logo.png");
        b = hc.fetchAsByteArray("http://apdev1.aftenposten.no/incoming/article5363753.ece/BINARY/ap-logo.png");
        b = hc.fetchAsByteArray("http://apdev1.aftenposten.no/incoming/article5363753.ece/BINARY/ap-logo.png");
        Image image = new ImageIcon(b).getImage();
        b = hc.fetchAsByteArray("http://apdev1.aftenposten.no/incoming/article5363753.ece/BINARY/ap-logo.png");
        System.out.println("");
    }
}
