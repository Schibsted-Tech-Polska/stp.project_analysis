package com.escenic.framework.servlet.loggedin;

import com.escenic.presentation.servlet.GenericProcessor;
import com.escenic.profile.presentation.struts.RepresentativeUser;
import com.escenic.servlet.Constants;
import com.ndc.usercontent.KeyConstants;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * This filter sets an HTTP header if a user is logged in. It can be used in the caching server to determine if a user
 * is logged in or not. This can be useful to throw away cookies if the user is not logged in anyway.
 *
 * @author marc@escenic.com
 */
public class LoggedinFilter extends GenericProcessor implements Constants {
   /**
    * HTTP header to be set
    */
   private String mHeader = null;

   /**
    * Constructor.
    */
   public LoggedinFilter() {
      mLogger.debug("Constructed LoggedinFilter");
   }

   /**
    * Sets the header name of the HTTP header set by this filter.
    *
    * @param pHeader the header name.
    */
   public void setHeader(String pHeader) {
      mHeader = pHeader;
   }

   /**
    * Returns the HTTP header name.
    *
    * @return the header name.
    */
   public String getHeader() {
      return mHeader;
   }

   public boolean doBefore(final ServletContext pContext, final ServletRequest pRequest, final ServletResponse pResponse) throws IOException, ServletException {
      if (pRequest instanceof HttpServletRequest && pResponse instanceof HttpServletResponse) {
         HttpServletRequest request = (HttpServletRequest) pRequest;
         HttpServletResponse response = (HttpServletResponse) pResponse;

         // Community Engine objects
         Object presentationUser = request.getSession().getAttribute(KeyConstants.SESSION_PRESENTATION_USER_KEY);
         Object communityUser = request.getSession().getAttribute(KeyConstants.SESSION_USER_KEY);

         // Escenic Profile object
         Object profileUser = request.getSession().getAttribute("user");

         if (mLogger.isDebugEnabled()) {
            mLogger.debug(String.format("%s: %s, %s: %s, %s: %s",
                  KeyConstants.SESSION_PRESENTATION_USER_KEY, presentationUser,
                  KeyConstants.SESSION_USER_KEY, communityUser,
                  "user", profileUser));
         }
         if (presentationUser != null || communityUser != null || profileUser instanceof RepresentativeUser) {
            if (mLogger.isDebugEnabled()) {
               mLogger.debug("Setting header " + getHeader());
            }

            response.addHeader(getHeader(), "true");
         } else if (mLogger.isDebugEnabled()) {
            mLogger.debug("Not setting header " + getHeader());
         }
      }
      return true;
   }

}