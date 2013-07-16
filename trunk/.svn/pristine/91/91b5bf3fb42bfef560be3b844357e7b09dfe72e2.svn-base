package no.mno.minifier;

import org.apache.commons.lang.StringUtils;

import java.io.*;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: ARISINAB
 * Date: 03.apr.2011
 * Time: 23:21:08
 * To change this template use File | Settings | File Templates.
 */
public class Main {
    static List<String> skipListJs;
    static List<String> prependOrderNoMinifyJs;
    static List<String> compressOrderListJs;
    static List<String> skipListCss;
    static List<String> excludeMinifyCss;
    static List<String> orderListCss;
    static List<String> lastOrderListCss;
    static List<String> mobileCssList;
    static List<String> mobileJsList;
    static HashMap<String, String> defaultOptions;

    public static void main (String args[]) {


        if(args != null && args.length > 0){

            setDefaultValues();
            setArguments(args);

            if(defaultOptions.get("-minifyAll").equals("true")){
                if(defaultOptions.get("-minify").equals("js")){
                    WriteMiniResp resp = minifyJs(
                            defaultOptions.get("-appPath"),
                            defaultOptions.get("-jsPath"),
                            defaultOptions.get("-jsMinifyPath"),
                            skipListJs,
                            prependOrderNoMinifyJs,
                            compressOrderListJs,
                            defaultOptions.get("-readEncoding"));
                    if(resp.getSuccess()){
                        WriteIncludeFile(resp.getFileName(),"jsInclude.html",defaultOptions.get("-url") ,true);
                        System.out.print("success for js");
                    }else{
                        System.out.println(resp.getErrroMessage());
                    }
                }
                if(defaultOptions.get("-minify").equals("css") && !defaultOptions.get("-pubDir").equals("")){
                    WriteMiniResp resp = minifyCss(
                            defaultOptions.get("-appPath"),
                            defaultOptions.get("-cssPath"),
                            defaultOptions.get("-cssMinifyPath"),
                            defaultOptions.get("-pubDir"),
                            defaultOptions.get("-specGlobalDir"),
                            defaultOptions.get("-specPubDir"),
//                            defaultOptions.get("-excludePubs"),
                            skipListCss,
                            orderListCss,
                            lastOrderListCss,
                            excludeMinifyCss);
                    if(resp.getSuccess()){
                        WriteIncludeFile(resp.getFileName(),"cssInclude.html",defaultOptions.get("-url") ,false);
                        System.out.print("success for css");
                    }else{
                        System.out.println(resp.getErrroMessage());
                    }
                }
                if(defaultOptions.get("-minify").equals("cssMobile")){
                    WriteMiniResp resp = minifyMobileCss(
                            defaultOptions.get("-appPath"),
                            defaultOptions.get("-cssMinifyPath"),
                            ".mobileminiFile.css",
                            mobileCssList);
                    if(resp.getSuccess()){
                        WriteIncludeFile(resp.getFileName(),"cssMobileInclude.html",defaultOptions.get("-url") ,false);
                        System.out.print("success for css mobile");
                    }else{
                        System.out.println(resp.getErrroMessage());
                    }
                }
                if(defaultOptions.get("-minify").equals("jsMobile")){
                    WriteMiniResp resp = minifyMobileJs(
                            defaultOptions.get("-appPath"),
                            defaultOptions.get("-jsMinifyPath"),
                            ".mobileminiFile.js",
                            mobileJsList,
                            defaultOptions.get("-readEncoding"));
                    if(resp.getSuccess()){
                        WriteIncludeFile(resp.getFileName(),"jsMobileInclude.html",defaultOptions.get("-url") ,true);
                        System.out.print("success for js mobile");
                    }else{
                        System.out.println(resp.getErrroMessage());
                    }
                }
            }
        }else{
            System.out.println("paramters missing!!");
        }
    }

    private static WriteMiniResp minifyMobileCss(String applicationPath, String miniPath, String minfileSuffix, List<String> fileList) {
        JsCssManager cssM = new JsCssManager();
        StringBuilder sb = new StringBuilder();
         // get all skiplist, orders and so on
        try {
            List<File> cssFiles = cssM.getFiles(applicationPath, fileList);
            // find the old cssminifed file
            File cssMinified = cssM.getMiniCssFile(miniPath,minfileSuffix);
            // generate new hash for the new css file
            for(File file : cssFiles)
            {
                sb.append(file.getAbsolutePath() + file.lastModified());
            }
            String newFilename = cssM.md5String(sb.toString()) + minfileSuffix;

            // create file object for the new file
            File newMiniCssJs = new File(miniPath + File.separator + newFilename);

            if(cssMinified != null && cssMinified.exists())
            {
                // write new file if css
                if(!newMiniCssJs.exists())
                {
                    //cssMinified.delete();
                    newMiniCssJs.createNewFile();
                    return cssM.writeMinifed(cssFiles,newMiniCssJs, applicationPath);
                }
                else
                {
                    //newMiniCss.delete();
                    return cssM.writeMinifed(cssFiles,newMiniCssJs,applicationPath);
                }

            }
            else
            {
                newMiniCssJs.createNewFile();
                return cssM.writeMinifed(cssFiles,newMiniCssJs,applicationPath);
            }


        } catch (Exception e) {
            WriteMiniResp resp = new WriteMiniResp();
            resp.setSuccess(false);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PrintStream ps = new PrintStream(baos);
            e.printStackTrace(ps);
            resp.setErrroMessage("ERROR " + baos.toString());
            return resp;
        }
    }

       private static WriteMiniResp minifyMobileJs(String applicationPath, String miniPath, String minfileSuffix, List<String> fileList, String encoding) {
        JsCssManager jsM = new JsCssManager();
        StringBuilder sb = new StringBuilder();
         // get all skiplist, orders and so on
        try {
            List<File> jsFiles = jsM.getFiles(applicationPath, fileList);
            // find the old cssminifed file
            File cssMinified = jsM.getMiniCssFile(miniPath,minfileSuffix);
            // generate new hash for the new css file
            for(File file : jsFiles)
            {
                sb.append(file.getAbsolutePath() + file.lastModified());
            }
            String newFilename = jsM.md5String(sb.toString()) + minfileSuffix;

            // create file object for the new file
            File newMiniJs = new File(miniPath + File.separator + newFilename);

            if(cssMinified != null && cssMinified.exists())
            {
                // write new file if css
                if(!newMiniJs.exists())
                {
                    //cssMinified.delete();
                    newMiniJs.createNewFile();
                    return jsM.writeMinifed(jsFiles,newMiniJs,new ArrayList<File>(),encoding, applicationPath);
                }
                else
                {
                    //newMiniCss.delete();
                    return jsM.writeMinifed(jsFiles,newMiniJs,new ArrayList<File>(),encoding, applicationPath);
                }

            }
            else
            {
                newMiniJs.createNewFile();
                return jsM.writeMinifed(jsFiles,newMiniJs,new ArrayList<File>(),encoding, applicationPath);
            }


        } catch (Exception e) {
            WriteMiniResp resp = new WriteMiniResp();
            resp.setSuccess(false);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PrintStream ps = new PrintStream(baos);
            e.printStackTrace(ps);
            resp.setErrroMessage("ERROR " + baos.toString());
            return resp;
        }
    }


    public static void setDefaultValues(){
        skipListJs = new LinkedList<String>();
        prependOrderNoMinifyJs = new LinkedList<String>();
        compressOrderListJs = new LinkedList<String>();
        skipListCss = new LinkedList<String>();
        orderListCss = new LinkedList<String>();
        lastOrderListCss = new LinkedList<String>();
        defaultOptions = new HashMap<String,String>();
        defaultOptions.put("-appPath","");
        defaultOptions.put("-jsPath","resources"+ File.separator + "js");
        defaultOptions.put("-cssPath", "skins"+ File.separator + "global");
        defaultOptions.put("-cssMinifyPath", System.getProperty("user.dir"));
        defaultOptions.put("-jsMinifyPath", System.getProperty("user.dir"));
        defaultOptions.put("-pubDir","");
        defaultOptions.put("-minify", "css");
        defaultOptions.put("-url","");
        defaultOptions.put("-minifyAll","true");
        defaultOptions.put("-readEncoding","UTF-8");
    }

    public static void setArguments(String[] args){

        int current = 0;
        for(String arg : args){
            if(arg.trim().equals("-appPath")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-appPath",args[current+1]);
                }
            }
            else if(arg.trim().equals("-jsPath")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-jsPath", args[current+1]);
                }
            }else if(arg.trim().equals("-jsMinifyPath")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-jsMinifyPath", args[current+1]);
                }
            }
            else if(arg.trim().equals("-skipListJs")){
                if(args.length - 1 >= current + 1){
                    skipListJs = ReadFileAndCreateStringList(args[current+1]);
                }
            }
            else if(arg.trim().equals("-prependOrderNoMinifyJs")){
                if(args.length - 1 >= current + 1){
                    prependOrderNoMinifyJs = ReadFileAndCreateStringList(args[current+1]);
                }
            }
            else if(arg.trim().equals("-compressOrderListJs")){
                if(args.length - 1 >= current + 1){
                    compressOrderListJs = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-cssPath")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-cssPath", args[current+1]);
                }
            }else if(arg.trim().equals("-cssMinifyPath")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-cssMinifyPath", args[current+1]);
                }
            }else if(arg.trim().equals("-skipListCss")){
                if(args.length - 1 >= current + 1){
                    skipListCss = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-excludeMinifyCss")){
                if(args.length - 1 >= current + 1){
                    excludeMinifyCss = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-orderListCss")){
                if(args.length - 1 >= current + 1){
                    orderListCss = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-lastOrderListCss")){
                if(args.length - 1 >= current + 1){
                    lastOrderListCss = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-mobileCssList")){
                if(args.length - 1 >= current + 1){
                    mobileCssList = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-mobileJsList")){
                if(args.length - 1 >= current + 1){
                    mobileJsList = ReadFileAndCreateStringList(args[current+1]);
                }
            }else if(arg.trim().equals("-url")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-url", args[current+1]);
                }
            }
            else if(arg.trim().equals("-pubDir")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-pubDir", args[current+1]);
                }
            }
            else if(arg.trim().equals("-specGlobalDir")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-specGlobalDir", args[current+1]);
                }
            }
            else if(arg.trim().equals("-specPubDir")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-specPubDir", args[current+1]);
                }
            }
            else if(arg.trim().equals("-excludePubs")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-excludePubs", args[current+1]);
                }
            }
            else if(arg.trim().equals("-minify")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-minify", args[current+1]);
                }
            }
            else if(arg.trim().equals("-minifyAll")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-minifyAll", args[current+1]);
                }
            }else if(arg.trim().equals("-readEncoding")){
                if(args.length - 1 >= current + 1){
                    defaultOptions.put("-readEncoding", args[current+1]);
                }
            }


            current++;
        }
    }




    public static WriteMiniResp minifyJs(String applicationPath,String jsPath,String jsMinifyPath,  List<String> skipList, List<String> prependOrderBeforeMinified, List<String> combinedJsMinifed, String readEncoding)
    {
        StringBuilder sb = new StringBuilder();

        try {
            JsCssManager jsM = new JsCssManager();
             // get all skiplist, orders and so on
            LinkedList<LinkedList<File>> allFiles = jsM.getAllJsFilesToCombine(applicationPath,
                    skipList,
                    prependOrderBeforeMinified,
                    combinedJsMinifed,
                    jsPath
            );

            // check that all lists are there
            if(allFiles != null){
                // prepend list
                List<File> prependList = allFiles.get(1);
                // append list
                // js files to minify
                List<File> jsFiles = allFiles.get(0);

                // genereate hash key for file
                for(File file : jsFiles)
                {
                    sb.append(file.getAbsolutePath() + file.lastModified());
                }
                String newFilename = jsM.md5String(sb.toString()) + ".miniFile.js";

                // create file object for new file
                File newMiniJs = new File(jsMinifyPath + File.separator + newFilename);

                // find the old file if exist
                File jsMinified = jsM.getMiniJsFile(applicationPath, jsPath, ".miniFile.js");

                //  check if old file exist
                if(jsMinified != null && jsMinified.exists())
                {
                    // check if new file dont exist  then create
                    if(!newMiniJs.exists()){
                        newMiniJs.createNewFile();
                        WriteMiniResp resp = jsM.writeMinifed(jsFiles,newMiniJs,prependList,  readEncoding, applicationPath);
                        if(resp.getSuccess()){
                            jsMinified.delete();
                            return resp;
                        }
                        else{
                             // on fail
                            newMiniJs.delete();
                            return resp;
                        }
                    }
                    else{
                        // delete new file and create again
                        newMiniJs.delete();
                        WriteMiniResp resp = jsM.writeMinifed(jsFiles,newMiniJs,prependList, readEncoding, applicationPath);
                        if(resp.getSuccess()){
                            jsMinified.delete();
                            return resp;
                        }
                        else{
                                  // on fail delete
                            newMiniJs.delete();
                            return resp;
                        }
                    }

                }
                else
                {

                    
                    newMiniJs.delete();
                    newMiniJs.createNewFile();
                    WriteMiniResp resp = jsM.writeMinifed(jsFiles,newMiniJs,prependList,readEncoding,applicationPath);
                    if(!resp.getSuccess())
                    {
                        return resp;
                    }
                    else{


                        return resp;
                    }

                }
            }
            else{
                WriteMiniResp resp = new WriteMiniResp();
                resp.setErrroMessage("ERROR " + "directory missing");
                resp.setSuccess(false);
                return resp;
            }
        }
        catch(Exception e)
        {
            WriteMiniResp resp = new WriteMiniResp();

            resp.setSuccess(false);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PrintStream ps = new PrintStream(baos);

            e.printStackTrace(ps);

            resp.setErrroMessage("ERROR " + baos.toString());
            return resp;
        }
    }

    public static WriteMiniResp minifyCss(String applicationPath, String cssGlobalPath, String cssMinifyPath,
                                          String pubDir,
                                          String specGlobalDir,
                                          String specPubDir,
                                          List<String> skipCss,
                                          List<String> orderCss,
                                          List<String> lastOrderCss,
                                          List<String> excludeMinifyCss){
        skipCss.add(".miniFile.css");
        StringBuilder sb = new StringBuilder();
        try {

            JsCssManager cssM = new JsCssManager();
            List<File> excludedCssFiles = new LinkedList<File>();
             // get all skiplist, orders and so on
            List<File> cssFiles = cssM.getAllCssFiles(
                    applicationPath,
                    cssGlobalPath,
                    pubDir,
                    specGlobalDir,
                    specPubDir,
                    skipCss,
                    orderCss,
                    lastOrderCss
            );

            // Identifying files to be excluded from minifying
            if(excludeMinifyCss != null){
                for(File f :cssFiles){
                    for(String name:excludeMinifyCss){
                        if(f.getAbsolutePath().startsWith(applicationPath+"/"+name)){
                            System.out.println("Excluding: "+f.getAbsolutePath());
                            excludedCssFiles.add(f);
                        }
                    }
                }
            }
            // Removing the excluded files from the collection.
            for(File f:excludedCssFiles){
                cssFiles.remove(f);
            }

            System.out.println("Size after: "+cssFiles.size());
            System.out.println("Size excludedCssFiles: "+excludedCssFiles.size());

            // find the old cssminifed file
            File cssMinified = cssM.getMiniCssFile(cssMinifyPath,".miniFile.css");

            // generate new hash for the new css file
            for(File file : cssFiles)
            {
                sb.append(file.getAbsolutePath() + file.lastModified());
            }
            String newFilename = cssM.md5String(sb.toString()) + ".miniFile.css";

            // create file object for the new file
            File newMiniCss = new File(cssMinifyPath + File.separator + newFilename);

            if(cssMinified != null && cssMinified.exists())
            {
                // write new file if css
                if(!newMiniCss.exists())
                {
                    //cssMinified.delete();
                    newMiniCss.createNewFile();
                    return cssM.writeMinifed(cssFiles,newMiniCss, applicationPath);
                }
                else
                {
                    //newMiniCss.delete();
                    return cssM.writeMinifed(cssFiles,newMiniCss,applicationPath);
                }

            }
            else
            {

                newMiniCss.createNewFile();
                return cssM.writeMinifed(cssFiles,newMiniCss,applicationPath);
            }
        }
        catch(Exception e)
        {
            WriteMiniResp resp = new WriteMiniResp();
            resp.setSuccess(false);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PrintStream ps = new PrintStream(baos);
            e.printStackTrace(ps);
            resp.setErrroMessage("ERROR " + baos.toString());
            return resp;

        }
    }

    public static List<String> ReadFileAndCreateStringList(String filePath){
        try
        {
            File file = new File(filePath);
            if(file.exists())
            {
                List<String> list = new LinkedList<String>();
                FileInputStream fstream = new FileInputStream(filePath);
                DataInputStream in = new DataInputStream(fstream);
                BufferedReader br = new BufferedReader(new InputStreamReader(in));
                String strLine;
                //Read File Line By Line
                while ((strLine = br.readLine()) != null)   {
                    // Print the content on the console
                    if(StringUtils.isNotEmpty(strLine)){
                        list.add(strLine.replace("/", File.separator));
                    }
                    //System.out.println (strLine);
                }
                //Close the input stream
                in.close();
                return list;
            }
            else
            {
                return null;
            }
        }catch (Exception e){//Catch exception if any

            System.err.println("Error: " + e.getMessage());
            return null;
        }
    }

    public static boolean WriteIncludeFile(String fileName, String includeFileName, String url, boolean writeJs){
        try
        {
            String includeContent;
            if(writeJs){
                includeContent = "<script type=\"text/javascript\" src=\"" + url + fileName + "\" ></script>";
            }else{
                includeContent = "<link href=\"" + url + fileName +"\" type=\"text/css\" rel=\"stylesheet\">";
            }
            File includeFile = new File(System.getProperty("user.dir") + File.separator + includeFileName);
            if(includeFile.exists()){
                includeFile.delete();
            }
            FileWriter fstream = new FileWriter(includeFile.getAbsoluteFile());
            includeFile.createNewFile();
            BufferedWriter out = new BufferedWriter(fstream);
            out.write(includeContent);
            out.close();
            return true;
        }catch (Exception e){
            return false;
        }
    }

}
