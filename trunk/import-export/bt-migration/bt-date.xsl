<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="e:content[@lastmodified!='']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:element name="e:field">
                <xsl:attribute name="name"><xsl:text>lastModifiedDateField</xsl:text></xsl:attribute>
                <xsl:value-of select="@lastmodified"/>
            </xsl:element> 
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
