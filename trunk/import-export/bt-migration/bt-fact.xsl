<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:e="http://xmlns.escenic.com/2009/import">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
 <xsl:template match="e:escenic/e:content[@type='link']">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:attribute name="state">
    <xsl:text>published</xsl:text>
   </xsl:attribute>
   <xsl:apply-templates/>
  </xsl:copy>
 </xsl:template>
  
  <xsl:template match="/e:escenic/e:content[@type='ntb']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:element name="e:field">
        <xsl:attribute name="name">
       	  <xsl:text>SOURCE</xsl:text>
		      </xsl:attribute>
		      <xsl:text>NTB</xsl:text>
    	 </xsl:element>
    	 <xsl:element name="e:field">
        <xsl:attribute name="name">
       	  <xsl:text>BYLINE</xsl:text>
		      </xsl:attribute>
		      <xsl:text>NTB</xsl:text>
    	 </xsl:element>
    	 <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/e:escenic/e:content[@type='news']">
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
   
  <xsl:template match="e:field[@name='REVIEWTYPE']/e:ecs_selection">
    <xsl:if test="contains(string(),Movie)"><e:value>movie</e:value></xsl:if>    
  </xsl:template>
  <xsl:template match="e:field[@name='GRADE']">
    <xsl:if test="not(contains(e:ecs_selection,'none'))">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template match="/e:escenic/e:content[@type='slideshow'] | /e:escenic/e:content[@type='multimedia'] | /e:escenic/e:content[@type='picture']" >
    <xsl:copy>
      <xsl:attribute name="keep-last-modified"><xsl:text>true</xsl:text></xsl:attribute>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="/e:escenic/e:content[@type='factbox']/e:field[@name='FACTTITLE']"/>
  <xsl:template match="/e:escenic/e:content[@type='factbox']/e:field[@name='FACTDESCRIPTION']">
     <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:attribute name="name">
          <xsl:text>BODYTEXT</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
        <xsl:apply-templates/>
      </xsl:copy>
  </xsl:template>
  <xsl:template match="/e:escenic/e:content/e:field[@name='FACTLIST']"> 
    <xsl:if test="not(parent::article/field[@name='FACTDESCRIPTION'])">
    <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:attribute name="name">
      <xsl:text>BODYTEXT</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
    <xsl:apply-templates/>
    </xsl:copy>
    </xsl:if> 
  </xsl:template>
  
  <xsl:template match="e:span[@class='bigRel']">
    <xsl:apply-templates/>
  </xsl:template>
 
</xsl:stylesheet>          



