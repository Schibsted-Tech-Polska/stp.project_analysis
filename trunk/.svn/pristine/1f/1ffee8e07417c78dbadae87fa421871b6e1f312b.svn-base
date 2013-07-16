package no.mno.minifier;

import com.yahoo.platform.yui.compressor.CssCompressor;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;

import java.io.*;
import java.nio.charset.Charset;
import java.util.*;

/**
 * Date: 05.09.12
 * Time: 13:14
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public abstract class AbstractMinifyManager {

    protected static final String CHARSET_UTF_8 = "@charset \"utf-8\";";

    protected boolean debugMode;

    protected void validateDirectory(
            File aDirectory
    ) throws FileNotFoundException {
        if (aDirectory == null) {
            throw new IllegalArgumentException("Directory should not be null.");
        }
        if (!aDirectory.exists()) {
            throw new FileNotFoundException("Directory does not exist: " + aDirectory);
        }
        if (!aDirectory.isDirectory()) {
            throw new IllegalArgumentException("Is not a directory: " + aDirectory);
        }
        if (!aDirectory.canRead()) {
            throw new IllegalArgumentException("Directory cannot be read: " + aDirectory);
        }
    }


    public boolean isDebugMode() {
        return debugMode;
    }

    public void setDebugMode(boolean debugMode) {
        this.debugMode = debugMode;
    }

    protected LinkedList<File> getFileListing(
            File aStartingDir, int depth, FilenameFilter filenameFilter
    ) throws FileNotFoundException {
        validateDirectory(aStartingDir);
        LinkedList<File> result = getFileListingNoSort(aStartingDir, depth, 0, filenameFilter);
        Collections.sort(result);
        return result;
    }

    protected LinkedList<File> getFileListing(
            File aStartingDir, int depth
    ) throws FileNotFoundException {
        validateDirectory(aStartingDir);
        FilenameFilter filenameFilter = new FilenameFilter() {
            @Override
            public boolean accept(File file, String s) {
                boolean isFile = new File(file.getAbsolutePath() + File.separator + s).isFile();
                return !s.contains(".svn") && ((isFile && s.contains(getSuffix())) || !isFile);
            }
        };
        return getFileListing(aStartingDir, depth, filenameFilter);
    }

    protected LinkedList<File> getFileListingResponsive(
            File aStartingDir, int depth
    ) throws FileNotFoundException {
        validateDirectory(aStartingDir);
        FilenameFilter filenameFilter = new FilenameFilter() {
            @Override
            public boolean accept(File file, String s) {
                boolean isFile = new File(file.getAbsolutePath() + File.separator + s).isFile();
                return !s.contains(".svn") && ((isFile && s.contains(getSuffix())) || !isFile);
            }
        };
        return getFileListing(aStartingDir, depth, filenameFilter);
    }

    protected void stripDirectories(LinkedList<File> globalFiles) {
        Iterator<File> fileIterator = globalFiles.iterator();
        while(fileIterator.hasNext()){
            File f = fileIterator.next();
            if(f.isDirectory()){
                fileIterator.remove();
            }
        }
    }

    protected LinkedList<File> processFiles(
            File aStartingDir, int depth
    ) throws FileNotFoundException {
        validateDirectory(aStartingDir);
        FilenameFilter wigetFilter = new FilenameFilter() {
            @Override
            public boolean accept(File file, String s) {
                boolean isFile = new File(file.getAbsolutePath() + File.separator + s).isFile();
//                return !s.contains(".svn") && ((isFile && (s.contains(getSuffix()) && file.getAbsolutePath().contains("/widgets/"))) || !isFile);
                return !s.contains(".svn") && ((isFile && (s.contains(getSuffix()))) || !isFile);
            }
        };
        return getFileListing(aStartingDir, depth, wigetFilter);
    }

    protected LinkedList<File> getFileListingNoSort(
            File aStartingDir, int depth, int currentDepth, FilenameFilter filenameFilter
    ) throws FileNotFoundException {
        LinkedList<File> result = new LinkedList<File>();
        File[] filesAndDirs = aStartingDir.listFiles(filenameFilter);
        List<File> filesDirs = Arrays.asList(filesAndDirs);
        for (File file : filesDirs) {
            result.add(file); //always add, even if directory
            if (!file.isFile() && (depth < currentDepth || depth == 0)) {
                //must be a directory
                //recursive call!
                LinkedList<File> deeperList = getFileListingNoSort(file, depth, currentDepth + 1,filenameFilter);
                result.addAll(deeperList);
            }
        }
        return result;
    }

    /**
     * Include only widgets
     *
     * @param files
     * @param widgets
     * @return
     */
    protected List<File> includeWidgets(List<File> files, List<String> widgets) {
        Iterator<File> iter = files.iterator();
        if (widgets.size() > 0) {
            String extension = getSuffix();
            while (iter.hasNext()) {
                File ob = iter.next();
                boolean keep = false;
                if (ob.getAbsolutePath().contains(getType())) {
                    for (String widget : widgets) {
                        if(ob.getAbsolutePath().endsWith(extension)){
                            String absolutePath = ob.getAbsolutePath().replaceAll("\\\\","/");
                            if (absolutePath.endsWith(widget + extension) || absolutePath.endsWith(getMainCss(widget)+extension) || widget.contains("/code/") &&  absolutePath.contains("/code/")) {
                                keep = true;
                                break;
                            }
                        }
                    }
                }
                if (!keep) {
                    iter.remove();
                }
            }
        }
        return files;
    }

    protected List<File> includeWidgetsMobile(List<File> files, List<String> widgets) {
        Iterator<File> iter = files.iterator();
        if (widgets.size() > 0) {
            String extension = getSuffix();
            while (iter.hasNext()) {
                File ob = iter.next();
                boolean keep = false;
                if (ob.getAbsolutePath().contains(getType())) {
                    for (String widget : widgets) {
                        if(ob.getAbsolutePath().endsWith(extension)){
                            String absolutePath = ob.getAbsolutePath().replaceAll("\\\\","/");
                            if(absolutePath.endsWith(widget + extension)){
                                keep = true;
                                break;
                            } else if(absolutePath.endsWith(getMainMobile(widget)+extension)){
                                keep = true;
                                break;
                            } else if(absolutePath.endsWith(getMainCss(widget)+extension) &&
                                    !new File(ob.getParent()+File.separator+"main_mobile"+extension).exists()){
                                keep = true;
                                break;
                            } else if(widget.contains("/code/") &&  absolutePath.contains("/code/")){
                                keep = true;
                                break;
                            }
                        }
                    }
                }
                if (!keep) {
                    iter.remove();
                }
            }
        }
        return files;
    }

    protected List<File> excludeWidgets(List<File> files) {
        Iterator<File> iter = files.iterator();
        String extension = getSuffix();
        while (iter.hasNext()) {
            File ob = iter.next();
            if (!ob.getAbsolutePath().contains(getType())) {
                if (!ob.getAbsolutePath().endsWith(extension)) {
                    iter.remove();
                }
            } else {
                iter.remove();
            }
        }
        return files;
    }


    /**
        * Include only widgets
        *
        * @param files
        * @param widgets
        * @return
        */
    protected LinkedList<File> includeOnlyWidgets(LinkedList<File> files, List<String> widgets) {
        Iterator<File> iter = files.iterator();
        if (widgets.size() > 0) {
            String extension = getSuffix();
            while (iter.hasNext()) {
                File ob = iter.next();
                boolean keep = false;
                if (ob.getAbsolutePath().contains(getType())) {
                    for (String widget : widgets) {
                        if(ob.getAbsolutePath().endsWith(extension)){
                            String absolutePath = ob.getAbsolutePath().replaceAll("\\\\","/");
                            if (absolutePath.endsWith(widget + extension) || absolutePath.endsWith(getMainCss(widget)+extension) || widget.contains("/code/") &&  absolutePath.contains("/code/")) {
                                keep = true;
                                break;
                            }
                        }
                    }
                }
                if (!keep) {
                    iter.remove();
                }
            }
        } else {
            // Stripping widgets
            while (iter.hasNext()) {
                File ob = iter.next();
                if (ob.getAbsolutePath().contains(getType())) {
                    iter.remove();
                }
            }
        }
        return files;
    }

    protected String getAllJsString(List<File> jsFiles, String applicationPath) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (File file : jsFiles) {
            // prevent the debug.js from being included in the minified file
            if(!file.getAbsolutePath().endsWith("core/debug.js")){
                FileInputStream fstream = new FileInputStream(file);
                // Get the object of DataInputStream
                DataInputStream in = new DataInputStream(fstream);
                BufferedReader br = new BufferedReader(new InputStreamReader(in, Charset.forName("utf-8")));

                String strLine;
                //Read File Line By Line
                sb.append("/*!\n\n\n\n" + file.getAbsolutePath().replace(applicationPath, "").replace(File.pathSeparator, " ").replace("/", " ").replace("\\", " ") + "\n\n\n\n*/");

                while ((strLine = br.readLine()) != null) {
                    // Print the content on the console
                    sb.append(strLine + "\n");
                }
                //Close the input stream
                in.close();
            }
        }

        // Append the buffer with a semicolon if it is missing.
        if(sb.length() >2 && !sb.toString().substring(sb.length()-2,sb.length()-1).equals(";")){
            sb.append(";");
        }
        return sb.toString();
    }


    private String getMainCss(String widget) {
        return StringUtils.substringBeforeLast(widget,"/") + "/main";
    }

    private String getMainMobile(String widget) {
        return StringUtils.substringBeforeLast(widget,"/") + "/main_mobile";
    }

    protected List<File> getFiles(String applicationPath, List<String> stringList) {
        List<File> fileList = new LinkedList<File>();
        for (String fileString : stringList) {
            File file = new File(applicationPath + "/" + fileString);
            if (file.exists()) {
//                System.out.println("File: " + file.getAbsolutePath());
                fileList.add(file);
            } else {
                System.out.println("File: " + applicationPath + fileString + " doesn't exist");
            }
        }
        return fileList;
    }

    public String getAllCssString(List<File> cssFiles, String applicationPath) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (File file : cssFiles) {
            if (file.isFile()) {
                FileInputStream fstream = new FileInputStream(file);
                // Get the object of DataInputStream
                DataInputStream in = new DataInputStream(fstream);
                BufferedReader br = new BufferedReader(new InputStreamReader(in));
                String strLine;
                //Read File Line By Line
                sb.append("/*!\n\n\n\n" + file.getAbsolutePath().replace(applicationPath, "").replace(File.pathSeparator, " ").replace("/", " ").replace("\\", " ") + "\n\n\n\n*/");
                while ((strLine = br.readLine()) != null) {
                    // Print the content on the console
                    sb.append(strLine);
                }
                //Close the input stream
                in.close();
            }
        }
        return sb.toString();
    }



    /**
     * Resolves the correct path for a give revions. Falls back to current webapps pah.
     *
     * @param settings
     * @return
     */
    protected String getRevisionPath(Settings settings){
        if(!isDebugMode() && StringUtils.isNotEmpty(settings.getResourceArchive()) && StringUtils.isNotEmpty(settings.getRevision()) &&
                new File(settings.getResourceArchive()+File.separator+settings.getRevision()).isDirectory()){
            return settings.getResourceArchive()+File.separator+settings.getRevision()+File.separator;
        } else {
            return settings.getPath()+getResourcePath();
        }
    }

    protected String getResourcePath(){
        return "";
    }

    String getAllCssString(List<File> cssFiles) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (File file : cssFiles) {
            if (file.isFile()) {
                FileInputStream fstream = new FileInputStream(file);
                // Get the object of DataInputStream
                DataInputStream in = new DataInputStream(fstream);
                BufferedReader br = new BufferedReader(new InputStreamReader(in));
                String strLine;
                //Read File Line By Line
                sb.append("/*!\n\n\n\n" + file.getAbsolutePath().replace(File.pathSeparator, " ").
                        replace("/", " ").replace("\\", " ") + "\n\n\n\n*/");
                while ((strLine = br.readLine()) != null) {
                    // Print the content on the console
                    sb.append(strLine);
                }
                //Close the input stream
                in.close();
            }
        }

        return sb.toString();
    }


    /**
     *
     * @param cssFiles
     * @return
     * @throws Exception
     */
    public String minfyFiles(List<File> cssFiles, Settings settings) throws Exception {
        if (cssFiles != null && !cssFiles.isEmpty()) {
            StringReader myStringReader = new StringReader(getAllCssString(cssFiles));

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            Writer out = new OutputStreamWriter(byteArrayOutputStream, "UTF-8");
            CssCompressor cmprs = new CssCompressor(myStringReader);
            cmprs.compress(out, 70);
            IOUtils.closeQuietly(out);

            // Cleaning up css for mobile
            String cssBuffer = byteArrayOutputStream.toString();
            String replaceToken = getRevisionPath(settings).replaceAll(File.separator," ");
            StringBuilder sb = new StringBuilder();
            cssBuffer = cssBuffer.replaceAll(" and\\(", " and (").replaceAll(replaceToken,"" ).replaceAll("\\n+", "\n");
            sb.append(CHARSET_UTF_8).append("\n").append("/*!Revision: ").append(settings.getRevision()).append("\n").append(cssBuffer.substring(CHARSET_UTF_8.length()+3));
            return sb.toString();
        } else {
            return "";
        }
    }


    public WriteMiniResp writeMinifed(List<File> cssFiles, File newMiniCss, String applicationPath) throws Exception {
        Writer out = null;
        Reader r = null;
        if (cssFiles != null && !cssFiles.isEmpty()) {
            StringReader myStringReader = new StringReader(this.getAllCssString(cssFiles, applicationPath));
            out = new OutputStreamWriter(new FileOutputStream(newMiniCss.getAbsolutePath()), "UTF-8");

            CssCompressor cmprs = new CssCompressor(myStringReader);

            cmprs.compress(out, 70);
            out.close();

            // Cleaning up css for mobile
            String cssBuffer = IOUtils.toString(new FileInputStream(newMiniCss.getAbsolutePath()), "UTF-8");
            cssBuffer = "@charset \"utf-8\";\n" + cssBuffer.replaceAll(" and\\(", " and (");
            out = new OutputStreamWriter(new FileOutputStream(newMiniCss.getAbsolutePath()), "UTF-8");
            out.write(cssBuffer);
            out.close();

            newMiniCss.setLastModified(new Date().getTime());
            WriteMiniResp resp = new WriteMiniResp();
            resp.setErrroMessage("");
            resp.setFileName(newMiniCss.getName());
            resp.setSuccess(true);
            return resp;
        } else {
            WriteMiniResp resp = new WriteMiniResp();
            resp.setErrroMessage("ERROR no css files given");
            resp.setSuccess(false);
            return resp;
        }

    }


    protected abstract String getType();

    protected abstract String getSuffix();

}
