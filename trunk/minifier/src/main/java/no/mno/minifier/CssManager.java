package no.mno.minifier;

import java.io.*;

import com.yahoo.platform.yui.compressor.*;
import org.apache.commons.io.IOUtils;

import java.nio.charset.Charset;
import java.util.*;

/**
 * Date: 05.09.12
 * Time: 13:09
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class CssManager extends AbstractMinifyManager{
    private static final String WIDGETS = "widgets";
    private static final String EXTENSION_CSS = ".css";





    public List<File> getFileToAppendFirst(List<String> files, String path, String jsPath) throws Exception {
        LinkedList<File> filesToAppend = new LinkedList<File>();
        File startingDirectoryGlobal = new File(path + "/" + jsPath);
        List<File> globalFiles = getFileListing(startingDirectoryGlobal, 0);
        for (String prependFiles : files) {
            for (File file : globalFiles) {
                if (file.getAbsolutePath().contains(prependFiles)) {
                    filesToAppend.add(file);
                }
            }
        }
        return filesToAppend;
    }


    public List<File> getAllCssWithWidgets(String path,
                                       String cssGlobalPath,
                                       String pubDir,
                                       List<String> widgets,
                                       List<String> skipList,
                                       List<String> orderOffCss,
                                       List<String> lastOrderdOffCss,
                                       String revision) throws Exception {
        return getAllCssFiles(new Settings(path,cssGlobalPath,pubDir,revision),
                skipList,
                orderOffCss,
                lastOrderdOffCss,
                widgets);
    }

    /**
     *
     * @param path
     * @param cssGlobalPath
     * @param pubDir
     * @param resourceArchive
     * @param widgets
     * @param skipList
     * @param orderOffCss
     * @param lastOrderdOffCss
     * @param revision
     * @return
     * @throws Exception
     */
    public List<File> getAllCssWithWidgets(String path,
                                       String cssGlobalPath,
                                       String pubDir,
                                       String resourceArchive,
                                       List<String> widgets,
                                       List<String> skipList,
                                       List<String> orderOffCss,
                                       List<String> lastOrderdOffCss,
                                       String revision) throws Exception {
        return getAllCssFiles(new Settings(path,cssGlobalPath,pubDir,null,null,resourceArchive, revision),
                skipList,
                orderOffCss,
                lastOrderdOffCss,
                widgets);
    }

    public List<File> getAllCssFilesDebug(Settings settings,
                                     List<String> skipList,
                                     List<String> orderOffCss,
                                     List<String> lastOrderdOffCss,
                                     List<String> widgets) throws Exception {
        setDebugMode(true);
        return getAllCssFiles(settings,skipList,orderOffCss,lastOrderdOffCss,widgets);
    }


    public List<File> getAllCssFiles(Settings settings,
                                     List<String> skipList,
                                     List<String> orderOffCss,
                                     List<String> lastOrderdOffCss,
                                     List<String> widgets) throws Exception {

        // find all css files
        // get a list of files in cssFolder
        String path = getRevisionPath(settings);
        List<File> allFiles = new LinkedList<File>();
        if(widgets.size() > 0){
            if(settings.isMobile()){
                allFiles = includeWidgetsMobile(fetchFiles(path, settings.getGlobalPath(), allFiles), widgets);
                // get all files from pubFolder
                allFiles = includeWidgetsMobile(fetchFiles(path, settings.getPublicationDir(), allFiles), widgets);
            } else {
                allFiles = includeWidgets(fetchFiles(path, settings.getGlobalPath(), allFiles), widgets);
                // get all files from pubFolder
                allFiles = includeWidgets(fetchFiles(path, settings.getPublicationDir(), allFiles), widgets);
            }
        } else {
            allFiles = excludeWidgets(fetchFiles(path, settings.getGlobalPath(), settings.isResponsive(), allFiles));
            allFiles = excludeWidgets(fetchFiles(path, settings.getPublicationDir(), settings.isResponsive(), allFiles));
        }


        // get all files from special global directory
        if (settings.getSpecialsGlobalDir() != null) {
            fetchFiles(path, settings.getSpecialsGlobalDir(), allFiles);
        }

        // get all files from special publication directory
        if (settings.getSpecialsPublicationDir() != null) {
            fetchFiles(path, settings.getSpecialsPublicationDir(), allFiles);
        }

        boolean add = true;
        LinkedHashSet<File> cssFiles = new LinkedHashSet<File>();
//        List<File> cssFiles = new LinkedList<File>();
        for (String css : orderOffCss) {
            for (File file : allFiles) {
                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(css.toLowerCase())) {
                    if(!inList(file.getAbsolutePath().replaceAll("\\\\", "/").toLowerCase(), skipList)){
                        cssFiles.add(file);
                    }
                }
            }
        }
        for (File file : allFiles) {
            for (String str : skipList) {
                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().indexOf(str.toLowerCase()) > -1) {
                    add = false;
                    break;
                }
            }
            for (String str : orderOffCss) {
                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().indexOf(str.toLowerCase()) > -1) {
                    add = false;
                    break;
                }
            }
            for (String str : lastOrderdOffCss) {
                if (file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().indexOf(str.toLowerCase()) > -1) {
                    add = false;
                    break;
                }
            }
            if (add) {
                cssFiles.add(file);
            }
            add = true;
        }

        for (String css : lastOrderdOffCss) {
            for (File file : allFiles) {
                if (file.getName().length() > 3) {
                    if (file.getAbsolutePath().contains(css)) {
                        cssFiles.add(file);
                    }
                }
            }
        }

        return createUniqueFileList(cssFiles);
    }

    private List<File> createUniqueFileList(LinkedHashSet cssFiles) {
        List<File> files = new LinkedList<File>();
        Iterator<File> it = cssFiles.iterator();
        while(it.hasNext()){
            files.add(it.next());
        }
        return files;
    }

    private boolean inList(String file, List<String> skipList) {
        for(String s:skipList){
            if(file.indexOf(s.toLowerCase()) > 0){
                return true;
            }
        }
        return false;
    }

    /**
     * Fetch all files from a given folder.
     *
     * @param basePath
     * @param startingDirectory
     * @param allFiles
     * @return
     * @throws FileNotFoundException
     */
    private List<File> fetchFiles(String basePath, String startingDirectory, List<File> allFiles) throws FileNotFoundException {
        File folder = new File(basePath + File.separator + startingDirectory + File.separator);
        allFiles.addAll(getFileListing(folder, 0));
        return allFiles;
    }

    private List<File> fetchFiles(String basePath, String startingDirectory, boolean isResponsive, List<File> allFiles) throws FileNotFoundException {
        File folder = new File(basePath + File.separator + startingDirectory + File.separator);

        FilenameFilter filter;
        if(!isResponsive){
            filter = new FilenameFilter() {
                @Override
                public boolean accept(File file, String s) {
                    boolean isFile = new File(file.getAbsolutePath() + File.separator + s).isFile();
                    return !s.contains(".svn") && ((isFile && s.contains(getSuffix()) && !s.contains("responsiveGrid.css")) || !isFile);
                }
            };
        } else {
            filter = new FilenameFilter() {
                @Override
                public boolean accept(File file, String s) {
                    boolean isFile = new File(file.getAbsolutePath() + File.separator + s).isFile();
                    return !s.contains(".svn") && ((isFile && s.contains(getSuffix()) && !s.contains("grid.css")) || !isFile);
                }
            };
        }



        allFiles.addAll(getFileListing(folder, 0,filter));
        return allFiles;
    }

    public WriteMiniResp writeMinifed(List<File> cssFiles, File newMiniCss, String applicationPath) throws Exception {
        Writer out = null;
        Reader r = null;
        if (cssFiles != null && !cssFiles.isEmpty()) {
            StringReader myStringReader = new StringReader(this.getAllCssString(cssFiles, applicationPath));
            out = new OutputStreamWriter(new FileOutputStream(newMiniCss.getAbsolutePath()), Charset.forName(CHARSET_UTF_8));

            CssCompressor cmprs = new CssCompressor(myStringReader);

            cmprs.compress(out, 70);
            out.close();

            // Cleaning up css for mobile
            String cssBuffer = IOUtils.toString(new FileInputStream(newMiniCss.getAbsolutePath()), "UTF-8");
            cssBuffer = "@charset \"utf-8\";\n" + cssBuffer.replaceAll(" and\\(", " and (");
            out = new OutputStreamWriter(new FileOutputStream(newMiniCss.getAbsolutePath()), Charset.forName(CHARSET_UTF_8));
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

    /**
     *
     * @param cssFiles
     * @return
     * @throws Exception
     */
    public String minfyFiles(List<File> cssFiles) throws Exception {
        if (cssFiles != null && !cssFiles.isEmpty()) {
            StringReader myStringReader = new StringReader(this.getAllCssString(cssFiles));

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            Writer out = new OutputStreamWriter(byteArrayOutputStream, Charset.forName(CHARSET_UTF_8));
            CssCompressor cmprs = new CssCompressor(myStringReader);
            cmprs.compress(out, 70);
            IOUtils.closeQuietly(out);

            // Cleaning up css for mobile
            String cssBuffer = byteArrayOutputStream.toString();
//            cssBuffer = "@charset \"utf-8\";\n" + cssBuffer;
//            cssBuffer = "@charset \"utf-8\";\n" + cssBuffer.replaceAll(" and\\(", " and (");
            return cssBuffer.replaceAll(" and\\(", " and (");
        } else {
            return "";
        }

    }



    public List<File> getFiles(String applicationPath, List<String> stringList) {
        List<File> mobileCssList = new LinkedList<File>();
        for (String fileString : stringList) {
            File cssFile = new File(applicationPath + "/" + fileString);
            if (cssFile.exists()) {
//                System.out.println("File: " + cssFile.getAbsolutePath());
                mobileCssList.add(cssFile);
            } else {
                System.out.println("File: " + applicationPath + fileString + " doesn't exist");
            }
        }
        return mobileCssList;
    }


    @Override
    protected String getType() {
        return WIDGETS;
    }

    @Override
    protected String getSuffix() {
        return EXTENSION_CSS;
    }

}
