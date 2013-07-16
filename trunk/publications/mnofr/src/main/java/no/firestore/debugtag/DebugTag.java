
package no.firestore.debugtag;

// (c) 2008 Fire Store
// Written by Frode Fjermestad and Morten Salthe
// 19 may 2008: Rollback to revision 291, buggy param should not be set globally anymore

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.http.HttpServletRequest;
import java.net.URL;

public class DebugTag extends BodyTagSupport
{

    //Constructor
    public DebugTag()
    {
        id = "DEBUG";
        jsId = "";
    }

	private String getFileName(String path){

		String fileName = null;
		String separator = "/";

		int pos = path.lastIndexOf(separator);
		int pos2 = path.length();

		if(pos2>-1)
			fileName =path.substring(pos+1, pos2);
		else
			fileName =path.substring(pos+1);

		return fileName;
	}

	private String getFolder(String path){

		String filePath = null;
		String separator = "/";

		int pos = path.lastIndexOf(separator);

		filePath =path.substring(0, pos);

		return filePath;
	}



    //set methods
    public void setId(String id)
    {
        this.id = id;
    }

    public void setDocumentationUrl(String documentationUrl)
    {
        documentationUrl= documentationUrl;
    }

    public void setShortDescription(String shortDescription)
    {
        this.shortDescription = shortDescription;
    }
    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }
    public void setParameters(String parameters)
    {
        this.parameters = parameters;
    }




    //Method for creating the start of the enclosing debug tag
    public int doStartTag()
        throws JspException
    {
		int returncode=1;
        //checking if buggy=true in the browser adressfield
        if("true".equals(pageContext.getRequest().getParameter("buggy")))
        {
            HttpServletRequest req=(HttpServletRequest) pageContext.getRequest();
            String url=req.getRequestURL().toString();
            if(url.contains(":8080") || url.contains("localhost")|| url.contains("www-"))
            {
            try
            {
				visible = ("false".equals(pageContext.getRequest().getParameter("output")));

                timerNumber = (Integer)pageContext.getRequest().getAttribute("timerNumber");

                if(timerNumber == null)
                    timerNumber = new Integer(0);
                else
                    timerNumber = new Integer(timerNumber.intValue() + 1);

                pageContext.getRequest().setAttribute("timerNumber", timerNumber);
                jsId = "timer" + timerNumber + "ms";


                //Gets the filename in system format
                fileName = pageContext.getPage().getClass().getName();
               //Cleans the system filename into a more readable name by removing some unnecessary characters
                fileName = fileName.replace("_22d","-");
                fileName = fileName.replace("._","/");
				fileName = fileName.replace("_0","_");
				fileName = fileName.replace("__",".");
				fileName = fileName.replace("_jsp/","/");



				String fisheyeUrl = "https://bugs.bt.no/fisheye/browse/rammeverk20/webapps/rammeverk"+fileName+"?r=root:";

				if (timerNumber == 0) {
					String javascriptUrl = (String) pageContext.findAttribute("javascriptUrl");
					String stylesheetUrl = (String) pageContext.findAttribute("stylesheetUrl");
					pageContext.getOut().write("<script src=\""+javascriptUrl+"lib/prototype-1.6.0.2.js\" type=\"text/javascript\"></script>");
					pageContext.getOut().write("<script src=\""+javascriptUrl+"lib/debugtag.js\" type=\"text/javascript\"></script>");
					pageContext.getOut().write("<link type=\"text/css\" rel=\"StyleSheet\" media=\"screen\" href=\""+stylesheetUrl+"debug.css\"/>");

				}
		        //Inline css styling for the presentation of the debug
                pageContext.getOut().write("<div id=\"listener"+jsId+"\" style=\"font-variant:normal;background-color:brown;color:white; height:14px; border-left:solid 1px white; border-top:solid 1px white;font-family:Tahoma;font-size:10px;font-weight:normal; width:auto;z-index:10;position:absolute;padding-left:5px;padding-right:5px;\" ");
				pageContext.getOut().write(" >");



                //Link to documentation
                pageContext.getOut().write("<a title='"+shortDescription+"' id='a"+jsId+"' href='"+ fisheyeUrl +"' style='color:white;text-decoration:none;' ");
				pageContext.getOut().write("onClick=\"\" >"+fileName+"</a>");
				pageContext.getOut().write("</div>");
                pageContext.getOut().write("<div style=\"display:block;z-index:1000;border-left:solid 1px brown;width:auto;margin-left:1px;padding-left:1px;padding-bottom:1px;\" ");
				pageContext.getOut().write("<div style=\"position:relative;height:16px;display:block;\"></div>");
				pageContext.getOut().write("<div id=\""+jsId+"\" style=\"border:solid 3px white;display:block;padding:2px;width:auto;\"> ");
				pageContext.getOut().write("<script language='javascript'> d = new Date(); " + jsId + " = d.getTime();  </script>");

			timestamp = System.currentTimeMillis();
            }
            catch(Exception e)
            {
                throw new JspTagException("TimerTag: " + e.getMessage());
            }


            }
            return 1;
        } else
        {
            return 1;
        }
    }


    //Method for writing the last half of the enclosing tag
    public int doEndTag()
        throws JspException
    {
        if("true".equals(pageContext.getRequest().getParameter("buggy")))
        {
            HttpServletRequest req=(HttpServletRequest) pageContext.getRequest();
            String url=req.getRequestURL().toString();
            if(url.contains(":8080") || url.contains("localhost")|| url.contains("www-"))
            {
            try
            {
                long timeBetween = System.currentTimeMillis() - timestamp;

				//The output to the debug tag
				pageContext.getOut().write("</div></div><div style=\"background-color:brown;margin-left:1px;color:white;width:10px;height:3px;z-index:10;position:absolute;\">");
				pageContext.getOut().write("</div>");
				pageContext.getOut().write("<div style=\"position:relative;height:5px;display:block;\"></div>");
				pageContext.getOut().write("<script language='javascript'>\n");
				pageContext.getOut().write("browserTime = new Date().getTime() -" + jsId + ";");

				String allParameters = "</p><h1>Parameters</h1><table>" ;
			    String patternStr = ",";
			    String[] fields = parameters.split(patternStr, -1);
				for (int i=0;i<fields.length;i++) {
					String myParam = fields[i].trim();
					allParameters = allParameters + "<tr><td>"+ myParam + "</td><td>" + pageContext.findAttribute(myParam) + "</td></tr>";
				}
				allParameters = allParameters+"</table>";
				if (parameters.trim().equals("")) allParameters = "";


				pageContext.getOut().write(" \n"
					+"node = $('a"+jsId+"'); \n"
					+"new Tooltip(node, \"<h1>"+getFileName(fileName)+"</h1><p>"
							+ shortDescription + "<br/>"
							+ "Folder: "+getFolder(fileName)+"<br/>"
							+ allParameters
							+ "</p><h1>Timer</h1><p>"
							+ "Server time to generate: " + timeBetween + " ms " + "<br/>"
                            + "Browser time to render: \"+browserTime+\" ms" + "<br/>"

					+"</p>\",'"+jsId+"');\n"
					+"");
				pageContext.getOut().write("</script>\n");


            }
            catch(Exception e)
            {
                throw new JspTagException("TimerTag: " + e.getMessage());
            }
            }
            return 6;
        } else
        {
            return 6;
        }
    }

    private long timestamp;
    private String id;
    private String jsId;
    private Integer timerNumber;
    private String documentationUrl;
    private String shortDescription;
    private String fileName;
	private String parameters;
	private boolean visible;
}