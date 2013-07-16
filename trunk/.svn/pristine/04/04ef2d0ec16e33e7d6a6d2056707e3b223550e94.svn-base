//
//package no.medianorge.search;
//
//import ap.util.ApSearch;
//import com.fastsearch.esp.search.navigation.IAdjustment;
//import com.fastsearch.esp.search.navigation.IAdjustmentGroup;
//import com.fastsearch.esp.search.navigation.Navigation;
//import com.fastsearch.esp.search.query.IQuery;
//import com.fastsearch.esp.search.query.Query;
//import com.fastsearch.esp.search.result.IModifier;
//import com.fastsearch.esp.search.result.IQueryResult;
//import com.fastsearch.esp.search.view.ISearchView;
//import com.fastsearch.esp.sfeapi.searchservice.Search;
//import com.fastsearch.esp.sfeapi.searchservice.SearchResult;
//import com.fastsearch.esp.sfeapi.searchservice.SearchService;
//import com.fastsearch.esp.sfeapi.searchservice.search.NavigationInput;
//import com.fastsearch.esp.sfeapi.searchservice.search.SimpleSearch;
//import com.fastsearch.espimpl.sfe.form.SearchForm;
//import com.fastsearch.espimpl.sfeapi.searchservice.SearchServiceImpl;
//import com.fastsearch.espimpl.sfeapi.searchservice.search.NavigationInputImpl;
//import com.fastsearch.espimpl.sfeapi.searchservice.search.SimpleSearchImpl;
//import neo.xredsys.api.Section;
//import org.apache.commons.codec.binary.Base64;
//import org.springframework.beans.factory.xml.XmlBeanFactory;
//import org.springframework.core.io.ClassPathResource;
//import org.springframework.mock.web.MockHttpServletRequest;
//import org.springframework.mock.web.MockServletContext;
//import org.springframework.util.StringUtils;
//
//import java.util.Iterator;
//
//
///*
//*
// * User: itlihart
// * Date: 22.nov.2010
// * Time: 14:06:47
//
//*/
//
//
//public class ContentSearchTester {
//
//    public SearchResult doSearch() throws Exception {
//        SearchResult result = null;
//
//        ClassPathResource res = new ClassPathResource("applicationContext.xml");
//        XmlBeanFactory factory = new XmlBeanFactory(res);
//
//        MockServletContext servletContext = new MockServletContext("http://test.aftenposten.no/sfe");
//        MockHttpServletRequest request = new MockHttpServletRequest(servletContext, "GET", "/");
//        request.addParameter("query", "i");
//
//
///******* Receive request params **************/
//
//        String qrservers = "fastdev1.medianorge.no:15480";
//        String searchview = "apsppublished";
//
//        //******** Receive request params **************
//        String parmQuery = request.getParameter("query");
//        String parmWhere = request.getParameter("where");
//        String parmAuthor = request.getParameter("author");
//        String parmPhoto = request.getParameter("photographer");
//        String parmOffset = request.getParameter("offset");
//        String pSearchView = request.getParameter("pSearchView");
//
//        if (pSearchView != null && pSearchView.equals("digitalarkiv"))
//            searchview = "digitalarkivsppublished";
//
//        Integer offset = 0;
//        if (parmOffset != null)
//            offset = Integer.parseInt(parmOffset);
//
//        // specified date interval
//        String timeFrom = SearchUtil.getTimeFromIssue(request, "from");
//        String time = request.getParameter("time");
//
//        if (timeFrom == null && time != null) {
//            timeFrom = request.getParameter("date_from");
//        }
//        if (time == null && (request.getParameter("date_from") == null || request.getParameter("date_from").equals(""))) {
//            timeFrom = null;
//        } else if (request.getParameter("date_from") != null && !request.getParameter("date_from").equals("")) {
//            timeFrom = request.getParameter("date_from");
//            time = "exact_from";
//        }
//        String timeTo = null;
//        String exact_to = request.getParameter("time_to");
//        if (exact_to != null && exact_to.equals("exact_to")) {
//            timeTo = SearchUtil.getTimeFromIssue(request, "to");
//            if (timeTo == null) {
//                timeTo = request.getParameter("date_to");
//            }
//        } else if (request.getParameter("date_to") != null) {
//            timeTo = request.getParameter("date_to");
//        }
//        if ((timeTo == null || timeTo.equals("")) && timeFrom != null && time.equals("exact_from")) {
//            timeTo = timeFrom;
//        }
//
//        // specified sections
//        String[] sections = new String[0];
//        if ("specify_section".equals(parmWhere)) {
//            sections = request.getParameterValues("section");
//        }
//
//        String navigation = request.getParameter("navigation.breadcrumbs");
//        if (navigation != null) navigation = new String(Base64.decodeBase64(navigation.getBytes()));
//
//        //******** End receive request params **************
//
//        if (StringUtils.hasText(parmQuery)) {
//
//            SearchForm searchForm = new SearchForm();
//            try {
//                SearchService searchService = new SearchServiceImpl(qrservers);
//                Search search = searchService.createSearch(searchview, SimpleSearchImpl.class);
//                SimpleSearch sm = (SimpleSearch) search.getSm();
//                sm.setQuery(parmQuery);
//
//                if (navigation != null) {
//                    NavigationInput nav = new NavigationInputImpl(search);
//                    nav.setNavigationEnabled(true);
//                    nav.setBreadcrumbs(navigation);
//                    search.addSearchInput(nav);
//                }
//
//                if (offset > 0) {
//                    search.getAc().setOffset(offset);
//                }
//
//                searchForm.setSearch(search);
//                searchForm.setSearchService(searchService);
//
//                ApSearch apSearch = new ApSearch(searchForm, request);
//
//                result = apSearch.setUpMultiFieldSearch(sections, parmAuthor, parmPhoto, time, timeFrom, timeTo);
//
//            } catch (Exception e) {
//                System.err.println("An error occurred during search from search.tag: " + e + ":\n" + e.getCause());
//            }
//        }
//        return result;
//    }
//
//
//    public static void main(String[] args) throws Exception {
//        ContentSearchTester searcher = new ContentSearchTester();
//
//        // Search!
//        SearchResult result = searcher.doSearch();
//
//        IQueryResult firstResult = result.getResults().getResult();
//        ISearchView view = result.getOriginatingSearch().getSearchView();
//
//
//        // Abort this navigator example program if there are no navigators in the search result
//        if (firstResult.navigatorCount() == 0) {
//            System.out.println("\nThere are no navigators in the search result");
//            return;
//        }
//
//        // Print out each navigator with its data
//        System.out.println("\nFIRST SEARCH RESULT\n==================");
//        System.out.println("The result contains the navigators listed below with data as shown on next line");
//        System.out.println("[ (name), (hits), (unit), (min), (max), (mean), (sum) ] \n");
//        com.fastsearch.esp.search.result.INavigator lastNavigator = null;
//
//        for (Iterator itr = firstResult.navigators(); itr.hasNext(); ) {
//            com.fastsearch.esp.search.result.INavigator navigator = (com.fastsearch.esp.search.result.INavigator) itr.next();
//            System.out.print("[");
//            System.out.print(" (" + navigator.getDisplayName() + "),");
//            System.out.print(" (" + navigator.getHits() + "),");
//            System.out.print(" (" + navigator.getUnit() + "),");
//            System.out.print(" (" + navigator.getMin() + "),");
//            System.out.print(" (" + navigator.getMax() + "),");
//            System.out.print(" (" + navigator.getMean() + ")");
//            System.out.print(" (" + navigator.getSum() + ")");
//            System.out.println(") ]");
//            lastNavigator = navigator;
//        }
//
//        // Print out the modifer for the last navigator from above
//        System.out.print("\n\nNavigator \"" + lastNavigator.getDisplayName() + "\" has the modifiers ");
//        System.out.println("listed below (data as on the next line)");
//        System.out.println("[ (modifier name), (hits), (actual query value), (document ratio) ] \n");
//        IModifier lastModifier = null;
//
//        for (Iterator itr = lastNavigator.modifiers(); itr.hasNext(); ) {
//            IModifier modifier = (IModifier) itr.next();
//            System.out.print("[");
//            System.out.print(" (" + modifier.getName() + "),");
//            System.out.print(" (" + modifier.getCount() + "),");
//            System.out.print(" (" + modifier.getValue() + "),");
//            System.out.print(" (" + modifier.getDocumentRatio() + ")");
//            System.out.println(") ]");
//            lastModifier = modifier;
//        }
//
//        // Create an navigation object. Use it to create an "adjustment"
//        // (to previous query) based on navigators and modifiers.
//        Navigation navigation = new Navigation();
//        IAdjustmentGroup adjustmentGroup = navigation.add(lastNavigator);
//        IAdjustment adjustment = adjustmentGroup.add(lastModifier);
//
//        // Use the navigation object to create a new (adjusted) query
//        IQuery drillDownQuery = new Query(firstResult.getOriginalQuery());
//
//        // Instruments new query with navigation parameters.
//        navigation.instrument(drillDownQuery);
//
//        IQueryResult drillDownResult = view.search(drillDownQuery);
//
//        // Dump the new drill downed search result to the terminal window
//        System.out.println("\nSEARCH RESULT AFTER DRILL DOWN\n==============================");
//        System.out.println(drillDownResult);
//
//        // Exit
//        System.out.println("Execution complete.");
//
//
//    }
//}
