<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import"  xmlns:schedule="http://xmlns.escenic.com/2011/schedule">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    
    <xsl:template name="templateFactbox">
        <xsl:param name="varFactNumber"/>
        <xsl:element name="e:content">
            <xsl:variable name="varFactSource">fact<xsl:value-of select="$varFactNumber"/></xsl:variable>
            <xsl:attribute name="source"><xsl:value-of select="$varFactSource"/></xsl:attribute>
            <xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
            <!-- setting articletype to test, as the migrator plugin only picks up articletypes
                 that are mapped in "Existing mappings".
                 Since there are no articletype in 4.1 for "factbox",
                 I needed a dummy articletype, articletype test had no articles -->
            <xsl:attribute name="type"><xsl:text>test</xsl:text></xsl:attribute>
            <xsl:attribute name="state"><xsl:value-of select="@state"/></xsl:attribute>
            <xsl:attribute name="publishdate"><xsl:value-of select="@publishdate"/></xsl:attribute>
            <xsl:attribute name="creationdate"><xsl:value-of select="@creationdate"/></xsl:attribute>
            <xsl:element name="e:section">
                <xsl:attribute name="uniquename"><xsl:value-of select="e:section[@homeSection='yes']/@uniquename"/></xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="e:section[@homeSection='yes']/@name"/></xsl:attribute>
                <xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute>
            </xsl:element>     
            <xsl:variable name="varFactTitleName">
                <xsl:choose>
                    <xsl:when test="$varFactNumber = '1'">FAKTATITTEL</xsl:when>
                    <xsl:otherwise>FAKTATITTEL<xsl:value-of select="$varFactNumber"/></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>TITLE</xsl:text></xsl:attribute>
            <xsl:choose>
                    <xsl:when test="not(e:field[@name=$varFactTitleName])"><xsl:text>Fakta</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:value-of select="e:field[@name=$varFactTitleName]"/></xsl:otherwise>
                </xsl:choose>
            </xsl:element>
            <xsl:variable name="varFactTextName">
                <xsl:choose>
                    <xsl:when test="$varFactNumber = '1'">FAKTATEKST</xsl:when>
                    <xsl:otherwise>FAKTATEKST<xsl:value-of select="$varFactNumber"/></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:element name="e:field"><xsl:attribute name="name"><xsl:text>BRODTEKST</xsl:text></xsl:attribute>
            <xsl:choose>
                <xsl:when test="not(e:field[@name=$varFactTextName])"><xsl:text>Fakta</xsl:text></xsl:when>
                <xsl:otherwise><xsl:value-of select="e:field[@name=$varFactTextName]"/></xsl:otherwise>
            </xsl:choose>
            </xsl:element>
            
        </xsl:element>
    </xsl:template>


    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!--TODO: Add articletypes to be included here -->
    <xsl:template match="e:content[@type='normal'] | e:content[@type='guide'] | e:content[@type='nettprat'] | e:content[@type='FraAtekst'] | e:content[@type='video'] | e:content[@type='Notis'] | e:content[@type='politikk'] | e:content[@type='Oslopuls-artikkel']" >
        <xsl:variable name="varSourceId"  select="@id" />
        <xsl:variable name="varSectionUniqueName" select="e:section[@homeSection='yes']/@uniquename"/>
        <xsl:variable name="varSectionName" select="e:section[@homeSection='yes']/@name"/>
        <xsl:variable name="varPublishDate" select="@publishdate"/>
        <xsl:variable name="varLastModifiedDate" select="@last-modified"/>
        <xsl:variable name="varCreationDate" select="@creationdate"/>
        <xsl:variable name="varState" select="@state"/>
        <xsl:variable name="varTitle" select="e:field[@name='TITLE']"/>

        <!--Moving the content of the field FAKTATITTEL and FAKTATEKST to a new article of type FACTS-->
        <xsl:if test="e:field[@name='FAKTATEKST'] != ''">
            <xsl:call-template name="templateFactbox">
                <xsl:with-param name="varFactNumber">1</xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="e:field[@name='FAKTATEKST2'] != ''">
            <xsl:call-template name="templateFactbox">
                <xsl:with-param name="varFactNumber">2</xsl:with-param>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="e:field[@name='FAKTATEKST3'] != ''">
            <xsl:call-template name="templateFactbox">
                <xsl:with-param name="varFactNumber">3</xsl:with-param>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="e:field[@name='FAKTATEKST3'] != ''">
            <xsl:call-template name="templateFactbox">
                <xsl:with-param name="varFactNumber">4</xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="e:field[@name='FAKTATEKST5'] != ''">
            <xsl:call-template name="templateFactbox">
                <xsl:with-param name="varFactNumber">5</xsl:with-param>
            </xsl:call-template>
        </xsl:if>
   
        <!--Moving the content of a preform tag in the field BRODTEKST to a new article of type MULTIMEDIA-->
        <xsl:for-each select="e:field[@name='BRODTEKST']//e:span[@class='preform']">
            <xsl:element name="e:content">
                <xsl:attribute name="source"><xsl:text>Preform</xsl:text></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="generate-id(node())"/></xsl:attribute><!--used to recognize relation further down-->
                <!--setting articletype to elementWrap, as the migrator plugin only picks up articletypes that are mapped in "Existing mappings". Since we don´ want to include the articles from 4.1 of type "multimedia", I needed a dummy articletype, articletype elementWrap had no articles-->
                <xsl:attribute name="type"><xsl:text>Multimedia</xsl:text></xsl:attribute>
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
        
        <!--Moving the content of a preform tag in the field INGRESS to a new article of type MULTIMEDIA-->
        <xsl:for-each select="e:field[@name='INGRESS']//e:span[@class='preform'] | e:field[@name='INGRESS']//e:preform">
            <xsl:element name="e:content">
                <xsl:attribute name="source"><xsl:text>PreformTop</xsl:text></xsl:attribute>
                <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                <!--setting articletype to elementWrap, as the migrator plugin only picks up articletypes that are mapped in "Existing mappings". Since we don´ want to include the articles from 4.1 of type "multimedia", I needed a dummy articletype, articletype elementWrap had no articles-->
                <xsl:attribute name="type"><xsl:text>Multimedia</xsl:text></xsl:attribute>
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
        
        <!--Moving the content of the field MU_CONNTENT to a new article of type MULTIMEDIA-->
        <xsl:if test="e:field[@name='MU_CONTENT'] != ''">
            <xsl:choose>
                <xsl:when test="e:field[@name='MU_CONTENT']//e:div[@id='flashPresentation']"/><!-- This was used to skip all old flash for aftenbladet, anything we need to for Aftenposten? -->
                <xsl:otherwise>
                    <xsl:element name="e:content">
                      <xsl:attribute name="source"><xsl:text>PreformAlt</xsl:text></xsl:attribute>
                      <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                      <!--setting articletype to elementWrap, as the migrator plugin only picks up articletypes that are mapped in "Existing mappings". Since we don´ want to include the articles from 4.1 of type "multimedia", I needed a dummy articletype, articletype elementWrap had no articles-->
                      <xsl:attribute name="type"><xsl:text>Multimedia</xsl:text></xsl:attribute>
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
                          <xsl:apply-templates select="e:field[@name='ALTHTML']/node()"/>
                      </xsl:element>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>    
        </xsl:if>
        <xsl:copy>
            <!--Adding 'keep-last-modified=true' to not override last-modified date with migration date -->
            <xsl:attribute name="keep-last-modified"><xsl:text>true</xsl:text></xsl:attribute>
            <xsl:attribute name="delete-relations"><xsl:text>true</xsl:text></xsl:attribute>
            <xsl:copy-of select="@*"/>
            <!--Creating the relation to the new FACTS article-->
            <xsl:if test="e:field[@name='FAKTATEKST'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact1</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>
            <xsl:if test="e:field[@name='FAKTATEKST2'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact2</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>  
            <xsl:if test="e:field[@name='FAKTATEKST3'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact3</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>  
            <xsl:if test="e:field[@name='FAKTATEKST4'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact4</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>  
            <xsl:if test="e:field[@name='FAKTATEKST5'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>fact5</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>factboxRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>     
            
            <!--Creating the relation to the new MULTIMEDIA article from INGRESS-->
            <!-- TODO: Disse to skulle vel vært i samme test, men jeg fikk det ikke til -->
            <xsl:if test="e:field[@name='INGRESS']//e:span[@class='preform'] != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>PreformTop</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>topmediaRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>
            <xsl:if test="e:field[@name='INGRESS']//e:preform != ''">
                <xsl:element name="e:relation">
                    <xsl:attribute name="source"><xsl:text>PreformTop</xsl:text></xsl:attribute>
                    <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:text>topmediaRel</xsl:text></xsl:attribute>
                </xsl:element>
            </xsl:if>
            
            <!--Creating the relation to the new MULTIMEDIA article-->
            <xsl:if test="e:field[@name='MU_CONTENT'] != ''">
                <xsl:choose>
                    <xsl:when test="e:field[@name='MU_CONTENT']//e:div[@id='flashPresentation']"/>
                    <xsl:otherwise>
                        <xsl:element name="e:relation">
                            <xsl:attribute name="source"><xsl:text>PreformAlt</xsl:text></xsl:attribute>
                            <xsl:attribute name="sourceid"><xsl:value-of select="$varSourceId"/></xsl:attribute>
                            <xsl:attribute name="type"><xsl:text>topmediaRel</xsl:text></xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:for-each select="e:field[@name='BRODTEKST']//e:relation[@source='escenic-migration']">
                <xsl:choose>
                    <xsl:when test="parent::e:li/parent::e:ul">
                        <xsl:element name="e:relation">
                            <xsl:attribute name="source"><xsl:value-of select="@source"/></xsl:attribute>
                            <xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
                            <xsl:attribute name="type"><xsl:text>storyRel</xsl:text></xsl:attribute>
                            <xsl:element name="e:field">
                                <xsl:attribute name="name"><xsl:text>frontpageTitle</xsl:text></xsl:attribute>
                                <xsl:value-of select="string()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!--TODO:Removed this, since we want to use source and sourceID, have to test what is happening with ece_frontpage and ece_incoming-->
    <!--<xsl:template match="/e:escenic/e:content/e:section">
        <xsl:copy>
            <xsl:copy-of select="node()"/>
            <xsl:attribute name="uniquename"><xsl:value-of select="@uniquename"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
            <xsl:if test="@homeSection='yes'"><xsl:attribute name="homeSection"><xsl:text>yes</xsl:text></xsl:attribute></xsl:if>
        </xsl:copy>
        </xsl:template>-->
    
    <!--Mapping relations to new relation type-->
    <!--TODO: list articletypes to be included in this relation mapping -->
   
    <xsl:template match="/e:escenic/e:content[@type='normal']/e:relation | /e:escenic/e:content[@type='guide']/e:relation | /e:escenic/e:content[@type='nettprat']/e:relation | /e:escenic/e:content[@type='FraAtekst']/e:relation | /e:escenic/e:content[@type='video']/e:relation | /e:escenic/e:content[@type='Notis']/e:relation | /e:escenic/e:content[@type='politikk']/e:relation | /e:escenic/e:content[@type='Oslopuls-artikkel']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="varType" select="@type"/>
            <xsl:variable name="varSource" select="@source"/>
            <xsl:attribute name="type">
                <xsl:choose>
                    <xsl:when test="$varSource='escenic-migration' or $varSource='escenic-v4-link'">
                        <xsl:text>storyRel</xsl:text>
                    </xsl:when>
                    <xsl:when test="$varSource='escenic-v4-image' or $varSource='escenic-v4-media'">
                        <xsl:choose>
                            <xsl:when test="$varType='FORSIDETITTEL_RELATED' or $varType='SEKSJONSTITTEL_RELATED'"><xsl:text>teaserRel</xsl:text></xsl:when><!--Not sure about SEKSJONSTITTEL_RELATED-->
                            <xsl:when test="$varType='TITLE_RELATED'"><xsl:text>topmediaRel</xsl:text></xsl:when>
                            <xsl:when test="$varType='BRODTEKST_RELATED'"><xsl:text>pictureRel</xsl:text></xsl:when>
                            <xsl:when test="$varType='INGRESS_RELATED'"><xsl:text>restRel</xsl:text></xsl:when><!--not displayed in Aftenposten today-->
                            <xsl:when test="$varType='LISTEINGRESS_RELATED'"><xsl:text>restRel</xsl:text></xsl:when><!--not displayed in Aftenposten today-->
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
    <xsl:template match="/e:escenic/e:content[@type='bildeserie']/e:relation">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:variable name="varType" select="@type"/>
            <xsl:attribute name="type">
                <xsl:choose>
                    <!--TODO: test to see if several relationTypes are displayed in the picture series-->
                    <xsl:when test="$varType='INGRESS_RELATED'"><xsl:text>pictureRel</xsl:text></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>
    
    <!--TODO: Find out if we have something similar to bigRel in Aftenposten? -->
    <!--<xsl:template match="e:span[@class='bigRel']/e:relation">
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
    -->
    <!-- TODO: Find out what to do with this inline parameters that creates a link to "Aftenposten Arkivet"-->
    <xsl:template match="e:span[@class='arkiv']/e:relation">
    </xsl:template>     
    <xsl:template match="e:span[@class='arkiv2s']/e:relation">
    </xsl:template>     
    
    <!--Moving the linktext to the field frontpageTitle in the relation, to avoid an empty linktext-->
    <xsl:template match="e:field[@name='BRODTEKST']//e:relation[@source='escenic-migration']">
        <xsl:choose>
            <xsl:when test="parent::e:li/parent::e:ul">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:element name="e:field">
                        <xsl:attribute name="name"><xsl:text>frontpageTitle</xsl:text></xsl:attribute>
                        <xsl:value-of select="string()"/>
                    </xsl:element>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
        
       
    </xsl:template>      
    
    <!--TODO: What the ... am I doing here? -->
    <xsl:template match="e:field[@name='BRODTEKST']//e:relation[@source='escenic-v4-image']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:if test="e:field[@name='alttext']">
                <xsl:element name="e:field">
                    <xsl:attribute name="name"><xsl:text>caption</xsl:text></xsl:attribute>
                    <xsl:value-of select="e:field[@name='alttext']"/>
                </xsl:element> 
            </xsl:if>
            
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>      
    
    <!--Creating the relation to the new MULTIMEDIA article that was moved from the field BRODTEKST-->
    <xsl:template match="e:field[@name='BRODTEKST']//e:span[@class='preform']">
        <xsl:element name="e:relation">
            <xsl:attribute name="source"><xsl:text>Preform</xsl:text></xsl:attribute>
            <xsl:attribute name="sourceid"><xsl:value-of select="generate-id(node())"/></xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    
    
    <!--<xsl:template match="e:content[@type='guide']/e:field[@name='BRODTEKST']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
            <xsl:if test="parent::e:content/e:field[@name='STEP1TITLE']">
                <xsl:element name="e:h2"><xsl:value-of select="parent::e:content/e:field[@name='STEP1TITLE']"/></xsl:element>
                <xsl:if test="parent::e:content/e:field[@name='STEP1TEASER']">
                <xsl:element name="e:h3"><xsl:value-of select="parent::e:content/e:field[@name='STEP1TEASER']"/></xsl:element>
                </xsl:if>
                <xsl:element name="e:span">
                    <xsl:attribute name="class"><xsl:text>link-collapsed</xsl:text></xsl:attribute>
                    
                    <xsl:value-of select="parent::e:content/e:field[@name='STEP1TEXT']"/>
                </xsl:element>                    
            </xsl:if>
        </xsl:copy>        
    </xsl:template>-->
    
    
    <!-- Strip preform from INGRESS (moved to MULTIMEDIA article) -->
    <xsl:template match="e:field[@name='INGRESS']//e:span[@class='preform'] | e:field[@name='INGRESS']//e:preform"/>
    
    <!--Stripping html-->
    <!--TODO: Agree on what to do for Aftenposten -->
    <xsl:template match="e:field[@name='FORSIDEINGRESS']">
        <xsl:element name="e:field">
            <xsl:attribute name="name"><xsl:text>FORSIDEINGRESS</xsl:text></xsl:attribute>
            <xsl:value-of select="string()"/>
        </xsl:element>
    </xsl:template>
    
    <!--TODO: Hva gjør vi med signaturen her? -->
    <!--xsl:template match="e:span[@class='quote']//e:span[@class='ssig']">
        <xsl:element name="em">
             <xsl:apply-templates/>	
        </xsl:element>
    </xsl:template-->    
    
    <xsl:template match="e:relation/e:field[@name='alignment']"/><!-- To avoid a very popular warning-->	
    
    <!--Transforming the values in the selection from 0,1,2,3 to values available in the new selection-->
    <xsl:template match="e:field[@name='KOMMENTAR']/e:ecs_selection">
        <xsl:element name="e:ecs_selection">
            <xsl:choose>
                <xsl:when test="string()='0'">false</xsl:when>
                <xsl:when test="string()='1'">true</xsl:when>
                <xsl:when test="string()='3'">true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        
    </xsl:template>
    
    <!-- Transforiming the values of GOLIVEDATE and GOLIVETIME to the format available in he new escenic-->
    <xsl:template match="e:field[@name='GOLIVEDATE']">
        <xsl:variable name="date"><xsl:value-of select="substring(string(), 1,10)"/></xsl:variable>
        <xsl:variable name="time">
            <xsl:choose>
            <xsl:when test="parent::e:content/e:field[@name='GOLIVETIME']">
                <xsl:value-of select="substring(parent::e:content/e:field[@name='GOLIVETIME'],12,8)"/>
            </xsl:when>
            <xsl:otherwise><xsl:text>00:00:00</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>     
        <xsl:element name="e:field">
            <xsl:attribute name="name"><xsl:text>GOLIVEDATE</xsl:text></xsl:attribute>
            <xsl:element name="schedule:schedule">
                <xsl:attribute name="time-zone"><xsl:text>Europe/Oslo</xsl:text></xsl:attribute>
                <xsl:element name="schedule:occurrence">
                    <xsl:attribute name="date"><xsl:value-of select="$date"/></xsl:attribute> 
                    <xsl:attribute name="start-time"><xsl:value-of select="$time"/></xsl:attribute>
                    <xsl:attribute name="end-time">23:59:59</xsl:attribute>
                </xsl:element>  
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- Skipping the attribute allowtransparency in the element iframe, as this stops the article to be imported, also removing px from height and width, as these values give warnings-->
    <xsl:template match="e:iframe[@allowtransparency='true']">
        <xsl:copy>
            <xsl:if test="@src"><xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute></xsl:if>
            <xsl:if test="@scrolling"><xsl:attribute name="scrolling"><xsl:value-of select="@scrolling"/></xsl:attribute></xsl:if>
            <xsl:if test="@height"><xsl:attribute name="height"><xsl:value-of select="translate(@height,'px','')"/></xsl:attribute></xsl:if>
            <xsl:if test="@width"><xsl:attribute name="width"><xsl:value-of select="translate(@width,'px','')"/></xsl:attribute></xsl:if>
            <xsl:if test="@frameborder"><xsl:attribute name="frameborder"><xsl:value-of select="@frameborder"/></xsl:attribute></xsl:if>
            <xsl:copy-of select="*"/>
        </xsl:copy>  
    </xsl:template>

    <!-- Skipping publication-name in author and creator to prevent warnings when E24 reporters are refered to-->
    <xsl:template match="e:author|e:creator">
        <xsl:copy>
            <xsl:if test="@surname"><xsl:attribute name="surname"><xsl:value-of select="@surname"/></xsl:attribute></xsl:if>
            <xsl:if test="@firstname"><xsl:attribute name="firstname"><xsl:value-of select="@firstname"/></xsl:attribute></xsl:if>
            <xsl:if test="@username"><xsl:attribute name="username"><xsl:value-of select="@username"/></xsl:attribute></xsl:if>
            <xsl:if test="@email"><xsl:attribute name="email"><xsl:value-of select="@email"/></xsl:attribute></xsl:if>
            <xsl:copy-of select="*"/>
        </xsl:copy>  
    </xsl:template>
    
<!--    
    <xsl:template match="e:iframe"> 
        <xsl:copy> 
            <xsl:apply-templates select="@*"/> 
            <xsl:apply-templates/>
        </xsl:copy> 
    </xsl:template> 
    <xsl:template match="e:iframe/@*"> 
        <xsl:copy-of select="."/> 
    </xsl:template> 
    <xsl:template match="e:iframe/@allowtransparency"/>
    -->

    <!-- Replacing the value for attribute align from 'center' to 'middle', as the value 'center' stops the article to be imported -->

    <xsl:template match="e:img"> 
        <xsl:copy> 
            <xsl:copy-of select="@*"/> 
            <xsl:if test="@align='center'"><xsl:attribute name="align"><xsl:text>middle</xsl:text></xsl:attribute></xsl:if>
            <xsl:apply-templates/>
        </xsl:copy> 
    </xsl:template> 
    <xsl:template match="e:a"> 
        <xsl:copy> 
            <xsl:copy-of select="@*"/> 
            <xsl:if test="@target='_new'"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>
            <xsl:if test="@target='_'"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>
            <xsl:if test="@target='blank'"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>
            <xsl:if test="@target='-blank'"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>
            <xsl:if test="@target=':_blank'"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>
            <xsl:if test="@target=''"><xsl:attribute name="target"><xsl:text>_blank</xsl:text></xsl:attribute></xsl:if>            
            <xsl:apply-templates/>
        </xsl:copy> 
    </xsl:template> 

</xsl:stylesheet>
