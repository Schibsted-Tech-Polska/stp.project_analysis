<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
  
    <xsl:template  match="e:content[@type='news'] | e:content[@type='normal'] | e:content[@type='review'] | e:content[@type='video'] | e:content[@type='ntb'] | e:content[@type='webCamera'] | e:content[@type='politiFact']" >
        <xsl:variable name="varSourceId"  select="@id" />
        <xsl:variable name="varSectionUniqueName" select="e:section[@homeSection='yes']/@uniquename"/>
        <xsl:variable name="varSectionName" select="e:section[@homeSection='yes']/@name"/>
        <xsl:variable name="varPublishDate" select="@publishdate"/>
        <xsl:variable name="varLastModifiedDate" select="@last-modified"/>
        <xsl:variable name="varCreationDate" select="@creationdate"/>
        <xsl:variable name="varState" select="@state"/>
        <xsl:variable name="varTitle" select="e:field[@name='TITLE']"/>
        <xsl:if test="e:field[@name='FACTDESCRIPTION'] != '' or e:field[@name='FACTLIST'] != ''">
            <xsl:element name="e:content">
                <xsl:attribute name="source"><xsl:text>fact</xsl:text></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
                <xsl:attribute name="type"><xsl:text>factbox</xsl:text></xsl:attribute>
                <xsl:attribute name="state"><xsl:value-of select="$varState"/></xsl:attribute>
                <xsl:attribute name="publishdate"><xsl:value-of select="$varPublishDate"/></xsl:attribute>
                <xsl:attribute name="creationdate"><xsl:value-of select="$varCreationDate"/></xsl:attribute>
                <xsl:element name="e:section">
                    <xsl:attribute name="uniquename"><xsl:value-of select="$varSectionUniqueName"/></xsl:attribute>
                    <xsl:attribute name="name"><xsl:value-of select="$varSectionName"/></xsl:attribute>
                    <xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute>
                </xsl:element>     
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>TITLE</xsl:text></xsl:attribute>
                <xsl:choose>
                    <xsl:when test="not(e:field[@name='FACTTITLE'])"><xsl:text>Fakta</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:value-of select="e:field[@name='FACTTITLE']"/></xsl:otherwise>
                </xsl:choose>
                </xsl:element>
                <xsl:apply-templates select="e:field[@name='FACTDESCRIPTION']"/>
                <xsl:apply-templates select="e:field[@name='FACTLIST']"/>
               </xsl:element>
        </xsl:if>
        <xsl:for-each select="e:field[@name='BODYTEXT']//e:span[@class='preform']">
            <xsl:element name="e:content">
                <xsl:attribute name="source"><xsl:text>Preform</xsl:text></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="generate-id(node())"/></xsl:attribute>
                <xsl:attribute name="type"><xsl:text>multimedia</xsl:text></xsl:attribute>
                <xsl:attribute name="state"><xsl:value-of select="$varState"/></xsl:attribute>
                <xsl:attribute name="publishdate"><xsl:value-of select="$varPublishDate"/></xsl:attribute>
                <xsl:attribute name="creationdate"><xsl:value-of select="$varCreationDate"/></xsl:attribute>
                <xsl:element name="e:section">
                    <xsl:attribute name="uniquename"><xsl:value-of select="$varSectionUniqueName"/></xsl:attribute>
                    <xsl:attribute name="name"><xsl:value-of select="$varSectionName"/></xsl:attribute>
                    <xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute>
                </xsl:element>
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>TITLE</xsl:text></xsl:attribute>
                    <xsl:text>Media: </xsl:text><xsl:value-of select="$varTitle"/>
                </xsl:element>
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>VIEW</xsl:text></xsl:attribute>
                    <xsl:element name="e:value"><xsl:text>html</xsl:text></xsl:element>
                </xsl:element> 
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>HTML</xsl:text></xsl:attribute>
                    <xsl:apply-templates select="node()"/>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="e:field[@name='LEADTEXT']//e:span[@class='preform']">
            <xsl:element name="e:content">
                <xsl:attribute name="source"><xsl:text>PreformTop</xsl:text></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                <xsl:attribute name="type"><xsl:text>multimedia</xsl:text></xsl:attribute>
                <xsl:attribute name="state"><xsl:value-of select="$varState"/></xsl:attribute>
                <xsl:attribute name="publishdate"><xsl:value-of select="$varPublishDate"/></xsl:attribute>
                <xsl:attribute name="creationdate"><xsl:value-of select="$varCreationDate"/></xsl:attribute>
                <xsl:element name="e:section">
                    <xsl:attribute name="uniquename"><xsl:value-of select="$varSectionUniqueName"/></xsl:attribute>
                    <xsl:attribute name="name"><xsl:value-of select="$varSectionName"/></xsl:attribute>
                    <xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute>
                 </xsl:element>
                 <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>TITLE</xsl:text></xsl:attribute>
                    <xsl:text>Media: </xsl:text><xsl:value-of select="$varTitle"/>
                </xsl:element>
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>VIEW</xsl:text></xsl:attribute>
                    <xsl:element name="e:value"><xsl:text>html</xsl:text></xsl:element>
                </xsl:element> 
                <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>HTML</xsl:text></xsl:attribute>
                    <xsl:apply-templates select="node()"/>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
        <xsl:if test="e:field[@name='ALTHTML'] != ''">
            <xsl:choose>
                <xsl:when test="e:field[@name='ALTHTML']//e:div[@id='flashPresentation']"/>
                <xsl:otherwise>
                    <xsl:element name="e:content">
                      <xsl:attribute name="source"><xsl:text>PreformAlt</xsl:text></xsl:attribute>
                      <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                      <xsl:attribute name="type"><xsl:text>multimedia</xsl:text></xsl:attribute>
                      <xsl:attribute name="state"><xsl:value-of select="$varState"/></xsl:attribute>
                      <xsl:attribute name="publishdate"><xsl:value-of select="$varPublishDate"/></xsl:attribute>
                       <xsl:attribute name="creationdate"><xsl:value-of select="$varCreationDate"/></xsl:attribute>
                       <xsl:attribute name="last-modified"><xsl:value-of select="$varLastModifiedDate"/></xsl:attribute>
                      <xsl:element name="e:section">
                          <xsl:attribute name="uniquename"><xsl:value-of select="$varSectionUniqueName"/></xsl:attribute>
                          <xsl:attribute name="name"><xsl:value-of select="$varSectionName"/></xsl:attribute>
                          <xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute>
                      </xsl:element>
                      <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>TITLE</xsl:text></xsl:attribute>
                          <xsl:text>Media: </xsl:text><xsl:value-of select="$varTitle"/>
                      </xsl:element>
                      <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>VIEW</xsl:text></xsl:attribute>
                          <xsl:element name="e:value"><xsl:text>html</xsl:text></xsl:element>
                      </xsl:element> 
                      <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>HTML</xsl:text></xsl:attribute>
                          <xsl:apply-templates select="e:field[@name='ALTHTML']/node()"/>
                      </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>    
        </xsl:if>
        <xsl:copy>
            <xsl:attribute name="keep-last-modified"><xsl:text>true</xsl:text></xsl:attribute> 
            <xsl:copy-of select="@*"/>
            <xsl:if test="e:field[@name='FACTDESCRIPTION'] != '' or e:field[@name='FACTLIST'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>
            <xsl:if test="e:field[@name='LEADTEXT']//e:span[@class='preform'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>PreformTop</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>topmediaRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>
            <xsl:if test="e:field[@name='ALTHTML'] != ''">
                <xsl:choose>
                    <xsl:when test="e:field[@name='ALTHTML']//e:div[@id='flashPresentation']"/>
                    <xsl:otherwise>
                        <xsl:element name="e:relation">
                            <xsl:attribute name="source"><xsl:text>PreformAlt</xsl:text></xsl:attribute>
                            <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                            <xsl:attribute name="type"><xsl:text>topmediaRel</xsl:text></xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/e:escenic/e:content/e:section">
            <xsl:copy>
                <xsl:copy-of select="node()"/>
                <xsl:attribute name="uniquename"><xsl:value-of select="@uniquename"/></xsl:attribute>
                <xsl:attribute name="source"><xsl:value-of select="@source"/></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
                <!--
                <xsl:variable name="uniquenameVar"><xsl:value-of select="@uniquename"/></xsl:variable>
                <xsl:choose>
                    <xsl:when test="$uniquenameVar='ece_frontpage'">
                        <xsl:attribute name="name"><xsl:text>Forsiden</xsl:text></xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$uniquenameVar='ece_incoming'">
                        <xsl:attribute name="name"><xsl:text>New Articles</xsl:text></xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>                    
                    </xsl:otherwise>
                </xsl:choose>
                -->            
                <xsl:if test="@homeSection='yes'"><xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
            </xsl:copy>
    </xsl:template>
    <xsl:template match="/e:escenic/e:content[@type='news']/e:relation | /e:escenic/e:content[@type='blogg']/e:relation | /e:escenic/e:content[@type='multimedia']/e:relation | /e:escenic/e:content[@type='politiFact']/e:relation | /e:escenic/e:content[@type='review']/e:relation | /e:escenic/e:content[@type='ntb']/e:relation | /e:escenic/e:content[@type='video']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="varType" select="@type"/>
            <xsl:variable name="varSource" select="@source"/>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="$varSource='escenic-migration' or $varSource='escenic-v4-link'">
                        <xsl:choose>
                           <xsl:when test="$varType='FRONTPAGETITLE_RELATED' or $varType='FRONTPAGERUNNINGHEAD_RELATED' or $varType='FRONTPAGETITLE' or $varType='FRONTPAGERUNNINGHEAD'"><xsl:text>teaserRel</xsl:text></xsl:when>
                           <xsl:when test="$varType=''"><xsl:text>storyRel</xsl:text></xsl:when>
                           <xsl:when test="$varType='RELATED'"><xsl:text>storyRel</xsl:text></xsl:when>
                           <xsl:when test="$varType='related'"><xsl:text>storyRel</xsl:text></xsl:when>
                           <xsl:otherwise><xsl:text>restRel</xsl:text></xsl:otherwise>
                       </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$varSource='escenic-v4-image' or $varSource='escenic-v4-media'">
                        <xsl:choose>
                            <xsl:when test="$varType='FRONTPAGETITLE_RELATED' or $varType='FRONTPAGERUNNINGHEAD_RELATED' or $varType='FRONTPAGETITLE' or $varType='FRONTPAGERUNNINGHEAD'"><xsl:text>teaserRel</xsl:text></xsl:when>
                            <xsl:when test="$varType='TITLE_RELATED' or $varType='RUNNINGHEAD_RELATED' or $varType='LEADTEXT_RELATED' or $varType='BYLINE_RELATED' or $varType='TITLE' or $varType='RUNNINGHEAD' or $varType='LEADTEXT' or $varType='BYLINE'"><xsl:text>topmediaRel</xsl:text></xsl:when>
                            <xsl:when test="$varType='BODYTEXT_RELATED' or $varType='BODYTEXT'"><xsl:text>pictureRel</xsl:text></xsl:when>
                            <xsl:otherwise><xsl:text>restRel</xsl:text></xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise><xsl:text>restRel</xsl:text></xsl:otherwise>
                 </xsl:choose>
            </xsl:attribute>
            <xsl:if test="$varSource='escenic-v4-image'">
                <xsl:element name="e:field">
                    <xsl:attribute name="name"><xsl:text>useImageVersion</xsl:text></xsl:attribute>
                    <xsl:text>true</xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/e:escenic/e:content[@type='slideshow']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="varType" select="@type"/>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="$varType='BODYTEXT_RELATED'"><xsl:text>pictureRel</xsl:text></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/e:escenic/e:content[@type='facts']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="varSource" select="@source"/>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="varSource='escenic-v4-image' or $varSource='escenic-v4-media'"><xsl:text>imagesRel</xsl:text></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/e:escenic/e:content[@type='factbox']/e:field[@name='FACTLIST']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:element name="ul">
                <xsl:for-each select="e:ecearrayelement">
                    <xsl:element name="li">
                        <xsl:value-of select="string()" /> 
                    </xsl:element>
                </xsl:for-each>
             </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="e:span[@class='bigRel']/e:relation">
        <xsl:copy>
      	     <xsl:copy-of select="@*"/>
	         <xsl:element name="e:field">
	 	         <xsl:attribute name="name"><xsl:text>showRelationArticle</xsl:text></xsl:attribute>
	      	     <xsl:text>true</xsl:text>
	         </xsl:element>
             <xsl:element name="e:field">
	               <xsl:attribute name="name"><xsl:text>frontpageTitle</xsl:text></xsl:attribute>
	               <xsl:value-of select="string()"/>
             </xsl:element>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="e:span[@class='video']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:element name="e:field">
                <xsl:attribute name="name"><xsl:text>showRelationArticle</xsl:text></xsl:attribute>
                <xsl:text>true</xsl:text>
            </xsl:element>
            <xsl:element name="e:field">
                <xsl:attribute name="name"><xsl:text>frontpageTitle</xsl:text></xsl:attribute>
                <xsl:value-of select="string()"/>
            </xsl:element>
        </xsl:copy>
    </xsl:template>      
    <xsl:template match="e:field[@name='BODYTEXT']//e:relation[@source='escenic-migration']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:element name="e:field">
                <xsl:attribute name="name"><xsl:text>frontpageTitle</xsl:text></xsl:attribute>
                <xsl:value-of select="string()"/>
            </xsl:element>
        </xsl:copy>
    </xsl:template>      
    <xsl:template match="e:field[@name='BODYTEXT']//e:relation[@source='escenic-v4-image']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>      
    <xsl:template match="e:field[@name='BODYTEXT']//e:span[@class='preform']">
        <xsl:element name="e:relation">
            <xsl:attribute name="source"><xsl:text>Preform</xsl:text></xsl:attribute>
            <xsl:attribute name="sourceid"><xsl:value-of select="generate-id(node())"/></xsl:attribute>
        </xsl:element>
    </xsl:template>

    <!-- converts sitat  div class="sig" to cite -->
    <xsl:template match="e:field[@name='BODYTEXT']//e:blockquote">
        <xsl:choose>
            <xsl:when test="e:div/@class='sig'">
                <xsl:element name="blockquote">
                    <xsl:variable name="cite"><xsl:value-of select="e:div[@class='sig']"/></xsl:variable>
                    <xsl:variable name="length">l</xsl:variable>
                    <xsl:variable name="totalQuoteString"><xsl:value-of select="translate(.,'”','')"/></xsl:variable>  
                    <xsl:attribute name="class"><xsl:text>quote</xsl:text>
                    </xsl:attribute><xsl:value-of select="substring($totalQuoteString,1,string-length($totalQuoteString) - string-length($cite))"/>
                    <xsl:element name="cite"><xsl:value-of select="$cite"/></xsl:element>
                </xsl:element> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
     
    <xsl:template match="e:field[@name='LEADTEXT']">
        <xsl:element name="e:field">
        	<xsl:attribute name="name"><xsl:text>LEADTEXT</xsl:text></xsl:attribute>
         	<xsl:value-of select="string()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="e:field[@name='FRONTPAGELEADTEXT']">
        <xsl:element name="e:field">
            <xsl:attribute name="name"><xsl:text>FRONTPAGELEADTEXT</xsl:text></xsl:attribute>
            <xsl:value-of select="string()"/>
        </xsl:element>
    </xsl:template>
        
    <xsl:template match="e:span[@class='quote']//e:i">
            <xsl:apply-templates/>	
    </xsl:template>    
     	
    <xsl:template match="e:relation/e:field[@name='alignment']"/>	
    
    <xsl:template match="e:field[@name='BODYTEXT']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="parent::e:content/e:relation[@type='BODYTEXT']">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:apply-templates select="parent::e:content/e:relation[@type='BODYTEXT']/@source"/></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:apply-templates select="parent::e:content/e:relation[@type='BODYTEXT']/@sourceid"/></xsl:attribute>
                </xsl:element>  
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
 </xsl:stylesheet>
