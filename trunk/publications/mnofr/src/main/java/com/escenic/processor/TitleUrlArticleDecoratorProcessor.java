package com.escenic.processor;
/**
 * Created by IntelliJ IDEA.
 * User: torillkj
 * Date: 09.nov.2010
 * Time: 15:23:52
 * To change this template use File | Settings | File Templates.
 */

import com.escenic.presentation.servlet.GenericProcessor;
import com.escenic.servlet.Constants;
import neo.xredsys.config.ServerConfig;

import javax.servlet.ServletRequest;
import javax.servlet.ServletContext;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;


public class TitleUrlArticleDecoratorProcessor extends GenericProcessor implements Constants {

    private ServerConfig serverConfig;

    public ServerConfig getServerConfig() {
        return serverConfig;
    }

    public void setServerConfig(ServerConfig serverConfig) {
        this.serverConfig = serverConfig;
    }

    public boolean doBefore(ServletContext pContext, ServletRequest pServletRequest, ServletResponse pServletResponse)
            throws IOException, ServletException {
        String remainingPath = (String) pServletRequest.getAttribute(Constants.COM_ESCENIC_CONTEXT_PATH);
        if (mLogger.isDebugEnabled()) {
            mLogger.debug("Remaining path: " + remainingPath);
        }

        int articleID = 0;
        if (remainingPath != null && remainingPath.length() > 0) {
            int indexOfHtml;
            if ((indexOfHtml = remainingPath.indexOf(".html")) > 0) {
                try {
                    String sArticleId  = remainingPath.substring(remainingPath.lastIndexOf("-") + 1, indexOfHtml);
                    articleID = Integer.parseInt(sArticleId);
                } catch (Exception e) {
                    /* cant find an Id, trying other filters */
                    /* not an article, allow other filters to figure out what the context is.*/
                }
            }
        }

        if (articleID > 0) {
            if (mLogger.isDebugEnabled()) {
                mLogger.debug("Found article ID: " + articleID);
            }
            //System.out.println("Found article ID: " + articleID);
            //If these attributes are not set then an error will occur further on down in
            //the Escenic machinery, and user will be directed to error-page
            pServletRequest.setAttribute(Constants.COM_ESCENIC_CONTEXT, "art");
            pServletRequest.setAttribute(Constants.COM_ESCENIC_CONTEXT_ARTICLE_ID, articleID);
            pServletRequest.setAttribute(Constants.COM_ESCENIC_CONTEXT_PATH, "");
        }
        return true;
    }

    private void print(Object message) {
        System.out.println(message);
    }
}