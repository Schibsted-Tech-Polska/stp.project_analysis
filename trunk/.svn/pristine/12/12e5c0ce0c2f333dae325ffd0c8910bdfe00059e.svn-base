<%@ page import="neo.xredsys.api.Section" %>
<%@ page import="neo.xredsys.presentation.PresentationArticle" %>
<%@ page import="neo.xredsys.presentation.PresentationElement" %>
<%@ page import="neo.xredsys.presentation.PresentationLoader" %>
<%@ page import="neo.xredsys.presentation.PresentationPool" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="publication" scope="request" type="neo.xredsys.api.Publication"/>
<jsp:useBean id="section" scope="request" type="neo.xredsys.api.Section"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--declare the map that will contain view specific field values --%>
<jsp:useBean id="rssfeed" type="java.util.Map" scope="request" />


<c:set var="rssArts" value="<%= getArticles(application, section) %>" />
<c:set target="${rssfeed}" property="articles" value="${rssArts}" />
<c:set var="max" value="${fn:trim(element.fields.maxArticles.value)}" />

<c:choose>
  <c:when test="${fn:length(rssfeed.articles) > max}">
    <c:set target="${rssfeed}" property="maxArticles" value="${max}"/>
  </c:when>
  <c:otherwise>
    <c:set target="${rssfeed}" property="maxArticles" value="${fn:length(rssfeed.articles)}"/>
  </c:otherwise>
</c:choose>


<%!
  Set<PresentationArticle> getArticles(ServletContext pServletContext, Section pSection) {
    PresentationLoader pl = (PresentationLoader) pServletContext.getAttribute("com.escenic.presentation.PresentationLoader");
    PresentationPool pool = pl.getActivePool(pSection.getId());

    return getArticles(pool.getRootElement());
  }

  Set<PresentationArticle> getArticles(PresentationElement pElement) {
    Set<PresentationArticle> list = new TreeSet<PresentationArticle>(new Comparator<PresentationArticle>() {
      // Sort by publish date (descending)
      public int compare(PresentationArticle p1, PresentationArticle p2) {
        return p2.getPublishedDateAsDate().compareTo(p1.getPublishedDateAsDate());
      }
    });
    if (pElement.getAreas() != null) {
      Map<String, PresentationElement> areas = pElement.getAreas();
      for (String area: pElement.getAreas().keySet()) {
        // Don't include articles from the "breaking news" area
        if (!"breakingnews".equals(area)) {
          list.addAll(getArticles(areas.get(area)));
        }
      }
    }
    if (pElement.getItems() != null) {
      for (PresentationElement element: pElement.getItems()) {
        list.addAll(getArticles(element));
      }
    }
    if (pElement.getContent() != null) {
      PresentationArticle content = pElement.getContent();
      // Filter content types: TODO add additional types?
      if ("news".contains(content.getArticleTypeName())) {
          
        list.add(pElement.getContent());
      }
    }
    return list;
  }

%>