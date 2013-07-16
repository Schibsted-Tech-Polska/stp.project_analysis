/*
package no.firestore.dirTreeXML;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import org.apache.log4j.Logger;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.*;
import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import neo.xredsys.api.PublicationImpl;

*/
/**
* This class generates XML structure of the targeted directory tree
*
* @author Atle Maeland - atle.maeland@aftenbladet.no
*/
/*
public class DirTreeXML extends BodyTagSupport
{
	protected final int MAXLINES = 30; //number of lines to search in each file (for the <firestore:debug> tag)
	protected final int MAXDEBUGLINES = 10; //number of lines to search inside the <firestore:debug> tag
	protected final Logger logger = Logger.getLogger(getClass());
    private File rootFolder = null;
	private String xmltree = null;
	private String filetype = null;
	private Pattern p = null;
	private int countRootDir = 0;

    */
/**
	* Constructor
	*/
/*
    public DirTreeXML()
    {
    }

    */
/**
	* Set root folder
	* Use request.getSession().getServletContext().getRealPath("/"); to get absolute path to the application directory.
	*
	* @param root - absolute path to root folder
	*/
/*
    public void setRootFolder(String root)
    {
		if(root.equals("")) {
			if (logger.isDebugEnabled()) {
            	logger.warn("path argument is empty");
			}
		} else {
			this.rootFolder = new File(root);
			String absPath = this.rootFolder.getAbsolutePath();
			if(File.separator.equals("\\")) {
				this.p = Pattern.compile("\\\\"); //windows filesystem
			} else {
				this.p = Pattern.compile(File.separator);
			}
			String[] tmp = p.split(absPath);
			this.countRootDir = tmp.length;
		}
    }

	*/
/**
	* Get xml output
	*
	* @return xmltree - XML representation of direcotry tree as specified by root folder
	*/
/*
	public String getXmltree()
	{
		return this.xmltree;
	}

	*/
/**
	* Retrieve parameter names from <firestore:debug> tag (if it exists)
	*/
/*
	public String getParamNames(File f)
	{
		String str;
		String strParams = "";
		int start, end;
		int i = 1;
		int j = 1;
		try {
			BufferedReader in = new BufferedReader(new FileReader(f));
			while((str = in.readLine()) != null && i <= MAXLINES) {
				if(str.contains("<firestore:debug")) { //found the debug tag, search for params
					do {
						str = in.readLine();
						if(str.contains("parameters=")) {
							start = str.indexOf("\"");
							start += 1;
							end = str.indexOf("\"", start);
							strParams = str.substring(start, end);
						}
						j++;
					} while(str != null && j <= MAXDEBUGLINES && !str.contains("parameters"));
					break;
				}
				i++;
			}
			in.close();
		} catch (IOException e) {
		}
		strParams.replaceAll(" ", ""); //remove whitespace
		return strParams;
	}

	*/
/**
	* Recursive function which outputs XML representation of the directory tree
	*
	* @param rootFolder - File
	*/
/*
	public void outputDirectoryContents(File rootFolder)
	{
		String[] contentsAll = rootFolder.list();

		String tmp = null;
		String params = null;
		String relativePath = null;
		String[] tmpfoo;
		int level = 0;

		for(int i = 0; i < contentsAll.length; i++) {
			if(!contentsAll[i].contains(".svn")) { //exclude .svn stuffC:\sdf\
			  // NEXT LINE IS SUSPICIOUS
				File foo = new File(rootFolder+this.pathSeperator+contentsAll[i]);

				tmp = foo.getAbsolutePath();
				tmpfoo = this.p.split(tmp);
				level = tmpfoo.length - this.countRootDir;
				relativePath = tmp.substring(this.rootFolder.getAbsolutePath().length()+1, tmp.length());
				Matcher m = p.matcher(relativePath);
				relativePath = m.replaceAll("/");

				if(foo.isDirectory()) {
					try { pageContext.getOut().write("<folder id=\""+relativePath+"\" name=\""+contentsAll[i]+"\" level=\""+level+"\" >"); } catch(IOException e) {}
					outputDirectoryContents(foo);
					try { pageContext.getOut().write("</folder>"); } catch(IOException e) {}
				} else if(foo.isFile()) {
					//get parameters for this file
					params = getParamNames(foo);
					tmp = foo.getName();
					this.filetype = (tmp.lastIndexOf(".")==-1)?"":tmp.substring(tmp.lastIndexOf(".")+1,tmp.length());
					try { pageContext.getOut().write("<file params=\""+params+"\" id=\""+relativePath+"\" lastModified=\""+foo.lastModified()+"\" type=\""+this.filetype+"\" level=\""+level+"\">"+contentsAll[i]+"</file>"); } catch(IOException e) {}
				}
			}
		}
	}

    */
/**
	* Start method
	*
	* @return 1
	*/
/*
    public int doStartTag()
        throws JspException
    {
		if(this.rootFolder.canRead()) {
			try { pageContext.getOut().write("<folder>"); } catch(IOException e) {}
			outputDirectoryContents(this.rootFolder);
			try { pageContext.getOut().write("</folder>"); } catch(IOException e) {}
		} else {
			logger.warn("invalid path argument");
		}
		return 1;
    }

	*/
/**
	* End method
	*
	* @return 6
	*/
/*
	public int doEndTag() throws JspException
    {
		return 6;
	}
}*/
package no.firestore.dirTreeXML;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import org.apache.log4j.Logger;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.*;
import java.util.*;
import neo.xredsys.api.PublicationImpl;

/**
* This class generates XML structure of the targeted directory tree
*
* @author Atle Maeland - atle.maeland@aftenbladet.no
*/
public class DirTreeXML extends BodyTagSupport
{
	protected final int MAXLINES = 30; //number of lines to search in each file (for the <firestore:debug> tag)
	protected final int MAXDEBUGLINES = 10; //number of lines to search inside the <firestore:debug> tag
	protected final Logger logger = Logger.getLogger(getClass());
    private File rootFolder = null;
	private String xmltree = null;
	private String filetype = null;
	private String pathSeperator = null;
	private int countRootDir = 0;

    /**
	* Constructor
	*/
    public DirTreeXML()
    {
    }

    /**
	* Set root folder
	* Use request.getSession().getServletContext().getRealPath("/"); to get absolute path to the application directory.
	*
	* @param root - absolute path to root folder
	*/
    public void setRootFolder(String root)
    {
		if(root.equals("")) {
			if (logger.isDebugEnabled()) {
            	logger.warn("path argument is empty");
			}
		} else {
			this.rootFolder = new File(root);
			String absPath = this.rootFolder.getAbsolutePath();
			if (File.separator.equals("\\")) {
//				absPath.replaceAll("/", "\\");
				this.pathSeperator = "\\\\";
			} else {
				this.pathSeperator = File.separator;
			}
			logger.info("** pathSeperator = "+this.pathSeperator);
			String[] tmp = absPath.split(this.pathSeperator);
			this.countRootDir = tmp.length;
		}
    }

	/**
	* Get xml output
	*
	* @return xmltree - XML representation of direcotry tree as specified by root folder
	*/
	public String getXmltree()
	{
		return this.xmltree;
	}

	/**
	* Retrieve parameter names from <firestore:debug> tag (if it exists)
	*/
	public String getParamNames(File f)
	{
		String str;
		String strParams = "";
		int start, end;
		int i = 1;
		int j = 1;
		try {
			BufferedReader in = new BufferedReader(new FileReader(f));
			while((str = in.readLine()) != null && i <= MAXLINES) {
				if(str.contains("<firestore:debug")) { //found the debug tag, search for params
					do {
						str = in.readLine();
						if(str.contains("parameters=")) {
							start = str.indexOf("\"");
							start += 1;
							end = str.indexOf("\"", start);
							strParams = str.substring(start, end);
						}
						j++;
					} while(str != null && j <= MAXDEBUGLINES && !str.contains("parameters"));
					break;
				}
				i++;
			}
			in.close();
		} catch (IOException e) {
		}
		strParams.replaceAll(" ", ""); //remove whitespace
		return strParams;
	}

	/**
	* Recursive function which outputs XML representation of the directory tree
	*
	* @param rootFolder - File
	*/
	public void outputDirectoryContents(File rootFolder)
	{
		String[] contentsAll = rootFolder.list();

		String tmp = null;
		String params = null;
		String relativePath = null;
		String[] tmpfoo;
		int level = 0;

		for(int i = 0; i < contentsAll.length; i++) {
			if(!contentsAll[i].contains(".svn")) { //exclude .svn stuff
				File foo = new File(rootFolder+this.pathSeperator+contentsAll[i]);

				tmp = foo.getAbsolutePath();
				tmpfoo = tmp.split(this.pathSeperator);
				level = tmpfoo.length - this.countRootDir;

//				relativePath = tmp.replaceAll(this.rootFolder.getAbsolutePath(), ""); // OLD STUFF FAILED DUE TO "\" in path
				relativePath = tmp.substring(tmp.indexOf(this.rootFolder.getAbsolutePath()) + this.rootFolder.getAbsolutePath().length(), tmp.length());
				relativePath = relativePath.substring(1, relativePath.length());

				System.out.println(this.rootFolder.getAbsolutePath());

				if(foo.isDirectory()) {
					try { pageContext.getOut().write("<folder id=\""+relativePath+"\" name=\""+contentsAll[i]+"\" level=\""+level+"\" >"); } catch(IOException e) {}
					outputDirectoryContents(foo);
					try { pageContext.getOut().write("</folder>"); } catch(IOException e) {}
				} else if(foo.isFile()) {
					//get parameters for this file
					params = getParamNames(foo);
					tmp = foo.getName();
					this.filetype = (tmp.lastIndexOf(".")==-1)?"":tmp.substring(tmp.lastIndexOf(".")+1,tmp.length());
					try { pageContext.getOut().write("<file params=\""+params+"\" id=\""+relativePath+"\" lastModified=\""+foo.lastModified()+"\" type=\""+this.filetype+"\" level=\""+level+"\">"+contentsAll[i]+"</file>"); } catch(IOException e) {}
				}
			}
		}
	}

    /**
	* Start method
	*
	* @return 1
	*/
    public int doStartTag()
        throws JspException
    {
		if(this.rootFolder.canRead()) {
			try { pageContext.getOut().write("<folder>"); } catch(IOException e) {}
			outputDirectoryContents(this.rootFolder);
			try { pageContext.getOut().write("</folder>"); } catch(IOException e) {}
		} else {
			logger.warn("invalid path argument");
		}
		return 1;
    }

	/**
	* End method
	*
	* @return 6
	*/
	public int doEndTag() throws JspException
    {
		return 6;
	}
}