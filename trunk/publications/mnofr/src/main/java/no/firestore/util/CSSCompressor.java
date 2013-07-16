/**
 * Klasse som komprimerer CSS og pakker sammen til en fil.
 */

package no.firestore.util;

import java.io.*;
import java.util.Date;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

public class CSSCompressor extends Compressor {

    protected final Logger logger = Logger.getLogger(getClass());
    Vector fileNamesUrl;
    String filename;
    String css;
    String directory;
    String stylesheetUrl;
    String forceRebuild;

    /**
     * Setter url'en til der den endelige filen skal lagres
     *
     * @param stylesheetUrl
     */
    public void setStylesheetUrl(String stylesheetUrl) {
        this.stylesheetUrl = stylesheetUrl;
    }

    /**
     * Hvis denne ikke er tom, skal filen bygges på ny
     *
     * @param forceRebuild
     */
    public void setForceRebuild(String forceRebuild) {
        this.forceRebuild = forceRebuild;
    }

    /**
     * Setter sti til katalogen til der filene ligger
     *
     * @param directory
     */
    public void setDirectory(String directory) {
        this.directory = directory;
    }

    /**
     * Setter css'en, altså navnet på de filene som skal slås sammen
     *
     * @param css
     */
    public void setCss(String css) {
        this.css = css;
    }

    public CSSCompressor() {
    }


    /**
     *
     *
     * @return
     */
    public int doStartTag() {
        if (logger.isDebugEnabled()) {
            logger.debug((new StringBuilder()).append("filename: ").append(css).toString());
            logger.debug((new StringBuilder()).append("directory: ").append(directory).toString());
            logger.debug((new StringBuilder()).append("forceRebuild: ").append(forceRebuild).toString());
            logger.debug((new StringBuilder()).append("stylesheetUrl: ").append(stylesheetUrl).toString());
        }

        String[] tempFileNamesUrl = css.split(",");
        fileNamesUrl= stringArrayToVector(tempFileNamesUrl);

        //Generer filnavn basert på det som er lagret i css
        filename = setFileName(fileNamesUrl,".css");
        if (logger.isDebugEnabled())
            logger.debug("css filename: " + filename);
        File file = new File(directory);
        //Sjekk om filen finnes
        File files[] = file.listFiles(new FilenameFilter() {
            public boolean accept(File file2, String s1) {
                return s1.toLowerCase().matches(filename+".*\\.css");
            }});
        if (logger.isDebugEnabled())
            logger.debug("Filer med filnavn som minner:" +files.length);


        //Hvis filen ikke finnes og det ikke kommer inn forespørsel om å regenerere, returner link til filen
        if (files.length == 1 && forceRebuild.equals("")) {
            if (logger.isDebugEnabled())
                logger.debug("fil finnes, og vi skal ikke lage den på ny, skriver ut eksisterende fil");
            try {
                pageContext.getOut().write("<link href=\""+stylesheetUrl+files[0].getName()+"\" media=\"screen\" rel=\"StyleSheet\" type=\"text/css\"/>");
            }
            catch (Exception exception) {
                logger.error("Feil ved skriving til side: "+exception.toString());
            }
            return 1;
        }



        //Kommer vi hit, så finnes ikke filen, eller vi skal generere en ny
        if (logger.isDebugEnabled())
            logger.debug("leser filer og genererer ny css");

        //Leser filene
        StringBuffer stringbuffer = readFiles(fileNamesUrl,directory);

        //Komprimerer
        String compressedCss = compress(stringbuffer);
        Date date = new Date();

        //Navnet på filen
        filename = filename+date.getTime()+".css";

        //Sletter alle eksisterende filer
        for (int j = 0; j < files.length; j++) {
            File thisFile = files[j];
            thisFile.delete();
        }

        //TODO: vent med å slette filer til vi er sikre på at filen genereres

        //Skriver til ny fil, og returnerer link til nylig opprettet fil
        boolean success = writeToFile(compressedCss, directory+filename);
        if (success)
            try {
                pageContext.getOut().write((new StringBuilder()).append("<link href=\"").append(stylesheetUrl).append(filename).append("\" media=\"screen\" rel=\"StyleSheet\" type=\"text/css\"/>").toString());
            }
            catch (Exception e) {
                logger.error("Noe gikk feil!" +e.toString());
        }else{
            logger.error("Fikk ikke generert css, kunne ikke skrive til fil");
        }
        return 1;
    }



    
    /**
     *  Komprimerer og effetiviserer css'en
     *
     *  Author: Julien Lecomte <jlecomte@yahoo-inc.com>
     * Copyright (c) 2007, Yahoo! Inc. All rights reserved.
     * Code licensed under the BSD License:
     *     http://developer.yahoo.net/yui/license.txt
     *
     *
     *  Tilpasset firestore rammeverket av odd-r. hogstad
     *  odd.r.hogstad@aftenbladet.no
     */
    private String compress(StringBuffer stringBuffer) {
        Pattern p;
        Matcher m;
        String css;
        StringBuffer sb;
        int startIndex, endIndex;
        // Remove all comment blocks...
        startIndex = 0;
        boolean iemac = false;
        sb = new StringBuffer(stringBuffer.toString());
        while ((startIndex = sb.indexOf("/*", startIndex)) >= 0) {
            endIndex = sb.indexOf("*/", startIndex + 2);
            if (endIndex >= startIndex + 2) {
                if (sb.charAt(endIndex - 1) == '\\') {
                    // Looks like a comment to hide rules from IE Mac.
                    // Leave this comment, and the following one, alone...
                    startIndex = endIndex + 2;
                    iemac = true;
                } else if (iemac) {
                    startIndex = endIndex + 2;
                    iemac = false;
                } else {
                    sb.delete(startIndex, endIndex + 2);
                }
            }
        }

        css = sb.toString();

        // Normalize all whitespace strings to single spaces. Easier to work with that way.
        css = css.replaceAll("\\s+", " ");

        // Make a pseudo class for the Box Model Hack
        css = css.replaceAll("\"\\\\\"}\\\\\"\"", "___PSEUDOCLASSBMH___");

        // Remove the spaces before the things that should not have spaces before them.
        // But, be careful not to turn "p :link {...}" into "p:link{...}"
        // Swap out any pseudo-class colons with the token, and then swap back.
        sb = new StringBuffer();
        p = Pattern.compile("(^|\\})(([^\\{:])+:)+([^\\{]*\\{)");
        m = p.matcher(css);
        while (m.find()) {
            String s = m.group();
            s = s.replaceAll(":", "___PSEUDOCLASSCOLON___");
            m.appendReplacement(sb, s);
        }
        m.appendTail(sb);
        css = sb.toString();
        css = css.replaceAll("\\s+([!{};:>+\\(\\)\\],])", "$1");
        css = css.replaceAll("___PSEUDOCLASSCOLON___", ":");

        // Remove the spaces after the things that should not have spaces after them.
        css = css.replaceAll("([!{}:;>+\\(\\[,])\\s+", "$1");

        // Add the semicolon where it's missing.
        css = css.replaceAll("([^;\\}])}", "$1;}");

        // Replace 0(px,em,%) with 0.
        css = css.replaceAll("([\\s:])(0)(px|em|%|in|cm|mm|pc|pt|ex)", "$1$2");

        // Replace 0 0 0 0; with 0.
        css = css.replaceAll(":0 0 0 0;", ":0;");
        css = css.replaceAll(":0 0 0;", ":0;");
        css = css.replaceAll(":0 0;", ":0;");
        // Replace background-position:0; with background-position:0 0;
        css = css.replaceAll("background-position:0;", "background-position:0 0;");

        // Replace 0.6 to .6, but only when preceded by : or a white-space
        css = css.replaceAll("(:|\\s)0+\\.(\\d+)", "$1.$2");

        // Shorten colors from rgb(51,102,153) to #336699
        // This makes it more likely that it'll get further compressed in the next step.
        p = Pattern.compile("rgb\\s*\\(\\s*([0-9,\\s]+)\\s*\\)");
        m = p.matcher(css);
        sb = new StringBuffer();
        while (m.find()) {
            String[] rgbcolors = m.group(1).split(",");
            StringBuffer hexcolor = new StringBuffer("#");
            for (int i = 0; i < rgbcolors.length; i++) {
                int val = Integer.parseInt(rgbcolors[i]);
                if (val < 16) {
                    hexcolor.append("0");
                }
                hexcolor.append(Integer.toHexString(val));
            }
            m.appendReplacement(sb, hexcolor.toString());
        }
        m.appendTail(sb);
        css = sb.toString();

        // Shorten colors from #AABBCC to #ABC. Note that we want to make sure
        // the color is not preceded by either ", " or =. Indeed, the property
        //     filter: chroma(color="#FFFFFF");
        // would become
        //     filter: chroma(color="#FFF");
        // which makes the filter break in IE.
        p = Pattern.compile("([^\"'=\\s])(\\s*)#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])");
        m = p.matcher(css);
        sb = new StringBuffer();
        while (m.find()) {
            // Test for AABBCC pattern
            if (m.group(3).equalsIgnoreCase(m.group(4)) &&
                    m.group(5).equalsIgnoreCase(m.group(6)) &&
                    m.group(7).equalsIgnoreCase(m.group(8))) {
                m.appendReplacement(sb, m.group(1) + m.group(2) + "#" + m.group(3) + m.group(5) + m.group(7));
            } else {
                m.appendReplacement(sb, m.group());
            }
        }
        m.appendTail(sb);
        css = sb.toString();
        // Remove empty rules.
        css = css.replaceAll("[^\\}]+\\{;\\}", "");
        // Replace the pseudo class for the Box Model Hack
        css = css.replaceAll("___PSEUDOCLASSBMH___", "\"\\\\\"}\\\\\"\"");
        // Trim the final string (for any leading or trailing white spaces)
        css = css.trim();


        //Ta bort alle elementer som forekommer mer enn en gang
        //lagt til av odd.r.hogstad@aftenbladet.no
        Hashtable h=new Hashtable();
        System.out.println(css);
        System.out.println(css.length());
        Pattern pattern = Pattern.compile("([^{]+)(\\{[^}]+\\})");
        Matcher matcher = pattern.matcher(css);
        while (matcher.find()) {
            h.put("____"+matcher.group(1)+"____","____"+matcher.group(2)+"____");
        }
        css=h.toString();
        //css=css.substring(1,css.length()-1);
        css=css.replaceAll("\\{____","");
        css=css.replaceAll("____\\}","");
        css=css.replaceAll("____=____","");
        css=css.replaceAll("____, ____","");
        System.out.println(css.length());
        Pattern pattern1 = Pattern.compile("([^{]+)(\\{[^}]+\\})");


        Hashtable hashtable = new Hashtable();
        for (Matcher matcher1 = pattern1.matcher(css); matcher1.find(); hashtable.put("____"+matcher1.group(1)+"____","____"+matcher1.group(2)+"____"))
            ;



        css = hashtable.toString();
        css = css.replaceAll("\\{____", "");
        css = css.replaceAll("____\\}", "");
        css = css.replaceAll("____=____", "");
        css = css.replaceAll("____, ____", "");
        System.out.println(css.length());
        return css;
    }


}
