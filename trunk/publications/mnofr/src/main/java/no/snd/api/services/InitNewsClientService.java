package no.snd.api.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import neo.xredsys.api.IOAPI;
import no.snd.api.news.client.NewsClient;
import no.snd.api.news.client.exception.ServerErrorException;

import no.snd.api.processor.SNDApiProcessor;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.opensymphony.oscache.base.NeedsRefreshException;

public class InitNewsClientService extends HttpServlet implements ServletContextListener {
    public static final String NEWS_CLIENT_KEY = "SNDAPI.NewsClient";

    private final Logger logger = Logger.getLogger(getClass());
    private NewsClient newsClient = null;

    public NewsClient getNewsClient(){
        return this.newsClient;
    }

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {
    }

    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext sc = event.getServletContext();
        try {
            this.initNewsClient(sc);
        } catch (Exception e) {
            logger.error("NewsClient not initialized because of error: ", e);
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        try {
            out.print("purging cache...");
            resp.flushBuffer();
            this.initNewsClient(req.getSession().getServletContext());
            out.print("OK\nnewsclient cache purged!");
        } catch(Exception ex){
            logger.error("NewsClient not initialized because of error: ", ex);
            ex.printStackTrace();
            out.print("newsclient cache not perged because of: "+ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please use GET method.");
    }



    private void initNewsClient(ServletContext sc) throws URISyntaxException, ServerErrorException, NeedsRefreshException, Exception{
        if(isEnabled(sc)){
//            String apiUrl = sc.getInitParameter("sndApiUrl");
            String apiUrl = IOAPI.getAPI().getObjectLoader().getSectionParameter(1, "snd.api.url");
            System.out.println("InitNewsClientService: initializing NewsClient with: "+apiUrl);
            String publications = IOAPI.getAPI().getObjectLoader().getSectionParameter(1, "snd.api.publications");
            if(StringUtils.isNotEmpty(publications) && StringUtils.isNotEmpty(apiUrl)){
                System.out.println("InitNewsClientService: publications-"+publications);
                String[] pubs = StringUtils.split(publications,",");
                logger.info("InitNewsClientService: initializing NewsClient");
                sc.setAttribute(NEWS_CLIENT_KEY, new NewsClient(apiUrl,pubs));
                logger.info("InitNewsClientService: initializing NewsClient completed");
                System.out.println("InitNewsClientService: initializing NewsClient completed");
            } else {
                System.out.println("InitNewsClientService: missing publications");
            }

        }
    }


    private boolean isEnabled(ServletContext servletContext) {
        String state;
        if((state = (String) servletContext.getAttribute(SNDApiProcessor.SNDAPI_PROCESSOR_ENABLED)) == null){
            boolean enabledStatus = getConfigurationStatus();
            servletContext.setAttribute(SNDApiProcessor.SNDAPI_PROCESSOR_ENABLED, enabledStatus?"true":"false");
            return enabledStatus;
        } else {
            return "true".equals(state);
        }
    }
    private boolean getConfigurationStatus() {
        String enabled;
        boolean enabledStatus = false;
        if((enabled = System.getProperty("snd.api.enabled","false")) != null){
            enabledStatus = "true".equals(enabled);
        }
        System.out.println("SNDApiProcessor snd.api.enabled-"+enabledStatus);
        return enabledStatus;
    }

}
