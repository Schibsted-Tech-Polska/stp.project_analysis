package no.mno.minifier;

import junit.framework.Assert;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.junit.Test;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Date: 23.08.12
 * Time: 07:56
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class CssManagerTest extends AbstractTestManager{

    @Test
    public void getAllJsFilesToCombineTest() throws Exception {
        CssManager cssManager = new CssManager();
        List<String> skipList = new LinkedList<String>();
        List<String> prependOrder = new LinkedList<String>();
        List<String> order = new LinkedList<String>();
        String jsPath = "";
//        LinkedList<LinkedList<File>> allJsFilesToCombine = cssManager.getAllJsFilesToCombine("./src/test/data",skipList,prependOrder,order,jsPath);

    }

    @Test
    public void minfyFiles() throws Exception{
        CssManager cssManager = new CssManager();
        List<File> cssFiles = new ArrayList<File>();
        cssFiles.add(new File(getFilePath("css/widgets/feed/default.css")));
        cssFiles.add(new File(getFilePath("css/widgets/feed/rssFull.css")));
        String minifiedCss = cssManager.minfyFiles(cssFiles);
        Assert.assertNull(minifiedCss);
    }

    @Test
    public void getAllCssWithWidgets() throws Exception{
        CssManager cssManager = new CssManager();
        // Create test-data set...
        List<String> widgets = new ArrayList<String>();
//        widgets.add("widgets/feed/default");
//        widgets.add("widgets/feed/rssFull");
//        widgets.add("widgets/stories/breakingnews");
//        widgets.add("widgets/feed/default");
//        widgets.add("widgets/feed/list");
//        widgets.add("widgets/list/posts");
//        widgets.add("widgets/code/js");
//        widgets.add("widgets/code/");
//        widgets.add("widgets/colophon/default");
        widgets.add("widgets/classifiedBox/horizontal");
//        widgets.add("widgets/realEstateInfo/keyInfo");
//        widgets.add("widgets/stories/breakingnews");
//        widgets.add("widgets/realEstateInfo/keyInfoBar");
        String path = getPath();
        String cssGlobalPath = "skins/global";
        String pubDir = "skins/publications/osloby";
        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListCss_osloby.txt")));
        List<String> orderOffCss = loadFileIntoList(new File(getFilePath("minify-config/orderListCss.txt")));
        List<String> lastOrderedOffCss = loadFileIntoList(new File(getFilePath("minify-config/lastOrderListCss.txt")));
        String resourceArchive = getFilePath("resource_archive");

//        Minfy the files...
        Settings settings = new Settings(path,cssGlobalPath,pubDir,null,null,resourceArchive,"123x",false);
        List<File> cssFiles = cssManager.getAllCssFiles(settings, skipList, orderOffCss, lastOrderedOffCss,widgets);
        for(File f:cssFiles){
            System.out.println(f.getAbsolutePath());
        }
        String minfiedFiles = cssManager.minfyFiles(cssFiles,settings);
        System.out.println(minfiedFiles);
//        Assert.assertNull(minfiedFiles);
    }




    @Test
    public void processDependencies() throws IOException {
        List<String> widgets = getWidgetList();
        JsManager jsManager = new JsManager();
        jsManager.resolveExtendedJavascriptDefinitions(widgets, getPath() + "resources");
    }






    @Test
    public void testMinifyCssExWidgets() throws Exception {
        CssManager cssManager = new CssManager();
        String path = getPath();
        String cssGlobalPath = "skins/global";
        String pubDir = "skins/publications/sa";
        boolean responsive = false;
        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListMobileCss_sa.txt")));
        List<String> orderOffCss = loadFileIntoList(new File(getFilePath("minify-config/orderListCss.txt")));
//        List<String> orderOffCss = loadFileIntoList(new File(getFilePath("minify-config/orderListCss"+(responsive?"_responsive":"")+".txt")));
        List<String> lastOrderedOffCss = loadFileIntoList(new File(getFilePath("minify-config/lastOrderListCss.txt")));
        String resourceArchive = getFilePath("resource_archive");

        List<String> widgets = getWidgetList();
//        Settings settings = new Settings(path,cssGlobalPath,pubDir,null,null,resourceArchive,"123x");
        Settings settings = new Settings(path,cssGlobalPath,pubDir,null,null,resourceArchive,responsive,"123x",false);
//        List<File> widgetCss = cssManager.getAllCssFiles(settings,
//                skipList,
//                orderOffCss,
//                lastOrderedOffCss,
//                widgets);
        List<File> widgetCssFiles = cssManager.getAllCssFiles(settings,
                skipList,
                orderOffCss,
                lastOrderedOffCss,
                new ArrayList<String>());
        for(File f:widgetCssFiles){
            System.out.println(""+f.getAbsolutePath());
        }
        String minfiedFiles = cssManager.minfyFiles(widgetCssFiles, settings);

        System.out.println("");
    }
}
