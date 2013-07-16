package no.mnopolaris.adtech.tags.mobile;

import no.medianorge.utils.HttpUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Klasse laget av Media Norge Digital.
 * User: reanberg
 * Date: Jan 18, 2011
 * Time: 10:10:08 AM
 * <p/>
 * <p/>
 * You may think you know what the following code does.
 * But you dont. Trust me.
 * Fiddle with it, and youll spend many a sleepless
 * night cursing the moment you thought youd be clever
 * enough to "optimize" the code below.
 * Now close this file and go play with something else.
 */
public class AdTechRawTag extends TagSupport {
    private String urlToRawAd = "";
        private HttpUtil httpUtil = null;

        private String varHref = "varHref";
        private String varImg = "varImg";
        private boolean debug = false;

        public AdTechRawTag(){
            httpUtil = new HttpUtil();
        }

        public void setUrlToRawAd(String u){
            this.urlToRawAd = u;
        }

        public void setVarHref(String v){
            this.varHref = v;
        }

        public void setVarImg(String v){
            this.varImg = v;
        }

        public void setDebug(boolean b){
            this.debug = b;
        }


        public int doStartTag() throws JspException {
            boolean isOk = true;
            String body = httpUtil.getHtml(urlToRawAd);
            if(!body.equals("")){
                Pattern pattern = Pattern.compile("href=\\\"(.*?)\\\".*src=\\\"(.*?)\\\"");
                Matcher matcher = pattern.matcher(body);
                String href = "";
                String imgSrc = "";
                while(matcher.find()){
                    href = matcher.group(1);
                    imgSrc = matcher.group(2);
                }
                deb("found [" + href + "]");
                deb("found [" + imgSrc + "]");
                pageContext.setAttribute(varHref, href);
                pageContext.setAttribute(varImg, imgSrc);

            }else{
                isOk = false;
            }

            if(isOk){
                return EVAL_BODY_INCLUDE;
            }else{
                return SKIP_BODY;
            }
        }

        private void deb(String d){
            if(debug){
                System.out.println("<>" + d);
            }
        }

}
