package no.mno.minifier;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Date: 30.10.12
 * Time: 07:42
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public abstract class AbstractTestManager {
    protected List<String> getWidgetList() {
        List<String> widgets = new ArrayList<String>();
//        widgets.add("widgets/realEstateInfo/keyInfo");
//        widgets.add("widgets/storyContent/article");
//        widgets.add("widgets/slideshow/map");
//        widgets.add("widgets/stories/list");
//        widgets.add("widgets/feed/default");
//        widgets.add("widgets/feed/list");
        widgets.add("widgets/stories/ledbanner");
        return widgets;
    }

    protected List<String> getParsedWidgetList(){
//        String widgets = "widgets/bubbles/bubblesDefault;widgets/classifiedBox/horizontal;widgets/code/html;widgets/eventList/default;widgets/eventList/list;widgets/eventPlaceSearch/default;widgets/eventSearch/advancedSearch;widgets/list/detailed;widgets/list/simple;widgets/logo/default;widgets/master/default;widgets/mnopolarisAd/default;widgets/mnopolarisAd/init;widgets/mnopolarisAd/placement;widgets/moodboard/list;widgets/pageTools/addThisPlain;widgets/rating/ratingList;widgets/searchField/default;widgets/seeClickFix/formContainer;widgets/seeClickFix/issueList;widgets/statistics/tns;widgets/statistics/webhits;widgets/statistics/xiti;widgets/stories/breakingnews;widgets/stories/default;widgets/stories/ledBanner;widgets/switchMaster/default;widgets/topMenu/standardMenu;widgets/weather/nowForecastForHeader";
        String widgets = "widgets/code/default;widgets/code/html;widgets/code/jsp;widgets/colophon/default;widgets/dateline/article;widgets/disqus/default;widgets/jobAdListings/profiled;widgets/list/mobileList;widgets/logo/default;widgets/mobileAd/smb;widgets/mobileRelatedContents/factboxes;widgets/mobileRelatedContents/pictures;widgets/mobileRelatedContents/poll;widgets/mobileStoryContent/article;widgets/moodboard/default;widgets/pageTools/addThis;widgets/popularList/mostRead;widgets/searchField/default;widgets/slideshow/mobileSlideshow;widgets/statistics/webhits;widgets/topMenu/mobileTabbedMenu;widgets/weather/nowForecastForHeader";
        String[] widgetArray = StringUtils.split(widgets, ";");
        List<String>  widgetList = new ArrayList<String>();
        for(String s:widgetArray){
            widgetList.add(s);
        }
        return widgetList;
    }

    protected String getPath() {
//        return "C:\\Users\\regearne\\JavaProjects\\mnofr\\src\\main\\webapp\\";
//        return "/Users/regearne/IdeaProjects/mno/performance-2/src/main/webapp";
        return "/Users/regearne/IdeaProjects/mno/api_to_trunk_first_run/publications/mnofr/src/main/webapp";
//        return "/Users/regearne/IdeaProjects/mno/mnofr_trunk/publications/mnofr/src/main/webapp";
//        return "/Users/regearne/IdeaProjects/mno/mnofr_api/publications/mnofr/src/main/webapp";
//        return "/Users/regearne/IdeaProjects/mno/framework/publications/mnofr/src/main/webapp/";
    }

    protected List<String> loadFileIntoList(File file) throws IOException {
        byte[] b = FileUtils.readFileToByteArray(file);
        String[] strings = StringUtils.split(new String(b), "\n\r");
        List<String> argumentList = new LinkedList<String>();
        for(String line:strings){
            argumentList.add(line);
        }
        return argumentList;
    }

    protected String loadFilenamesString(File file) throws IOException {
        byte[] b = FileUtils.readFileToByteArray(file);
        String[] strings = StringUtils.split(new String(b), "\n\r");
        StringBuilder sb = new StringBuilder();
        for(String line:strings){
            sb.append(line).append(";");
        }
        return sb.toString();
    }

    protected String getFilePath(String file) {
        ClassLoader loader = CssManagerTest.class.getClassLoader();
        URL resourceURL = loader.getResource(file);
        return resourceURL.getPath();
    }

}
