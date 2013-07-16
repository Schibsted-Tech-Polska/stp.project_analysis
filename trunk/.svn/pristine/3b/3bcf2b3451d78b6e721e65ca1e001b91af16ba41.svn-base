package no.mno.minifier;

import com.yahoo.platform.yui.compressor.JavaScriptCompressor;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mozilla.javascript.ErrorReporter;
import org.mozilla.javascript.EvaluatorException;

import java.io.*;
import java.nio.charset.Charset;
import java.util.*;

/**
 * Date: 06.09.12
 * Time: 12:29
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class JsManager extends AbstractMinifyManager {
    private static transient Log log = LogFactory.getLog(JsManager.class);
    private static final String EXTENDED_EXTENSION = ".ext";
    private static final String JS_RESOURCE_FOLDER = "js";

    private static final String EXTENSION_JS = ".js";
    private static final String WIDGETS = "widgets";


    @Override
    protected String getType() {
        return WIDGETS;
    }

    @Override
    protected String getSuffix() {
        return EXTENSION_JS;
    }

    /**
     * Minify/compress the list of files.
     *
     * @param compress
     * @param appendFirst
     * @param applicationPath
     * @return
     * @throws Exception
     */
    public String minfyFiles(List<File> compress, List<File> appendFirst, String applicationPath) throws Exception {

        String str = getAllJsString(compress, applicationPath);
        StringReader myStringReader = new StringReader(str);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        Writer out = new OutputStreamWriter(byteArrayOutputStream, Charset.forName("UTF-8"));
        final StringBuilder errors = new StringBuilder();

        try {
            JavaScriptCompressor cmprs = new JavaScriptCompressor(myStringReader, new ErrorReporter() {

                public void warning(String message, String sourceName,
                                    int line, String lineSource, int lineOffset) {
                    try {
//                        System.out.println("<br />Warning Message:" + message + " <br />sourceName: " + sourceName + " <br />line: " + line + " <br />lineSource: " + lineSource + " <br />lineOffset: " + lineOffset + "<br />");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                public void error(String message, String sourceName,
                                  int line, String lineSource, int lineOffset) {
                    try {
                        System.out.println("<br />Error Message:" + message + " <br />SourceName: " + sourceName + " <br />line: " + line + " <br />lineSource: " + lineSource + " <br />lineOffset: " + lineOffset + "<br />");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                public EvaluatorException runtimeError(String message, String sourceName,
                                                       int line, String lineSource, int lineOffset) {
                    error(message, sourceName, line, lineSource, lineOffset);
                    return new EvaluatorException(message);
                }
            });

            out.append(this.getAllJsString(appendFirst, applicationPath));
            // write to file
            cmprs.compress(out, 70, true, true, true, false);
        } catch (Exception e) {
            e.printStackTrace();
//            System.out.println("Javascript: <script>"+str+"</script>");
            return "";

        } finally {
            IOUtils.closeQuietly(out);
        }
        return byteArrayOutputStream.toString();
    }

    /**
     * Gets a list of js files to be compressed.
     *
     * @param settings a setting bean
     * @param skipList list of files to be skipped from compressions
     * @param prependOrder files to be prepended, - and not compress
     * @param order files needed to be in a certain order
     * @param widgets list of widgets to be included.
     * @return a list of js.files
     * @throws FileNotFoundException
     */
    public List<File> getJsFiles(Settings settings, List<String> skipList, List<String> prependOrder, List<String> order,List<String> widgets) throws FileNotFoundException {
        LinkedList<LinkedList<File>> linkedList = getAllJsFilesToCombine(settings, skipList, prependOrder, order, widgets);
        List<File> files = new LinkedList<File>();
        for(int i = linkedList.size()-1;i > -1;i--){
            for(File f:linkedList.get(i)){
                files.add(f);
            }
        }
        return files;
    }

    public List<File> getJsFilesDebug(Settings settings, List<String> skipList, List<String> prependOrder, List<String> order,List<String> widgets) throws FileNotFoundException {
        setDebugMode(true);
        LinkedList<LinkedList<File>> linkedList = getAllJsFilesToCombine(settings, skipList,prependOrder,order,widgets);
        List<File> files = new LinkedList<File>();
        for(int i = linkedList.size()-1;i > -1;i--){
            for(File f:linkedList.get(i)){
                files.add(f);
            }
        }
        return files;
    }


    @Override
    protected String getResourcePath() {
        return File.separator+"resources";
    }

    public LinkedList<File> getWidgetJavascripts(Settings settings, List<String> appendWidgetsList, List<String> widgets) throws IOException {
        return getWidgetJavascripts(settings,appendWidgetsList,widgets,false);
    }

    public LinkedList<File> getWidgetJavascripts(Settings settings, List<String> appendWidgetsList, List<String> widgets, boolean onlyWidgets) throws IOException {
        String path = getRevisionPath(settings);
        File allJSFiles = new File(path + File.separator + JS_RESOURCE_FOLDER);
        if (allJSFiles.exists()) {
            LinkedList<File> globalFiles = processFiles(allJSFiles, 0);
            LinkedList<File> widgetsJsFiles = resolveWidgets(globalFiles);
            resolveExtendedJavascriptDefinitions(widgets, path);
            selectWidgetsWithExtends(widgetsJsFiles, createUniqueListOfWidgets(widgets));
            if(!onlyWidgets){
                widgetsJsFiles.addAll(resolveAppendList(globalFiles, appendWidgetsList));
            }
            return widgetsJsFiles;
        } else {
            // Return an empty list
            return new LinkedList<File>();
        }
    }

    private LinkedList<File> resolveAppendList(LinkedList<File> files, List<String> appendList) {
        LinkedList<File> appendJsList = new LinkedList<File>();
        for(File f:files){
            for(String s:appendList){
                if(f.getAbsolutePath().contains(s)){
                    appendJsList.add(f);
                    break;
                }
            }
        }
        return appendJsList;
    }

    private LinkedList<File> resolveWidgets(LinkedList<File> globalFiles) {
        LinkedList<File> widgets = new LinkedList<File>();
        for(File f:globalFiles){
            if(f.getAbsolutePath().contains("/widgets/")){
                widgets.add(f);
            }
        }
        return widgets;
    }

    private void selectWidgetsWithExtends(LinkedList<File> globalFiles, LinkedHashSet<String> uniqueWidgetList) {
        Iterator<File> fileIterator = globalFiles.iterator();
        while(fileIterator.hasNext()){
            File f = fileIterator.next();
            boolean keep = false;
            for(String widget:uniqueWidgetList){
                if(f.getAbsolutePath().contains(widget)){
                    keep = true;
                    break;
                }
            }
            if(!keep){
                fileIterator.remove();
            }
        }
        //To change body of created methods use File | Settings | File Templates.
    }

    private LinkedHashSet createUniqueListOfWidgets(List<String> widgets) {
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet<String>();
        for(String s:widgets){
            linkedHashSet.add(s);
        }
        return linkedHashSet;
    }


    public LinkedList<LinkedList<File>> getAllJsFilesToCombine(Settings settings, List<String> skipList, List<String> prependOrder, List<String> order,List<String> widgets){
        // find all css files
        String path = getRevisionPath(settings);
        File allJSFiles = new File(path + File.separator + JS_RESOURCE_FOLDER);
        boolean hasWidgets = widgets.size() > 0;
        try {
            if (allJSFiles.exists()) {
                LinkedList<File> globalFiles;
                if(hasWidgets){
                    globalFiles = getFileListing(allJSFiles, 0);
                } else {
                    globalFiles = stripWidgets(getFileListing(allJSFiles, 0));
                }
                LinkedList<File> prePendFiles = new LinkedList<File>();
                LinkedList<File> appendFiles = new LinkedList<File>();
                LinkedList<LinkedList<File>> result = new LinkedList<LinkedList<File>>();
                LinkedList<File> jsFiles = new LinkedList<File>();
                result.add(jsFiles);
                result.add(prePendFiles);
                boolean add = false;


                List<String> orderAppend = new LinkedList<String>();
                List<String> orderPrepend = new LinkedList<String>();
                boolean prepend = true;
                for (String o : order) {
                    if (o.contains("*")) {
                        prepend = false;
                    }
                    if (prepend) {
                        orderPrepend.add(o);
                    } else {
                        orderAppend.add(o);
                    }
                }

                Boolean appendFile = true;
                // prepend order - files not to be minified
                for (String fileCont : prependOrder) {
                    for (File file : globalFiles) {
                        if (file.getName().endsWith(EXTENSION_JS)) {
                            for (String skip : skipList) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            if (file.getAbsolutePath().replaceAll("\\\\","/").contains(fileCont) && appendFile) {
                                //jsFiles.add(file);
                                prePendFiles.add(file);
                            }
                        }
                        appendFile = true;
                    }
                }

                appendFile = true;
                // Add files to be prepended in compression
                for (String fileCont : orderPrepend) {
                    for (File file : globalFiles) {
                        if (file.getName().endsWith(EXTENSION_JS)) {
                            for (String skip : skipList) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            for (String skip : prependOrder) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            if (file.getAbsolutePath().replaceAll("\\\\","/").contains(fileCont) && appendFile) {
                                //jsFiles.add(file);
                                if(!jsFiles.contains(file)){
                                    jsFiles.add(file);
                                }
                            }
                        }
                        appendFile = true;
                    }
                }

                appendFile = true;
                // minifing order - files to be appended after all none ordered biles
                for (String fileCont : orderAppend) {
                    for (File file : globalFiles) {
                        if (file.getName().endsWith(EXTENSION_JS)) {
                            for (String skip : skipList) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            for (String skip : prependOrder) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            for (String skip : orderPrepend) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(skip.toLowerCase())) {
                                    appendFile = false;
                                }
                            }
                            if (file.getAbsolutePath().replaceAll("\\\\","/").contains(fileCont) && appendFile) {
                                //jsFiles.add(file);
                                appendFiles.add(file);
                            }
                        }
                        appendFile = true;
                    }
                }


                // add rest of files
                for (File file : globalFiles) {

                    if (file.getName().length() > 3) {

                        if (file.getName().endsWith(EXTENSION_JS)) {

                            // ignore thos in skip list
                            for (String str : skipList) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(str.toLowerCase())) {
                                    add = false;
                                }
                            }

                            // ignore those allready in from prepend order
                            for (String str : prependOrder) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").contains(str)) {
                                    add = false;

                                }
                            }
                            for (String str : orderPrepend) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").contains(str)) {
                                    add = false;

                                }
                            }
                            for (String str : orderAppend) {
                                if (file.getAbsolutePath().replaceAll("\\\\","/").contains(str)) {
                                    add = false;

                                }
                            }

                            if (add) {
                                if(!jsFiles.contains(file)){
                                    jsFiles.add(file);
                                }
                            }
                        }
                    }
                    add = true;

                }
                jsFiles.addAll(appendFiles);

                // Resolve javascripts being extended
                resolveExtendedJavascriptDefinitions(widgets, path);
                Collections.sort(widgets);
                result.set(0, includeOnlyWidgets(result.get(0), widgets));

                return result;
            } else {
                return null;
            }
        } catch (Exception e) {
            log.error("getAllJsFilesToCombine: ",e);
            e.printStackTrace();
        }
        return null;
    }

    private LinkedList<File> stripWidgets(LinkedList<File> fileListing) {
        Iterator<File> iterator = fileListing.iterator();
        while(iterator.hasNext()){
            File f = iterator.next();
            if(f.getAbsolutePath().contains("/widgets")){
               iterator.remove();
            }
        }
        return fileListing;
    }

    public void resolveExtendedJavascriptDefinitions(List<String> widgets, String path) throws IOException {
        File allJSFiles = new File(path + File.separator + JS_RESOURCE_FOLDER);
        LinkedList<File> globalFiles = getFileListing(allJSFiles, 0);
        proecessExtendedWidgets(globalFiles, widgets);
    }

    private void proecessExtendedWidgets(LinkedList<File> globalFiles, List<String> widgets) throws IOException {
        List<String> extended = new ArrayList<String>();
        resolveExtendedWidgets(globalFiles, widgets, extended);
        widgets.addAll(extended);
    }

    private void resolveExtendedWidgets(LinkedList<File> globalFiles, List<String> widgets, List<String> extended) throws IOException {
        for(File f:globalFiles){
            for(String w:widgets){
                /**
                 * Check all .js files
                 */
                if(f.getAbsolutePath().endsWith(w+EXTENSION_JS)){
                    extended.add(w);
                    /**
                     * Check if there is a corresponding .ext file
                     */
                    File ext = new File(StringUtils.substringBefore(f.getAbsolutePath(), EXTENSION_JS)+ EXTENDED_EXTENSION);
                    if(ext.exists()){
                        // Load the file into a string list
                        List<String> lines = FileUtils.readLines(ext);
                        // Process very line in the list
                        extendingRecursionLoop(globalFiles, lines, extended);
                    }
                }
            }
        }
        widgets.addAll(extended);
    }

    private void extendingRecursionLoop(LinkedList<File> globalFiles, List<String> widgets, List<String> extended) throws IOException {
        resolveExtendedWidgets(globalFiles, widgets, extended);
    }
}
