package no.mnopolaris.adtech.tags;

import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.JspException;
import javax.servlet.http.HttpServletRequest;
import java.util.Properties;
import java.util.Iterator;
import java.util.Map;
import java.util.HashMap;
import java.io.FileInputStream;
import org.apache.log4j.Logger;

/**
 * AdTech Taglib Project
 * Requires adtech .properties files generated from 'AdTech API'.
 * @author Roar Stette - roar.stette@adresseavisen.no
 * @date 11.11.2010
 *
 * Originally created by Andre Foyn Berge (reanberg) - Aftenposten. Feb 9, 2010 - 12:48:24 PM
 * Updated by Andreas Rosdal - Adresseavisen.
 * Renewed and extended by Roar Stette - Adresseavisen.
 */
public class AdTechInitTag extends TagSupport {

	/* Log */
	protected final Logger logger = Logger.getLogger(getClass());
    /* Suffix for adtech files */
	private final static String URLsuffix = ".properties";
    /* Prefix helios request params */
	private final static String advertPrefix = "adtech.";
	/* Helios group ID - random unique for page scope */
	private int groupId = (int) Math.round(Math.random() * 1000000000);
    /* Helios account ID */
	private String heliosId;
	/* Helios default server url */
	private String heliosSrv = "adserver.adtech.de";
	/* Helios website ID */
    private String website;
	/* Helios Page - ID for properties-file */
	private String page;
	/* Helios properties path - Path to properties-fiels. Lists of active placements for page */
    private String propertiesPath;
	/* Helios global fallback ID */
	private String fallbackId;

	public void setHeliosId(String heliosId) {
        this.heliosId = heliosId.toLowerCase();
    }

	public void setHeliosSrv(String heliosSrv) {
        this.heliosSrv = heliosSrv.toLowerCase();
    }
	
    public void setWebsite(String website) {
        this.website = website.toLowerCase();
    }
	
	 public void setPage(String page) {
        this.page = page;
    }

    public void setPropertiesPath(String propertiesPath) {
        this.propertiesPath = propertiesPath;
    }

	public void setFallbackId(String fallbackId) {
        this.fallbackId = fallbackId;
    }

    /**
     * Init helios parameters.
     * @throws javax.servlet.jsp.JspException
     */
	@Override
    public int doStartTag() throws JspException {

		// Log message
		logger.debug("AdTech init: heliosId="+ heliosId +", website="+ website +", page="+ page +" propertiesPath="+ propertiesPath +", groupId="+ groupId+", fallbackId="+ fallbackId);

		// Die silent if params is missing
        if (heliosId.length() == 0 || page.length() == 0 || website.length() == 0 || propertiesPath.length() == 0) {
			logger.error("AdTech init - Empty parameter found : heliosId=" + heliosId + ", heliosNewspaper=" + website + ", heliosPage=" + page + ", propertiesPath=" + propertiesPath);
            return SKIP_BODY;
        }

		// Properties.
		Properties props = new Properties();

        try {

			// Load properties file for current newspaper and page.
            props.load(new FileInputStream(propertiesPath + website + "_" + page.toLowerCase() + URLsuffix));
			
            Iterator itr = props.keySet().iterator();
            Map keysToRequest = new HashMap();
            // Get placement values
			while (itr.hasNext()) {
                String key = (String) itr.next();
                keysToRequest.put(key, props.get(key));
            }
                                      
			// Create request.
			HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
			// Set Ad Placements
            request.setAttribute(advertPrefix + page, keysToRequest);
			// Set Ad heliosID
            request.setAttribute(advertPrefix + "heliosId", heliosId);
			// Set Ad heliosWebsite
            request.setAttribute(advertPrefix + "heliosWebsite", website);
			// Set Ad heliosPage
            request.setAttribute(advertPrefix + "heliosPage", page);
			// Set Ad heliosFallbackId
            request.setAttribute(advertPrefix + "heliosFallbackId", fallbackId);
			// Set Ad server
            request.setAttribute(advertPrefix + "heliosSrv", heliosSrv);
			// Set Ad groupId
            request.setAttribute(advertPrefix + "heliosGroupId", Integer.toString(groupId));

			// Log messages
			logger.info("AdTech initialized - " + website + "," + page);
			logger.debug("AdTech properties - " + website + "," + page + " : " + keysToRequest.toString());

        } catch (Exception e) {
            logger.fatal("AdTech crashed - " + website + "," + page + " : " + e.getMessage());
        }
        return SKIP_BODY;
    }
}