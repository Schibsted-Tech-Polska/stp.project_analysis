<%@ page import="com.escenic.viziwyg.ViziwygHelper" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-profile" prefix="profile" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type='text/javascript' src='${requestScope.resourceUrl}js/jquery-1.3.2.min.js'></script>
<script type='text/javascript' src='${requestScope.resourceUrl}js/jquery-ui-1.7.3.custom.min.js'></script>
<script type='text/javascript' src='${requestScope.resourceUrl}js/tiny_mce/tiny_mce.js'></script>
<script type='text/javascript' src='${requestScope.resourceUrl}js/jquery.contextMenu.js'></script>
<script type='text/javascript' src='${requestScope.resourceUrl}js/jquery.Jcrop.js'></script>

<script type='text/javascript'>
  /*
  This will reassign the '$' variable to its previous value before the jquery JS file is loaded.
  All InPage related JS code must use 'jQueryInpage' variable to access JQuery functions in stead of using '$' directly.
  However, it is possible assign '$' to 'jQueryInpage' locally and use it.

  The use of 'noConflict()' method will allow template developers to use their version of JQuery and other JQuery plugins.
  */
  var jQueryInpage = jQuery.noConflict(true);
</script>
<script type='text/javascript' src='<util:valueof param="publication.url"/>js/inpage.min.js'></script>

<link rel="stylesheet" type="text/css" media="screen" href="${requestScope.skinUrl}css/jquery-ui-1.7.3.custom.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${requestScope.skinUrl}css/inpage.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${requestScope.skinUrl}css/jquery.contextMenu.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${requestScope.skinUrl}css/jquery.Jcrop.css"/>

<profile:present>
    <%
      ViziwygHelper viziwygHelper = new ViziwygHelper();

      String authToken = viziwygHelper.getBasicHTTPAuthToken(request.getSession());
      boolean isUserPresent = StringUtils.isNotBlank(authToken);
    %>

    <script>
      jQueryInpage(function() {
        var userPresent = <%=isUserPresent%>;
        if (userPresent) {
          var pViziwygWsUrl = "${section.parameters['inpage.webservice.url']}";
          var isViziwygEnabled = "${section.parameters['inpage.enabled']}";
          if(isViziwygEnabled != null){
            isViziwygEnabled = "${section.parameters['inpage.enabled']}";
          }

          var viziwygConfig = {
            viziwygURL : pViziwygWsUrl,
            authHeader : 'Basic <%=authToken%>',
            sectionEnabled : isViziwygEnabled
          };
          InPage.init(viziwygConfig);
        }
      });
    </script>
</profile:present>