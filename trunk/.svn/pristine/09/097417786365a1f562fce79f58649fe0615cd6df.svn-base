<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:include href="Seksjoner_alle_Escenic.xsl"/>
    <!-- Variable sectionMap is defined in the included xsl: "Seksjoner_alle_Escenic.xsl", and includes the sectionMapping for all sections-->
    <xsl:variable name="sectionMap-ns" select="exsl:node-set($sectionMap)" xmlns:exsl="http://exslt.org/common"/>
    <xsl:template match="*">
           <xsl:copy>
               <xsl:copy-of select="@*"/>
               <xsl:apply-templates/>
           </xsl:copy>
    </xsl:template>
    <xsl:template match="e:content">
        <!-- only migrating article and content types with state="published" until we start livemigration-->
        <xsl:if test="@state='published'"><!-- Todo: remove this test when livemigration is started -->
            <!-- Skip all xml for an article or content-type if homeSection is to be deleted (section has status="D" in $sectionMap)-->
            <xsl:variable name="homeSectionKey" select="e:section[@homeSection='yes']/@uniquename"/>
            <xsl:if test="$sectionMap-ns/sectionReplacement[@uniqueName=$homeSectionKey and @status!='D']">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:if>     
        </xsl:if>
    </xsl:template>
    <xsl:template match="e:section">
        <xsl:variable name="sectionKey" select="@uniquename"/>
        <xsl:choose>
            <!-- if a section´s unique-name exists in the variable $sectionMap and has status="S", replace uniqueName,source and sourceid with the value defined as replacement_section-->
            <xsl:when test="$sectionMap-ns/sectionReplacement[@uniqueName=$sectionKey and @status='S']/replacement_sourceID">
                <xsl:variable name="sectionReplacement" select="$sectionMap-ns/sectionReplacement[@uniqueName=$sectionKey]"/>
                <xsl:element name="e:section">             
                    <xsl:attribute name="uniquename"><xsl:value-of select="$sectionReplacement/replacement_uniqueName"/></xsl:attribute>    
                    <xsl:attribute name="source"><xsl:text>escenic-migration</xsl:text></xsl:attribute>    
                    <xsl:attribute name="sourceid"><xsl:value-of select="$sectionReplacement/replacement_sourceID"/></xsl:attribute>    
                    <xsl:if test="@homeSection"><xsl:attribute name="homeSection"><xsl:value-of select="@homeSection"/></xsl:attribute></xsl:if>   
                </xsl:element>
                <!-- and if a tag is defined in $sectionMap, add it to the xml -->
                <xsl:if test="$sectionReplacement/tag != ''">
                    <xsl:element name="e:tag">
                        <xsl:attribute name="identifier"><xsl:text>tag:iptc.medianorge.no,2011:</xsl:text><xsl:value-of select="$sectionReplacement/tag"/></xsl:attribute>
                    </xsl:element>
                </xsl:if>
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