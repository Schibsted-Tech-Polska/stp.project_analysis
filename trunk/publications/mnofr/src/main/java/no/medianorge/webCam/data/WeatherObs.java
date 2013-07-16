package no.medianorge.webCam.data;

/**
 * Created by IntelliJ IDEA.
 * User: torill
 * Date: Jan 11, 2011
 * Time: 11:49:26 AM
 * To change this template use File | Settings | File Templates.
 */
public class WeatherObs {
    private String placeName;
    private String timestamp;
    private String windstrength;
    private String winddirection;
    private String winddirectionName;
    private String temperature;
    private String seatemperature;
    private String sealevelpressure;
    private String humidity;
    private String dewpoint;

    public static String getDirectionName(int windDir) {
       String sReturn  = "";

       if (windDir >= 337.5 || windDir < 22.5)
           sReturn = "N";
       else if (windDir >= 22.5 || windDir < 67.5)
           sReturn = "N�";
       else if (windDir >= 67.5 || windDir < 112.5)
           sReturn = "�";
       else if (windDir >= 112.5 || windDir < 157.5)
           sReturn = "S�";
       else if (windDir >= 157.5 || windDir < 202.5)
           sReturn = "S";
       else if (windDir >= 202.5 || windDir < 247.5)
           sReturn = "SV";
       else if (windDir >= 247.5 || windDir < 292.5)
           sReturn = "V";
       else
           sReturn = "NV";

        return sReturn;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public String getDewpoint() {
        return dewpoint;
    }

    public void setDewpoint(String dewpoint) {
        this.dewpoint = dewpoint;
    }

    public String getHumidity() {
        return humidity;
    }

    public void setHumidity(String humidity) {
        this.humidity = humidity;
    }

    public String getSealevelpressure() {
        return sealevelpressure;
    }

    public void setSealevelpressure(String sealevelpressure) {
        this.sealevelpressure = sealevelpressure;
    }

    public String getSeatemperature() {
        return seatemperature;
    }

    public void setSeatemperature(String seatemperature) {
        this.seatemperature = seatemperature;
    }

    public String getTemperature() {
        return temperature;
    }

    public void setTemperature(String temperature) {
        this.temperature = temperature;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getWinddirection() {
        return winddirection;
    }

    public void setWinddirection(String winddirection) {
        this.winddirection = winddirection;
    }

    public String getWinddirectionName() {
        return winddirectionName;
    }

    public void setWinddirectionName(String winddirectionName) {
        this.winddirectionName = winddirectionName;
    }

    public String getWindstrength() {
        return windstrength;
    }

    public void setWindstrength(String windstrength) {
        this.windstrength = windstrength;
    }
}

