package no.mno.minifier;

import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Date: 30.10.12
 * Time: 07:41
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class JsManagerTest extends AbstractTestManager{

    @Test
    public void getJsFilesAP() throws Exception {
        JsManager jsManager = new JsManager();
        String path = getPath();
        List<String> widgets = new ArrayList<String>();
        widgets.add("widgets/feed/default");
        widgets.add("widgets/cartoon/section");
        widgets.add("widgets/classifiedBox/vertical");

        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListJs.txt")));
        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListJs.txt")));
//        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListJs.txt")));
//        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
//        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
//        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListJs.txt")));
        String resourceArchive = getFilePath("resource_archive");
        Settings settings = new Settings(path,resourceArchive,"123x");
        LinkedList<LinkedList<File>> jsFiles = jsManager.getAllJsFilesToCombine(settings, skipList, prependList, compressOrderList, new ArrayList<String>());
        String minfiedFiles = jsManager.minfyFiles(jsFiles.get(0),jsFiles.get(1),settings.getPath());

        LinkedList<File> widgetList = jsManager.getWidgetJavascripts(settings, appendList, widgets);
        String minfiedWidgetsFiles = jsManager.minfyFiles(widgetList, new LinkedList<File>(), settings.getPath());
    }

    @Test
    public void getJsFiles() throws Exception {
        JsManager jsManager = new JsManager();
        String path = getPath();
        List<String> widgets = new ArrayList<String>();
        widgets.add("widgets/feed/default");
        widgets.add("widgets/cartoon/section");
        widgets.add("widgets/classifiedBox/vertical");

        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListMobileJs_ap.txt")));
        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListMobileJs.txt")));
//        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListJs.txt")));
//        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
//        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
//        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListJs.txt")));
        String resourceArchive = getFilePath("resource_archive");
        Settings settings = new Settings(path,resourceArchive,"123x");
        LinkedList<LinkedList<File>> jsFiles = jsManager.getAllJsFilesToCombine(settings, skipList, prependList, compressOrderList, new ArrayList<String>());
        String minfiedFiles = jsManager.minfyFiles(jsFiles.get(0),jsFiles.get(1),settings.getPath());

        LinkedList<File> widgetList = jsManager.getWidgetJavascripts(settings, appendList, widgets);
        String minfiedWidgetsFiles = jsManager.minfyFiles(widgetList, new LinkedList<File>(), settings.getPath());
    }

    @Test
    public void getJsFilesBT() throws Exception {
        JsManager jsManager = new JsManager();
        String path = getPath();
        List<String> widgets = new ArrayList<String>();
        widgets.add("widgets/feed/default");
        widgets.add("widgets/cartoon/section");
        widgets.add("widgets/classifiedBox/vertical");

        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListMobileJs_bt.txt")));
        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListMobileJs.txt")));
//        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListJs.txt")));
//        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
//        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
//        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListJs.txt")));
        String resourceArchive = getFilePath("resource_archive");
        Settings settings = new Settings(path,resourceArchive,"123x");
        LinkedList<LinkedList<File>> jsFiles = jsManager.getAllJsFilesToCombine(settings, skipList, prependList, compressOrderList, new ArrayList<String>());
        for(File f :jsFiles.get(1)){
            System.out.println(f.getAbsolutePath());
        }
        System.out.println("-----");
        for(File f :jsFiles.get(0)){
            System.out.println(f.getAbsolutePath());
        }
        String minfiedFiles = jsManager.minfyFiles(jsFiles.get(0),jsFiles.get(1),settings.getPath());

        LinkedList<File> widgetList = jsManager.getWidgetJavascripts(settings, appendList, widgets);
        String minfiedWidgetsFiles = jsManager.minfyFiles(widgetList, new LinkedList<File>(), settings.getPath());
    }

    @Test
    public void getJsFilesDebug() throws Exception {
        JsManager jsManager = new JsManager();
        String path = getPath();
        List<String> widgets = new ArrayList<String>();
        widgets.add("widgets/feed/default");
        widgets.add("widgets/cartoon/section");
        widgets.add("widgets/classifiedBox/vertical");

        List<String> skipList = loadFileIntoList(new File(getFilePath("minify-config/skipListJs.txt")));
        List<String> appendList = loadFileIntoList(new File(getFilePath("minify-config/appendWidgetJs.txt")));
        List<String> prependList = loadFileIntoList(new File(getFilePath("minify-config/prependOrderNoMinifyJs.txt")));
        List<String> compressOrderList = loadFileIntoList(new File(getFilePath("minify-config/compressOrderListJs.txt")));
        String resourceArchive = getFilePath("resource_archive");
        Settings settings = new Settings(path,resourceArchive,"123x");
        LinkedList<LinkedList<File>> jsFiles = jsManager.getAllJsFilesToCombine(settings, skipList, prependList, compressOrderList, new ArrayList<String>());
        for(File f :jsFiles.get(1)){
            System.out.println(f.getAbsolutePath());
        }
        for(File f :jsFiles.get(0)){
            System.out.println(f.getAbsolutePath());
        }

        LinkedList<File> widgetList = jsManager.getWidgetJavascripts(settings, appendList, widgets);
        for(File f :widgetList){
            System.out.println(f.getAbsolutePath());
        }
    }




}
