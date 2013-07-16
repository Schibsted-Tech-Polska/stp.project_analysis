package tools;

import com.escenic.common.util.JSONMap;

import java.util.Map;


/**
 * Date: 10.02.12
 * Time: 16.01
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class Json2Java {
    public static void main(String[] args) {
        String s = "{\"user\":{\"displayName\":\"Geir Arnesen\",\"userId\":1,\"lastChanged\":1328886480037,\"storageItem\":[{\"lastChanged\":1328877025000,\"storageType\":{\"storageType\":\"articleid\",\"storageTypeId\":1},\"storageId\":2,\"storage\":\"2180749\"},{\"lastChanged\":1328815575000,\"storageType\":{\"storageType\":\"articleid\",\"storageTypeId\":1},\"storageId\":1,\"storage\":\"12345\"}],\"chat\":[{\"status\":0,\"lastChanged\":1328709344000,\"chatId\":1,\"nickname\":\"GeirA\"}],\"spId\":100014,\"roleId\":0,\"created\":1328709320000}}";
        JSONMap map = new JSONMap(s);
        JSONMap.JSONList lst = (JSONMap.JSONList) ((Map) map.get("user")).get("storageItem");
        for(Object m:lst){
            JSONMap mp = (JSONMap) m;
            System.out.println(""+mp);
        }
//        List lst = (List) (((Map) map.get("user")).get("storageItem")).get(1);
        System.out.println();
    }
}
