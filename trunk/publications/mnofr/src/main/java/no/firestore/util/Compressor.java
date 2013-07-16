package no.firestore.util;

import org.apache.log4j.Logger;

import javax.servlet.jsp.tagext.TagSupport;
import java.io.*;
import java.util.Vector;

/**
 * Created by IntelliJ IDEA.
 * User: ohogstad
 * Date: 22.apr.2008
 * Time: 09:11:26
 * To change this template use File | Settings | File Templates.
 */
public class Compressor extends TagSupport {

    /**
         *
         * Leser inn alle filene
         *
         * @return
         */
        protected final Logger logger = Logger.getLogger(getClass());

        public StringBuffer readFiles(Vector fileNamesUrl,String directory) {
            StringBuffer stringbuffer = new StringBuffer();
            if (logger.isDebugEnabled())
                logger.debug("fileNames:"+fileNamesUrl);
            for (int k = 0; k < fileNamesUrl.size(); k++) {
                String filename = (String)fileNamesUrl.get(k);
                if (logger.isDebugEnabled())
                    logger.debug("filename to read: "+filename);
                //Object obj = null;
                try {
                    if (filename.length() <= 0)
                        continue;
                    File file = new File(directory+filename);
                    FileInputStream fileinputstream = new FileInputStream(file);
                    int l;
                    while ((l = fileinputstream.read()) != -1)
                        stringbuffer.append((char) l);
                    fileinputstream.close();
                    continue;
                }
                catch (FileNotFoundException fe) {
                    logger.error("Feil:"+fe.toString());
                }
                catch (IOException ioexception) {
                    logger.error("Feil: " +ioexception);
                }
                catch (Exception exception) {
                    logger.error("Feil: " + exception);
                }
            }
            return stringbuffer;
        }

    /**
     * Metode som setter filnavnet det skal letes etter....
     *
     * @return
     */
    public String setFileName(Vector fileNamesUrl, String postfix) {
        String filename = "";
        for (int j = 0; j < fileNamesUrl.size(); j++) {
            String thisFilename = (String) fileNamesUrl.get(j);
            if (logger.isDebugEnabled())
                logger.debug("element: "+thisFilename);
            try {
                thisFilename = thisFilename.substring(thisFilename.lastIndexOf("/") + 1, thisFilename.lastIndexOf(postfix)).toLowerCase().trim();
                if (logger.isDebugEnabled())
                    logger.debug("filnavn: " + thisFilename);
                filename+= thisFilename;
            }
            catch (Exception e) {
                logger.error("Noe gikk galt ved generering av filnavn: " +e.toString());
            }
        }
        if(logger.isDebugEnabled())
            logger.debug("filename is sat to: "+filename);
        return filename;
    }

    /**
     * Gjør en tabell av strenger om til en vector. Fjerner duplikater og tomme forekomster
     *
     * TODO: finn på noe bedre!
     *
     * @param stringArray
     * @return
     */
    public Vector stringArrayToVector(String [] stringArray){
        Vector v=new Vector();
        if (logger.isDebugEnabled())
            logger.debug("størrelse på strengtabell: " + stringArray.length);
        for(int i=0;i<stringArray.length;i++){
            String s=stringArray[i];
            if(logger.isDebugEnabled()){
                logger.debug("s: "+s);
            }
            if(!s.equals("") && v.indexOf(s) == -1)
                v.add(s);
        }
        if (logger.isDebugEnabled())
            logger.debug("størrelse på vector: " + v.size());
        return v;
    }

        /**
         * Skriver en gitt streng et gitt filnavn
         *
         * 
         */
        public boolean writeToFile(String output, String filename) {
            File file;
            FileWriter filewriter;
            boolean flag;
            file = new File(filename);
            filewriter = null;
            flag = true;
            try {
                filewriter = new FileWriter(file);
                filewriter.write(output);
                filewriter.close();
            }
            catch (IOException ioexception) {
                logger.error("Feil: "+ioexception);
            }
            return flag;
        }




}
