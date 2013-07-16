package no.firestore.util;

import org.apache.log4j.Logger;

import java.io.*;
import java.util.Date;
import java.util.Vector;
import java.util.regex.Pattern;
import java.util.regex.Matcher;


/**
 * Created by IntelliJ IDEA.
 * User: ohogstad
 * Date: 21.apr.2008
 * Time: 14:45:36
 * To change this template use File | Settings | File Templates.
 */
public class JSCompressor extends Compressor {
    String directory;
    String javascript;
    String javascriptUrl;
    String forceRebuild;
    Vector javascriptFiles;
    String filename;
    protected final Logger logger = Logger.getLogger(getClass());

    public String getDirectory() {
        return directory;
    }

    public void setDirectory(String directory) {
        this.directory = directory;
    }

    public String getJavascript() {
        return javascript;
    }

    public void setJavascript(String javascript) {
        this.javascript = javascript;
    }

    public String getJavascriptUrl() {
        return javascriptUrl;
    }

    public void setJavascriptUrl(String javascriptUrl) {
        this.javascriptUrl = javascriptUrl;
    }

    public String getForceRebuild() {
        return forceRebuild;
    }

    public void setForceRebuild(String forceRebuild) {
        this.forceRebuild = forceRebuild;
    }

    public int doStartTag() {
        if (logger.isDebugEnabled()) {
            logger.debug("javascriptUrl: " + javascriptUrl);
            logger.debug("javascript: " + javascript);
            logger.debug("forceRebuild: " + forceRebuild);
            logger.debug("directory: " + directory);
        }
        String[] tempJavascriptFiles = javascript.split(",");
        javascriptFiles=stringArrayToVector(tempJavascriptFiles);

        //Generer filnavn basert på det som er lagret i js
        filename = setFileName(javascriptFiles,".js");
        File file = new File(directory);
        
        //Sjekk om filen finnes
        File files[] = file.listFiles(new FilenameFilter() {
            public boolean accept(File file2, String s1) {
                return s1.toLowerCase().matches(filename+".+\\.js");
            }});


        if (logger.isDebugEnabled())
            logger.debug("Filer med filnavn som minner:" +files.length);


        //Hvis filen finnes og det ikke kommer inn forespørsel om å regenerere, returner link til filen
        /*if (files.length == 1 && forceRebuild.equals("")) {
            if (logger.isDebugEnabled())
                logger.debug("fil finnes, og vi skal ikke lage den på ny, skriver ut eksisterende fil");
            try {
                pageContext.getOut().write("<script type=\"text/javascript\" src=\""+javascriptUrl+"/"+files[0].getName()+"\"></script>");
            }
            catch (Exception exception) {
                logger.error("Feil ved skriving til side: "+exception.toString());
            }
            return 1;
        } */
        //Kommer vi hit, så finnes ikke filen, eller vi skal generere en ny. Slår først sammen alle filene til én stor en
        if (logger.isDebugEnabled())
            logger.debug("leser filer og genererer ny bundlet js");
        //Lager ny fil
        for (int j = 0; j < files.length; j++) {
            if(logger.isDebugEnabled())
                logger.debug("Skal slette: "+files[j].getName());
            File thisFile = files[j];
            thisFile.delete();
        }
        StringBuffer stringbuffer = readFiles(javascriptFiles,directory);
        Date date = new Date();
        filename = filename+date.getTime()+".js";

        String s=stringbuffer.toString();
        //Tar bort alle kommentarer
        s=s.replaceAll("(/\\*[\\d\\D]*?\\*/)|(\\/\\*(\\s*|.*?)*\\*\\/)|(\\/\\/.*)|(/\\\\*[\\\\d\\\\D]*?\\\\*/)|([\\r\\n ]*//[^\\r\\n]*)+","");

        //Tar bort alle linjeskift
        s= s.replaceAll("\n+", " ");

        //Tar bort alle tabber
        s=s.replaceAll("\t+", " ");

        //Tar bort alle multiple mellomrom
        s = s.replaceAll(" +", " ");
        boolean success = writeToFile(s, directory+filename);
        if(logger.isDebugEnabled()){
                logger.debug("Opprettet fil?:"+success);
                File f = new File(directory+filename);
                logger.debug("Eksisterer filen?: "+f.exists());
        }
            try {
                pageContext.getOut().write("<script type=\"text/javascript\" src=\""+javascriptUrl+filename+"\"></script>");
            }
            catch (Exception e) {
                logger.error("Noe gikk feil!" +e.toString());
            //TODO: komprimeringen feilet, slå sammen til en fil, og skriv feil i errorloggen
            //

        }
        return 1;
    }
}