package no.mnopolaris.adtech.tags;

import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.JspException;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import java.io.IOException;
import org.apache.log4j.Logger;

/**
 * AdTech Taglib Project
 * @author Roar Stette - roar.stette@adresseavisen.no
 * @date 11.11.2010
 *
 * Originally created by Andre Foyn Berge (reanberg) - Aftenposten. Feb 9, 2010 - 12:48:24 PM
 * Updated by Andreas Rosdal - Adresseavisen.
 * Renewed and extended by Roar Stette - Adresseavisen, Thomas Orten - Media Norge Digital.
 */
public class AdTechElementTag extends TagSupport {

	/* Log */
	protected final Logger logger = Logger.getLogger(getClass());
	/* Prefix helios request params */
	private final static String advertPrefix = "adtech.";
    /* ID var for ad-tag */
	private String id = null;
	/* Helios placement ID */
	private String name;
	/* Helios string ad keys - pattern: key1+key2+key3...key9 - Max 9 keys. */
	private String keys;
	/* Type of ad output */
	private String type;
	/* Helios fallback ID for placement */
	private String fallbackId;
    /* Companion ads for placement */
    private Map companionAds;
    /* extra parameters */
    private String extraParams = "";
    /* sizeId for ad */
    private String sizeId = "-1";

	/* Inits */
	public void setId(String id) {
        this.id = id;
    }
	
    public void setName(String name) {
        this.name = name;
    }

	public void setKeys(String keys) {
        this.keys = keys;
    }

	public void setType(String type) {
        this.type = type.toLowerCase();
    }

	public void setFallbackId(String fallbackId) {
        this.fallbackId = fallbackId;
    }

    public void setCompanionAds(Map companionAds) {
        this.companionAds = companionAds;
    }

    public void setExtraParams(String extraParams){
        this.extraParams = extraParams;
    }

    public void setSizeId(String sizeId){
        this.sizeId = sizeId;
    }


	/**
	 * Get ad-tag
	 * @throws javax.servlet.jsp.JspException
	 */
	@Override
    public int doStartTag() throws JspException {

        try {
			// Create request.
            HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
			// Get helios ID.
			String heliosId = (String) request.getAttribute(advertPrefix + "heliosId");
			// Get helios fallback ID.
			String heliosFallbackId = (String) request.getAttribute(advertPrefix + "heliosFallbackId");
			// Get helios Srv.
			String heliosSrv = (String) request.getAttribute(advertPrefix + "heliosSrv");
			// Get current page.
			String currentPage = (String) request.getAttribute(advertPrefix + "heliosPage");
			// Get groupId.
			String groupId = (String) request.getAttribute(advertPrefix + "heliosGroupId");
			// Get helios website.
			String heliosWebsite = (String) request.getAttribute(advertPrefix + "heliosWebsite");

			// Log message.
			logger.debug("AdTech placement '"+ name +"' : "+ heliosWebsite +", "+ currentPage +" - type="+ type +", groupId="+ groupId +", fallbackId="+ fallbackId + ", (heliosFallbackId="+ heliosFallbackId +", heliosID="+ heliosId + ", heliosSrv="+ heliosSrv +"), extraParams" + extraParams);

			// Die silent if no attributes.
			if (heliosId == null || currentPage == null || heliosSrv == null) {
				logger.error("AdTech params - Empty parameter found : heliosID="+ heliosId + ", page="+ currentPage + ", heliosSrv="+ heliosSrv);
				return SKIP_BODY;
			}

			// Placement to get.
            String propertyKey = currentPage + "." + name;

			// Get page for request.
			Map propKeys = (Map) request.getAttribute(advertPrefix + currentPage);

			// Die silent if no attributes.
            if (propKeys == null) {
				logger.error("AdTech properties - "+ heliosWebsite +", "+ currentPage +" : No properties");
				return SKIP_BODY;
			}

			// Get ID for AD.
            String heliosAdID = (String) propKeys.get(propertyKey);

			// Output or not.
			if (heliosAdID != null) {
				// Log message.
				logger.info("AdTech placement '"+ name +"'");
				logger.debug("AdTech placement '"+ name +"' : "+ heliosWebsite +", "+ currentPage +" - Active");

                // Companion ads, output or not
                HashMap activeCompanions = new HashMap();
                Iterator itr = companionAds.entrySet().iterator();
                while (itr.hasNext()) {
                   Map.Entry pairs = (Map.Entry)itr.next();
                   String propKey = currentPage + '.' + pairs.getKey();
                   String companionAdID = (String) propKeys.get(propKey);
                   if (companionAdID != null) {
                      activeCompanions.put(pairs.getKey().toString(), companionAdID);
                   }
                }

				// Get Ad-tag.
				String output = adTag(heliosAdID, activeCompanions, heliosFallbackId, heliosId, heliosSrv, groupId, currentPage, heliosWebsite);

				if (id != null) {
					// Output AD as ID var.
					pageContext.setAttribute(id, output);
				} else {
					// Ouput direct.
					try {
                        pageContext.getOut().write(output);
                    } catch (IOException e) {
	                    logger.fatal("AdTech crash - "+ heliosWebsite +", "+ currentPage +", placement '"+ name +"' : " + e.getMessage());
						return SKIP_BODY;
                    }
				}
			} else {
				// Debug msg.
				logger.debug("AdTech placement '" + name + "' - " + heliosWebsite + ", " + currentPage + " : Not active");
				return SKIP_BODY;
			}
			
        } catch (Exception e) {
            logger.fatal("AdTech crash - placement '"+ name +"' : " + e.getMessage());
        }
        return SKIP_BODY;
    }

	/**
	 * AD TAG.
	 * @param String type
	 * @param String adId
	 * @param String heliosId
	 * @return String
	 */
	private String adTag(String adId, HashMap activeCompanionAds, String heliosFallbackId, String heliosId, String heliosSrv, String groupId, String currentPage, String heliosWebsite) {

		// Fallback ID
		String adFallbackId = "0000000";
		if(fallbackId != null && fallbackId.length() > 0) {
			adFallbackId = fallbackId;
		}
		else if(heliosFallbackId != null && heliosFallbackId.length() > 0) {
			adFallbackId = heliosFallbackId;
		} else {
			logger.warn("AdTech placement '"+ name +"' - "+ heliosWebsite +","+ currentPage +" : No fallbackId.");
		}

		// Key Tags
		String keyTags = "";
		if(keys != null && keys.length() > 0) {
			// Test keys pattern.
			if(keys.matches("\\w{1,9}+")){
				keyTags = "key=" + keys +";";
			} else {
				logger.warn("AdTech placement '"+ name +"' - "+ heliosWebsite +","+ currentPage +" : Wrong key pattern ( "+ keys +" ) != key+key+key... (max 9).");
			}
		}

		// Group ID
		String adGroupId = "[group]";
		if(groupId != null && groupId.length() > 0) {
			adGroupId = groupId;
		} else {
			logger.warn("AdTech placement '"+ name +"' - "+ heliosWebsite +","+ currentPage +" : Using serverside [group] parameter");
		}

        // Companion ads
		String companionAdStr = "";
		Iterator itr = activeCompanionAds.entrySet().iterator();
        while (itr.hasNext()) {
           Map.Entry pairs = (Map.Entry)itr.next();
           companionAdStr += "adtech.setCompanion('"+ pairs.getKey().toString().toLowerCase() +"','"+ pairs.getValue() +"','http://"+ heliosSrv +"/addyn|3.0|"+ heliosId +"|"+ adFallbackId +"|0|-1|ADTECH;cookie=info;alias="+ pairs.getValue() +";loc=100;"+ keyTags +"grp="+ adGroupId +";target=_blank;misc=');\n";
        }

		// Tag container.
		String tag = "";
		// Default - Javascript
		if(type == null || type.length() == 0 || type.equals("javascript")) {
        //    tag  =	"<script type=\"text/javascript\" src=\"http://"+ heliosSrv +"/addyn|3.0|"+ heliosId +"|"+ adFallbackId +"|0|-1|ADTECH;cookie=info;alias="+ adId +";loc=100;"+ keyTags +"grp="+ adGroupId +";target=_blank;misc=[timestamp]\"></script>\n";
            tag = "<script type=\"text/javascript\">\n";
            //tag +=	"<script type=\"text/javascript\" src=\"http://"+ heliosSrv +"/addyn|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;cookie=info;alias="+ adId +";loc=100;"+ keyTags +"grp="+ adGroupId + ";" + extraParams +";target=_blank;misc=" + new Date().getTime() + "\"></script>\n";
            tag +=	"document.write('<scr'+'ipt type=\"text/javascript\" src=\"http://"+ heliosSrv +"/addyn|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;cookie=info;alias="+ adId +";loc=100;"+ keyTags +"grp="+ adGroupId + ";" + extraParams +";target=_blank;misc=" + new Date().getTime() + "\"></scr'+'ipt>');\n";
            tag += "</script>\n";

            tag +=	"<noscript>\n";
			tag +=	"\t<a href=\"http://"+ heliosSrv +"/adlink|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId + ";" + extraParams + "\" target=\"_blank\">\n";
			tag +=	"\t\t<img src=\"http://"+ heliosSrv +"/adserv|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId + ";" + extraParams + "\" alt=\"Alt-Text\" />\n";
			tag +=	"\t</a>\n";
			tag +=	"</noscript>";
		}
		// Image
		else if(type.equals("image")) {
			tag  =	"<a href=\"http://"+ heliosSrv +"/adlink|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId +";" + extraParams + "\" target=\"_blank\">\n";
			tag +=	"\t<img src=\"http://"+ heliosSrv +"/adserv|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId +";" + extraParams + "\" alt=\"Alt-Text\" />\n";
			tag +=	"</a>";
		}
		// Newsletter
		else if(type.equals("newsletter")) {
			tag  =	"<a href=\"http://"+ heliosSrv +"/adlink|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=no;"+ keyTags +"grp="+ adGroupId +";" + extraParams +"\" target=\"_blank\">\n";
			tag +=  "\t<img src=\"http://"+ heliosSrv +"/adserv|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=no;uid=no;"+ keyTags +"grp="+ adGroupId +";" + extraParams + "\" alt=\"Alt-Text\" />\n";
			tag +=	"</a>";
		}
		// RAW - Requires Helios setup. Contact support.
		else if(type.equals("raw")) {
			tag  =	"http://"+ heliosSrv +"/?adrawdata/3.0/"+ heliosId +"/"+ adFallbackId +"/0/" + sizeId + "/header=yes;cookie=no;adct=204;grp"+ adGroupId +"";
		}
		// XML
		else if(type.equals("xml")) {
			tag  =  "http://"+ heliosSrv +"/?adxml/3.0/"+ heliosId +"/"+ adFallbackId +"/0/" + sizeId + "/rettype=img;size=;alias="+ adId +";header=yes;cookie=no;"+ keyTags;
		}
		// Async
		else if(type.equals("async") || type.equals("asyncfif") || type.equals("jquerydocready")) {
            tag =  "<script id=\"load"+ name.toLowerCase() +"\" type=\"text/javascript\">\n";
            if(type.equals("jquerydocready")) tag += "$(document).ready(function() { ";
            tag += "/*<![CDATA[*/\n";
            tag += "if (typeof adtech === 'object') {";
            tag += companionAdStr;
            if(type.equals("async")) {
               tag += "adtech.loadAd('"+ name.toLowerCase() +"','"+ adId +"','http://"+ heliosSrv +"/addyn|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;cookie=info;alias="+ adId +";loc=100;"+ keyTags +"grp="+ adGroupId +";target=_blank;misc=','"+ adGroupId +";" + extraParams + "');\n";
            } else {
               tag += "adtech.loadFIF('"+ name.toLowerCase() +"','"+ adId +"','"+ adGroupId +"', '" + extraParams  + "');\n";
            }
            tag += "}";
            tag += "/*]]>*/\n";
            if(type.equals("jquerydocready")) tag += " });\n";
            tag +=  "</script>";
		    tag +=	"<noscript>\n";
		    tag +=	"\t<a href=\"http://"+ heliosSrv +"/adlink|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId +";" + extraParams + "\" target=\"_blank\">\n";
			tag +=	"\t<img src=\"http://"+ heliosSrv +"/adserv|3.0|"+ heliosId +"|"+ adFallbackId +"|0|" + sizeId + "|ADTECH;loc=300;alias="+ adId +";cookie=info;"+ keyTags +"grp="+ adGroupId +";" + extraParams + "\" alt=\"Alt-Text\" />\n";
			tag +=	"\t</a>\n";
			tag +=	"</noscript>";
		}
        // Companion Ad, legacy. To be removed
         else if(type.equals("companion")) {
            tag =  "<script type=\"text/javascript\">\n";
            tag += "/*<![CDATA[*/\n";
            tag += "if (typeof adtech === 'object') {";
            tag += "adtech.setCompanion('"+ name.toLowerCase() +"','"+ adId +"');\n";
            tag += "}";
            tag += "/*]]>*/\n";
            tag +=  "</script>";
        }
		// else output error msg and do nothing.
		else {
			logger.warn("AdTech placement '"+ name +"' - "+ heliosWebsite +","+ currentPage +" : Wrong type ( "+ type +" ). Available types are: ('' - default)javascript, image, newsletter, raw, xml, jQuery, jQueryDocReady");
		}

		return tag;
	}
}