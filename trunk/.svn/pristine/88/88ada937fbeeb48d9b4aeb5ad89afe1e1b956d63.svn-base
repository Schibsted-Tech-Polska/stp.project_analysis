package no.mno.minifier;

import org.junit.Test;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

/**
 * Date: 23.08.12
 * Time: 07:56
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class JsCssManagerTest {

    @Test
    public void getAllJsFilesToCombineTest() throws Exception {
        JsCssManager cssManager = new JsCssManager();
        List<String> skipList = new LinkedList<String>();
        List<String> prependOrder = new LinkedList<String>();
        List<String> order = new LinkedList<String>();
        String jsPath = "";
        LinkedList<LinkedList<File>> allJsFilesToCombine = cssManager.getAllJsFilesToCombine("./src/test/data",skipList,prependOrder,order,jsPath);

    }
}
