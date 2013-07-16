package no.mno.minifier;

import java.io.*;

import com.yahoo.platform.yui.compressor.*;
import org.apache.commons.io.IOUtils;
import org.mozilla.javascript.ErrorReporter;
import org.mozilla.javascript.EvaluatorException;

import java.security.MessageDigest;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.apr.2011
 * Time: 23:26:09
 * To change this template use File | Settings | File Templates.
 */
public class JsCssManager {

    private LinkedList<File> getFileListing(
            File aStartingDir, int depth
    ) throws FileNotFoundException {
        validateDirectory(aStartingDir);
        LinkedList<File> result = getFileListingNoSort(aStartingDir, depth, 0);
        Collections.sort(result);
        return result;
    }


    private LinkedList<File> getFileListingNoSort(
            File aStartingDir, int depth, int currentDepth
    ) throws FileNotFoundException {
        LinkedList<File> result = new LinkedList<File>();
        File[] filesAndDirs = aStartingDir.listFiles();
        List<File> filesDirs = Arrays.asList(filesAndDirs);
        for (File file : filesDirs) {
            result.add(file); //always add, even if directory
            if (!file.isFile() && (depth < currentDepth || depth == 0)) {
                //must be a directory
                //recursive call!
                LinkedList<File> deeperList = getFileListingNoSort(file, depth, currentDepth + 1);
                result.addAll(deeperList);
            }
        }
        return result;
    }

    private void validateDirectory(
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

    public LinkedList<LinkedList<File>> getAllJsFilesToCombine(String path, List<String> skipList, List<String> prependOrder, List<String> order, String jsPath) throws Exception {
        // find all css files
        File allJSFiles = new File(path + File.separator + jsPath);
        if (allJSFiles.exists()) {
            LinkedList<File> globalFiles = getFileListing(allJSFiles, 0);
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
                    if (file.getName().substring(file.getName().length() - 2, file.getName().length()).equals("js")) {
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
                    if (file.getName().substring(file.getName().length() - 2, file.getName().length()).equals("js")) {
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
                            jsFiles.add(file);
                        }
                    }
                    appendFile = true;
                }
            }

            appendFile = true;
            // minifing order - files to be appended after all none ordered biles
            for (String fileCont : orderAppend) {
                for (File file : globalFiles) {
                    if (file.getName().substring(file.getName().length() - 2, file.getName().length()).equals("js")) {
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

                    if (file.getName().substring(file.getName().length() - 2, file.getName().length()).equals("js")) {

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
                            jsFiles.add(file);
                        }
                    }
                }
                add = true;

            }

            // Appending the append files
            jsFiles.addAll(appendFiles);
            return result;
        } else {
            return null;
        }
    }

    public File getMiniJsFile(String path, String jsPath, String fileContains) throws Exception {
        File startingDirectoryGlobal = new File(path + File.separator + jsPath);
        List<File> files = getFileListing(startingDirectoryGlobal, 1);
        for (File file : files) {
            if (file.getAbsolutePath().contains(fileContains)) {
                return file;
            }
        }
        return null;
    }

    String getAllJsString(List<File> jsFiles, String encoding, String applicationPath) throws Exception {
        StringBuilder sb = new StringBuilder();
        for (File file : jsFiles) {

            FileInputStream fstream = new FileInputStream(file);
            // Get the object of DataInputStream
            DataInputStream in = new DataInputStream(fstream);
            BufferedReader br = new BufferedReader(new InputStreamReader(in, encoding));

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

        return sb.toString();
    }


    String getJsString(File jsFile) throws Exception {
        StringBuilder sb = new StringBuilder();

        FileInputStream fstream = new FileInputStream(jsFile);
        // Get the object of DataInputStream
        DataInputStream in = new DataInputStream(fstream);
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        String strLine;
        //Read File Line By Line

        while ((strLine = br.readLine()) != null) {
            sb.append(strLine + "\n");
        }

        //Close the input stream
        in.close();


        return sb.toString();
    }

    public WriteMiniResp writeMinifed(List<File> jsFiles, File newMiniJs, List<File> appendFirst, String readEncoding, String applicationPath) throws Exception {
        if (jsFiles != null && !jsFiles.isEmpty()) {
            String test = this.getAllJsString(jsFiles, readEncoding, applicationPath);


            return writeMinfied(test, newMiniJs, appendFirst, readEncoding, applicationPath);
        } else {
            WriteMiniResp resp = new WriteMiniResp();
            resp.setErrroMessage("empty list");
            resp.setSuccess(false);
            return resp;
        }

    }

    public WriteMiniResp writeMinfied(String str, File newMiniJs, List<File> appendFirst, String readEncoding, String applicationPath) throws Exception {

        StringReader myStringReader = new StringReader(str);
        Writer out = new OutputStreamWriter(new FileOutputStream(newMiniJs.getAbsolutePath()), "UTF-8");
        final StringBuilder errors = new StringBuilder();
        BufferedWriter bw = new BufferedWriter(new FileWriter(newMiniJs));
        try {
            JavaScriptCompressor cmprs = new JavaScriptCompressor(myStringReader, new ErrorReporter() {

                public void warning(String message, String sourceName,
                                    int line, String lineSource, int lineOffset) {
                    try {

                    } catch (Exception e) {

                    }
                }

                public void error(String message, String sourceName,
                                  int line, String lineSource, int lineOffset) {
                    try {
                        errors.append("<br />Message:" + message + " <br />soruceName: " + sourceName + " <br />line: " + line + " <br />lineSource: " + lineSource + " <br />lineOffset: " + lineOffset + "<br />");


                    } catch (Exception e) {

                    }
                }

                public EvaluatorException runtimeError(String message, String sourceName,
                                                       int line, String lineSource, int lineOffset) {
                    error(message, sourceName, line, lineSource, lineOffset);
                    return new EvaluatorException(message);
                }
            });

            out.append(this.getAllJsString(appendFirst, readEncoding, applicationPath));
            // write to file
            cmprs.compress(out, 70, true, true, true, false);

            newMiniJs.setLastModified(new Date().getTime());


        } catch (Exception e) {

            out.close();
            WriteMiniResp resp = new WriteMiniResp();
            resp.setErrroMessage(errors.toString());
            resp.setSuccess(false);
            return resp;

        } finally {

            out.close();
            if (errors.toString().length() == 0) {
                WriteMiniResp resp = new WriteMiniResp();
                resp.setErrroMessage(errors.toString());
                resp.setSuccess(true);
                resp.setFileName(newMiniJs.getName());
                return resp;
            } else {
                WriteMiniResp resp = new WriteMiniResp();
                resp.setErrroMessage(errors.toString());
                resp.setSuccess(false);
                return resp;
            }


        }


    }

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


    public List<File> getAllCssFiles(String path, String cssGlobalPath, String pubDir, String specGlobalDir, String specPubDir, List<String> skipList, List<String> orderOffCss, List<String> lastOrderdOffCss) throws Exception {
        // find all css files
        // get a list of files in cssFolder
        File startingDirectory = new File(path + File.separator + cssGlobalPath + File.separator);
        List<File> allFiles = getFileListing(startingDirectory, 0);

        // get all files from pubFolder
        File pubFolder = new File(path + File.separator + pubDir + File.separator);

        allFiles.addAll(getFileListing(pubFolder, 0));

        // get all files from special global directory
        if (specGlobalDir != null) {
            File folder = new File(path + File.separator + specGlobalDir + File.separator);
            if (folder.isDirectory()) {
                allFiles.addAll(getFileListing(folder, 0));
            }
        }

        // get all files from special publication directory
        if (specPubDir != null) {
            File folder = new File(path + File.separator + specPubDir + File.separator);
            if (folder.isDirectory()) {
                allFiles.addAll(getFileListing(folder, 0));
            }
        }


        boolean add = true;
        List<File> cssFiles = new LinkedList<File>();
        for (String css : orderOffCss) {
            for (File file : allFiles) {
                if (file.getName().length() > 3) {
                    if (file.getName().substring(file.getName().length() - 3, file.getName().length()).equals("css") && file.getAbsolutePath().replaceAll("\\\\","/").toLowerCase().contains(css.toLowerCase())) {
                        cssFiles.add(file);
                    }
                }
            }
        }
        for (File file : allFiles) {
            if (file.getName().length() > 3) {
                if (file.getName().substring(file.getName().length() - 3, file.getName().length()).equals("css")) {

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
                }
            }
            add = true;
        }

        for (String css : lastOrderdOffCss) {
            for (File file : allFiles) {
                if (file.getName().length() > 3) {
                    if (file.getName().substring(file.getName().length() - 3, file.getName().length()).equals("css") && file.getAbsolutePath().contains(css)) {
                        cssFiles.add(file);
                    }
                }
            }
        }
        return cssFiles;
    }

    /**
     * Returns a list of excluded css-files.
     *
     * @param path
     * @param cssGlobalPath
     * @param pubDir
     * @param specGlobalDir
     * @param specPubDir
     * @param skipList
     * @param orderOffCss
     * @param lastOrderdOffCss
     * @param excludedCss      txt-file containing list of excluded css files.
     * @return
     * @throws Exception
     */
    public List<File> getExcludedCss(String path, String cssGlobalPath, String pubDir, String specGlobalDir, String specPubDir, List<String> skipList, List<String> orderOffCss, List<String> lastOrderdOffCss, List<String> excludedCss) throws Exception {
        List<File> files = getAllCssFiles(path, cssGlobalPath, pubDir, specGlobalDir, specPubDir, skipList, orderOffCss, lastOrderdOffCss);
        List<File> excludedFiles = new LinkedList<File>();
        for (File file : files) {
            for (String exclude : excludedCss) {
                if (file.getAbsolutePath().startsWith(path + "/" + exclude)) {
                    excludedFiles.add(file);
                    System.out.println("Excluding: " + file.getAbsolutePath());
                }
            }
        }
        return excludedFiles;
    }

    public File getMiniCssFile(String cssPath, String fileContains) throws Exception {
        File startingDirectoryGlobal = new File(cssPath);
        List<File> files = getFileListing(startingDirectoryGlobal, 1);
        for (File file : files) {
            if (file.getAbsolutePath().contains(fileContains)) {
                return file;
            }
        }
        return null;
    }

    String getAllCssString(List<File> cssFiles, String applicationPath) throws Exception {
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

    public String md5String(String stringToMD5) {
        String hashword = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(stringToMD5.getBytes());
            BigInteger hash = new BigInteger(1, md5.digest());
            hashword = hash.toString(16);
        } catch (NoSuchAlgorithmException nsae) {
            // ignore
        }
        return hashword;
    }


    public List<File> getFiles(String applicationPath, List<String> stringList) {
        List<File> mobileCssList = new LinkedList<File>();
        for (String fileString : stringList) {
            File cssFile = new File(applicationPath + "/" + fileString);
            if (cssFile.exists()) {
                System.out.println("File: " + cssFile.getAbsolutePath());
                mobileCssList.add(cssFile);
            } else {
                System.out.println("File: " + applicationPath + fileString + " doesn't exist");
            }
        }
        return mobileCssList;
    }

}
