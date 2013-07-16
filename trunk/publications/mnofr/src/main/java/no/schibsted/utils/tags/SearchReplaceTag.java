package no.schibsted.utils.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;

/**
 * This is a taglib performs a search and replace in the body.
 * <p/>
 * Date: 24.07.12
 * Time: 08:30
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class SearchReplaceTag extends BodyTagSupport {
    private String regexp;
    private String replaceWith;

    /**
     * Regular expression
     *
     * @param regexp
     */
    public void setRegexp(String regexp) {
        this.regexp = regexp;
    }

    /**
     * Replace with.
     *
     * @param replaceWith
     */
    public void setReplaceWith(String replaceWith) {
        this.replaceWith = replaceWith;
    }

    @Override
    public int doAfterBody() throws JspException {
        BodyContent bodycontent = getBodyContent();
        String body = bodycontent.getString();
        JspWriter out = bodycontent.getEnclosingWriter();
        try {
            out.print(body.replaceAll(regexp, replaceWith));
        } catch (IOException e) {
            throw new JspException("Error:" + e.getMessage());
        }
        return SKIP_BODY;
    }
}
