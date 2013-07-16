package no.medianorge.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 * Klasse laget av Media Norge Digital.
 * User: reanberg
 * Date: Jan 18, 2011
 * Time: 10:23:11 AM
 * <p/>
 * <p/>
 * You may think you know what the following code does.
 * But you dont. Trust me.
 * Fiddle with it, and youll spend many a sleepless
 * night cursing the moment you thought youd be clever
 * enough to "optimize" the code below.
 * Now close this file and go play with something else.
 */
public class HttpUtil {
    private Log log = LogFactory.getLog(HttpUtil.class);
    
     public String getHtml(String rawAd){
        String body = "";
        try {
            URL url = new URL(rawAd);
            URLConnection ucon = url.openConnection();
            ucon.setConnectTimeout(600);
            ucon.connect();

            BufferedReader in = new BufferedReader(new InputStreamReader(ucon.getInputStream()));

            String inputLine;
            StringBuilder sb = new StringBuilder();

            while ((inputLine = in.readLine()) != null)
                sb.append(inputLine);
            in.close();

            body = sb.toString().trim();

        } catch (MalformedURLException e) {
            e.printStackTrace();
        }catch(IOException ieo){
            log.error("Could not get url [" + rawAd + "]");
            ieo.printStackTrace();
        }
        return body;
    }
}
