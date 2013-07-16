package no.snd.api.processor;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import neo.xredsys.api.IOAPI;
import no.snd.api.beans.SNDArticle;
import no.snd.api.news.client.NewsClient;
import no.snd.api.services.InitNewsClientService;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

import com.escenic.presentation.servlet.GenericProcessor;
import com.escenic.servlet.Constants;

/**
 * The SNDApiProcessor is wired into the processor chain and process requests of uri's ending with .snd
 *
 * User: hanmile
 * Date: 03.okt.2012
 * Time: 12:38:03
 * To change this template use File | Settings | File Templates.
 */
public class SNDApiProcessor extends GenericProcessor implements Constants{
    public static final String SNDAPI_PROCESSOR_ENABLED = "SNDAPI.enabled";
    private static final String API_TEST_URL = "http://apitestbeta3.medianorge.no/news/";
    public static final String NEWSCLIENT_API = "newsClient";
    private static final String NEWS_CLIENT_IS_LOADING = "newsClientIsLoading";

    // publications to cache
    private String[] systems = {"","common","ap","bt","sa","fvn"};


    public boolean doBefore(ServletContext pContext, ServletRequest pServletRequest, ServletResponse pServletResponse) throws IOException, ServletException {

        if(isEnabled(pContext)){
            String remainingPath = (String) pServletRequest.getAttribute(Constants.COM_ESCENIC_CONTEXT_PATH);
        /*
            Check if the user is looking for a snd api article. If not, return true and leave the rest of
            the processing to the other Escenic filters.
         */
            if ((remainingPath != null) && (remainingPath.indexOf(".snd")) > 0) {

                int iIndexOfSnd = remainingPath.indexOf(".snd");
                int iArticleId = 0;
                int systemId = 1;

                try {
                    /**
                     * Storing the newsClient into the application scope.
                     */
                    System.out.println("Test: "+pContext.toString());
                    System.out.println("Test: "+((HttpServletRequest)pServletRequest).getSession().getServletContext().toString());
                    NewsClient newsClient = (NewsClient)pContext.getAttribute(InitNewsClientService.NEWS_CLIENT_KEY);

                    //Retrieve articleId
                    String articleElement = remainingPath.substring(remainingPath.lastIndexOf("-") + 1, iIndexOfSnd);
                    if(articleElement.contains("_")){
                        iArticleId = Integer.parseInt(StringUtils.substringBefore(articleElement,"_"));
                        systemId = Integer.parseInt(StringUtils.substringAfter(articleElement, "_"));
                    } else {
                        // fallback
                        iArticleId = Integer.parseInt(articleElement);
                    }
                    System.out.println("Fetching article: "+iArticleId+", "+systems[systemId]);
                    SNDArticle sndArticle = newsClient.getSNDArticle(iArticleId, systems[systemId]);
                    pServletRequest.setAttribute("sndArticle", sndArticle);
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("Something went wrong");
                }
                System.out.println("API processor" + remainingPath + iArticleId);
                pServletRequest.setAttribute(Constants.COM_ESCENIC_CONTEXT, "sec");
                pServletRequest.setAttribute(Constants.COM_ESCENIC_CONTEXT_PATH, "");
            } else {
                /**
                 * Resolves path element after tags/.
                 * ie: /nyheter/sport/tourdefrance/tags/sport:football:team:AC_Milan/sport
                 * tourdefrance is the only valid section
                 * The remainpath, - will contain, -the rest of the path, - after the valid section.
                 */
                String pathToken;
                if((pathToken = (String) pServletRequest.getAttribute("pathToken")) == null){
                    String defaultPathToken = "tags/";
                    if((pathToken = IOAPI.getAPI().getObjectLoader().getSectionParameter(1, "snd.api.path.token")) == null){
                        pathToken = defaultPathToken;
                    }
//                    System.out.println("pathToken: "+pathToken);
                    pServletRequest.setAttribute("pathToken",pathToken);
//                    System.out.println("remainingPath:"+remainingPath);
//                    System.out.println("request:"+pServletRequest.toString());
                }
                if(remainingPath.startsWith(pathToken)){
//                    System.out.println("no.snd.path.element-"+remainingPath);
                    pServletRequest.setAttribute("no.snd.path.element",remainingPath);
                    pServletRequest.setAttribute("com.escenic.context.path","");
                }
            }
        }
        return true;
    }

    private boolean isEnabled(ServletContext servletContext) {
        String state;
        if((state = (String) servletContext.getAttribute(SNDAPI_PROCESSOR_ENABLED)) == null){
            Boolean enabledStatus = getConfigurationStatus();
            servletContext.setAttribute(SNDAPI_PROCESSOR_ENABLED, enabledStatus?"true":"false");
            return enabledStatus;
        } else {
            return "true".equals(state);
        }
    }

    private boolean getConfigurationStatus() {
        String enabled;
        Boolean enabledStatus = false;
        if((enabled = System.getProperty("snd.api.enabled","false")) != null){
            enabledStatus = "true".equals(enabled);
        }
        System.out.println("SNDApiProcessor snd.api.enabled-"+enabledStatus);
        return enabledStatus;
    }

}
