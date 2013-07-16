package no.firestore.sectionParameter;

import neo.xredsys.api.*;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.util.*;



public class SectionParameterRepository {


	private String sectionUniqueName;
	private long version = 0;
	private String sectionParameter;
	private IOAPI api;
	private Publication pub;
	private Section sec;
	private String propertiesDirectory = "/data/media/bt/sectionParameters/";

	public Properties ParameterCache = new Properties();

	public String getPropertiesDirectory() {
		return propertiesDirectory;
	}
	public void setPropertiesDirectory(String s) {
		propertiesDirectory = s;
	}

	public SectionParameterRepository() {
		api = IOAPI.getAPI(); // Get Escenic API
	}

	public void setPub(String publication) {
		pub = api.getObjectLoader().getPublication(publication); // Set publication
	}

	public String getSectionUniqueName() {
		return sectionUniqueName;
	}

	public void setSectionUniqueName(String sectionUniqueName) {
		this.sectionUniqueName = sectionUniqueName; // Set section unique name
		sec = api.getObjectLoader().getSectionByUniqueName(pub.getId(),sectionUniqueName); // Initialize variable "sec"
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

	public String getSectionParameter() {
		return sectionParameter;
	}

	public void setSectionParameter(String sectionParameter) {
		this.sectionParameter = sectionParameter;
	}


	public SortedMap <Long,String> getSectionParameterVersions() {
	    File dir = new File(getPropertiesDirectory());

	    String[] children = dir.list();

	    FilenameFilter filter = new FilenameFilter() {
	        public boolean accept(File dir, String name) {
	            return name.startsWith(getSectionUniqueName()+"-");
	        }
	    };
	    children = dir.list(filter);

	    List <String> elementList = new ArrayList <String>();
	    for (int i=0;i<children.length;i++) {
	    	elementList.add(children[i]);
	    }

	   SortedMap <Long,String> p = new TreeMap <Long,String> () ;

	    for (int i=0;i<children.length;i++) {
			try {
				String s = elementList.get(i).split("-")[1];
				s = s.substring(0,s.lastIndexOf("."));
				long l = new Long(s);
				p.put(0-l,i+": "+new Date(l).toString());
			} catch (Exception e) {}
		}


	    return p;
	}

	@SuppressWarnings("unchecked")
	public SortedMap getSectionParameters() {

		SortedMap p = new TreeMap();

		if (getVersion() != 0) {
			try {
				FileInputStream fis = new FileInputStream(getCurrentFilename());
				Properties p2 = new Properties();
				p2.load(fis);
				fis.close();
				p.putAll(p2);
			} catch (Exception e) {
				// @TODO: Handle exception
			}

		} else {
			java.util.Collection mySet = sec.getDeclaredParameterNameSet();
			List l = new ArrayList();
			l.addAll(mySet);
			// Collections.sort(l);
			for (int i=0;i<l.size();i++) {
				p.put(l.get(i),sec.getParameter((String)l.get(i)));
			}

		}
		return p;
	}

	public String getSectionParameterValue() {
		return sec.getParameter(sectionParameter);

	}

	public void setSectionParameters(SortedMap smp) {
	try {
	    System.out.println("Saving parameters...");
        Properties parameterPairs = new Properties();
        Set keys = smp.keySet();
        for (Iterator i = keys.iterator(); i.hasNext();) {
            Object key = i.next();
            String value = (String) smp.get(key);
            parameterPairs.setProperty((String)key,value);
        }
		SectionTransaction mySecTrans = (SectionTransaction)sec.breakAndLock(null);
		mySecTrans.setParameters(parameterPairs);
		mySecTrans.update();
		mySecTrans.release();

		FileOutputStream fos = new FileOutputStream(getNewFilename());
		parameterPairs.store(fos, null);
		fos.close();

		} catch (Exception e) {
			System.out.println("An error occured while saving parameters "+e);
			// @TODO: Handle this exception!
		}
	}

	private String getNewFilename() {
		String s = getPropertiesDirectory() + getSectionUniqueName()+"-"+new Date().getTime() + ".properties";
		return s;
	}
	private String getCurrentFilename() {
		String s = getPropertiesDirectory() + getSectionUniqueName() + getVersion() + ".properties";

		return s;

	}
}
