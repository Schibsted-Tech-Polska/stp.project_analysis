<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import"  xmlns:schedule="http://xmlns.escenic.com/2011/schedule">
    
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Setting all links to state published, as default is draft. State was not used for links in Escenic 4.x-->
  <xsl:template match="e:escenic/e:content[@type='link']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="state">
       <xsl:text>published</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <!--TODO: Find out if this is needed for Aftenposten -->
  <xsl:template match="/e:escenic/e:content[@type='normal']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="contains(e:field[@name='BYLINE'],'NTB')">
		      <xsl:element name="e:field">
		        <xsl:attribute name="name">
		          <xsl:text>SOURCE</xsl:text>
				      </xsl:attribute>
				      <xsl:text>NTB</xsl:text>
		      </xsl:element>
		    </xsl:if>
		    <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <!--Adding 'keep-last-modified=true' to not override last-modified date with migration date -->
  <xsl:template match="/e:escenic/e:content[@type='bildeserie'] | /e:escenic/e:content[@type='picture']" >
    <xsl:copy>
      <xsl:attribute name="keep-last-modified"><xsl:text>true</xsl:text></xsl:attribute>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- articletype test is only used as a dummy articletype to get to import the content as a factbox-->
  <xsl:template match="/e:escenic/e:content[@type='test']/e:field[@name='FAKTATEKST']">
     <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:attribute name="name">
          <xsl:text>BRODTEKST</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:copy> 
  </xsl:template>
  
  <!--TODO: Find out if we hace something similar in Aftenposten-->
  <xsl:template match="e:span[@class='bigRel']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="e:field[@name='MU_CONTENT']"/>
  <xsl:template match="e:field[@name='GOLIVETIME']"/>
  
  <xsl:template match="e:field[@name='BRODTEKST']//e:ul">
    <xsl:variable name="varLI" ><xsl:call-template name="stripEmptyLI"/></xsl:variable>
    <xsl:if test="$varLI!=''">
      <xsl:element name="e:ul">
        <xsl:copy-of select="$varLI" />
       </xsl:element>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="stripEmptyLI">
   <xsl:for-each select="e:li">
     <xsl:choose>
       <!-- <xsl:when test="normalize-space(text())=''"/> -->
       <xsl:when test="normalize-space(.)=''"/>
       <xsl:otherwise>
         <xsl:copy-of select="." />
       </xsl:otherwise>
     </xsl:choose> 
   </xsl:for-each>
  </xsl:template>
  
  <!-- Rmoving relations to itself -->
  <xsl:template match="e:relation">
    <xsl:choose>
      <xsl:when test="@source='escenic-migration'">
        <xsl:variable name="selfID"><xsl:value-of select="parent::e:content/@sourceid"/></xsl:variable>
        <xsl:choose>
          <xsl:when test="$selfID=@sourceid"/>
          <xsl:otherwise>
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <xsl:apply-templates/>
            </xsl:copy>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 </xsl:stylesheet>          



