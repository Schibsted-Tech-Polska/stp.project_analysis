package no.medianorge.search;

import ap.util.ApSearch;
import ap.util.ModifierBean;
import com.fastsearch.espimpl.sfeapi.searchservice.result.NavigatorImpl;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

/**
 * User: itlihart
 * Date: 09.des.2010
 * Time: 14:59:39
 */
public class SearchUtil {
//    protected final Logger logger = Logger.getLogger(getClass());
    private static SimpleDateFormat sfe = new SimpleDateFormat("dd/MM/yyyy");

    public static String getTimeFromIssue(HttpServletRequest request, String prefix, int rollDay){
        String timeFrom = null;
        String from_issueDay = request.getParameter(prefix + "_issueday");
        String from_issueMonth = request.getParameter(prefix + "_issuemonth");
        String from_issueYear = request.getParameter(prefix + "_issueyear");
        if(from_issueDay != null && from_issueMonth != null && from_issueYear != null){
            try{
                int id = Integer.parseInt(from_issueDay);
                int im = Integer.parseInt(from_issueMonth);
                im = im - 1;
                int iy = Integer.parseInt(from_issueYear);
                timeFrom = ApSearch.getStaticDate(id, im, iy, "dd/MM/yyyy", rollDay);
            }catch(NumberFormatException nfe){
//                logger.error("something is not a number");
            }
        }
        return timeFrom;
    }

    public static String getTimeFromIssue(HttpServletRequest request, String prefix){
        return getTimeFromIssue(request,prefix,0);
    }

    public static Date parseDate(String dateStr) throws ParseException {
        return sfe.parse(dateStr);
    }

    public static String parseDate(Date date) throws ParseException {
        return sfe.format(date);
    }

    public ArrayList<ModifierBean> getDocyearModifier(NavigatorImpl n, int lastYear, int firstYear){
        HashMap<String, ModifierBean> hm = new HashMap<String, ModifierBean>();
        for(int t = lastYear; t > firstYear; t-- ){
            ModifierBean mbean = new ModifierBean("docyear", "" + t, t, 0);
            hm.put(mbean.getName(), mbean);
        }

        ArrayList<ModifierBean> al = new ArrayList<ModifierBean>();

        Iterator i = n.getAllModifiers();
        ModifierBean mb = null;
        while(i.hasNext()){
            Object o = i.next();
            mb = new ModifierBean(o.toString());
            //System.out.println("MB: " + mb);
            hm.put(mb.getName(), mb);
        }

        for(int t = lastYear; t > firstYear; t--){
            al.add(hm.get("" + t));
        }

        return al;
    }



/*
    public class DatePojo{
        int dd = 0;
        int mm = 0;
        int year = 0;

        private DatePojo(int dd, int mm, int year) {
            this.dd = dd;

            this.mm = mm + 1;
            this.year = year;
        }

        public String getDd() {
            if(dd <= 9){
                return "" + dd;
            }else{
                return "" + dd;
            }
        }

        public String getMm() {
            if(mm <= 9){
                return "" + mm;
            }else{
                return "" + mm;
            }
        }

        public String getYear() {
            return "" + year;
        }

    }
*/
}
