package no.medianorge.utils;

import neo.xredsys.api.Section;

/**
 * Date: 05.03.12
 * Time: 09.08
 * $URL: $
 *
 * @author $Author: regearne$ (created by)
 * @version $Revision: $ $Date: $
 */
public class CoreUtils {
    /**
     *
     * @param section
     * @param rootSectionName
     * @return
     */
    public static Section resolveBaseSection(Section section,String rootSectionName){
        while(section.getParent() != null && !section.getParent().getUniqueName().equals(rootSectionName)){
            section = section.getParent();
        }
        return section;
    }
}
