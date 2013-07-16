<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import"  xmlns:schedule="http://xmlns.escenic.com/2011/schedule">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="article">
        <!-- only migrating article and content types with state="published" until we start livemigration-->
        <xsl:if test="@state='published'"><!-- Todo: remove this test when livemigration has started -->
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="multimediaGroup">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:choose>
                <xsl:when test="starts-with(@name,'/')">
                    <xsl:attribute name="name"><xsl:value-of select="substring-after(@name,'/')"/></xsl:attribute>
                </xsl:when>
              <xsl:otherwise>
                  <xsl:attribute name="name"><xsl:value-of select="translate(@name,'/','-')"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="field[@name='INGRESS']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>        
    </xsl:template>

    <xsl:template match="field[@name='FORSIDEINGRESS']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>        
    </xsl:template>
    
    <!-- <xsl:template match="field[@name='STEP1TEXT']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>        
    </xsl:template> -->
    
    <!-- if we need to manually skip articletypes -->
    <!--<xsl:template match="article[@type='forum']"/>-->
    
    <!-- if we need to manually edit fields with "ARV" -->
    <!--<xsl:template match="field[@name='CENTRALBODYTEXT']">
        <xsl:if test="not(parent::article/field[@name='BODYTEXT'])">
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
    <xsl:template match="field[@name='CENTRALTITLE']">
        <xsl:if test="not(parent::article/field[@name='TITLE'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>TITLE</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>-->
    
    <!-- if we need to manually skip fields -->
    <!--<xsl:template match="field[@name='BYSPILL']"/>-->
 </xsl:stylesheet>
