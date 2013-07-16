package no.mno.minifier;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Date: 23.08.12
 * Time: 13:24
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class MainTest {



    public static void main(String[] args) throws Exception {
        JsCssManager manager = new JsCssManager();
        String applicationPath = args[0];
        String cssGlobalPath = "skins/global";

        String pubDir = "skins/publications/ap";

        String specGlobalDir = null;
        String specPubDir = null;

        List<String> skipCss = loadFileIntoCollection(applicationPath+"/resources/minify-config/skipListCss_ap.txt");

        List<String> orderCss = loadFileIntoCollection(applicationPath+"/resources/minify-config/orderListCss.txt");
        List<String> lastOrderCss = loadFileIntoCollection(applicationPath+"/resources/minify-config/lastOrderListCss.txt");
        List<File> files = manager.getAllCssFiles(applicationPath,
                cssGlobalPath,
                pubDir,
                specGlobalDir,
                specPubDir,
                skipCss,
                orderCss,
                lastOrderCss);

        for(File f :files){
            System.out.println(f.getAbsolutePath());
        }
    }


    private static List<String> loadFileIntoCollection(String filename) throws IOException {
        List<String> collection = new ArrayList();

        String path = "";
        try {
            byte[] b = FileUtils.readFileToByteArray(new File(filename));
            String[] strings = StringUtils.split(new String(b), "\n\r");
            for (String line : strings) {
                collection.add(line);
            }
            return collection;
        } catch (FileNotFoundException fnf) {
            System.out.println("XXX - FILE NOT FOUND " + path + "- XXX");
            return null;
        }

    }


}
