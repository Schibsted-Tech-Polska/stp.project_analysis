package no.schibsted.utils.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;

/**
 * This is a taglib stripping away whitespaces between tags.
 * <p/>
 * Date: 24.07.12
 * Time: 08:30
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class WhiteSpaceStripperTag extends BodyTagSupport {
    private String doubleSpace;

    /**
     * Defines whether to strip double space or not.
     *
     * @param doubleSpace
     */
    public void setDoubleSpace(String doubleSpace) {
        this.doubleSpace = doubleSpace;
    }

    @Override
    public int doAfterBody() throws JspException {
        BodyContent bodycontent = getBodyContent();
        String body = bodycontent.getString();
        JspWriter out = bodycontent.getEnclosingWriter();
        try {
            if("true".equalsIgnoreCase(doubleSpace)){
                out.print(body.replaceAll(">(\\s+?)<", "> <"));
            } else {
                out.print(body.replaceAll(">(\\s+?)<", "><"));
            }
        } catch (IOException e) {
            throw new JspException("Error:" + e.getMessage());
        }
        return SKIP_BODY;
    }
}
