<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="" />

    <xsl:template match="/">
            <io><xsl:apply-templates/></io>
    </xsl:template>


<xsl:template match="content[@type='picture']">
	<multimediaGroup type="image" published="true" source="MEDIANORGE" sourceid="" >
		<xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
		<xsl:attribute name="id"><xsl:value-of select="@sourceid"/></xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="field[@name='binary']"/></xsl:attribute>
	    <xsl:attribute name="photographer"><xsl:value-of select="field[@name='photographer']"/></xsl:attribute>
		<multimedia version="a" default="yes">
			<xsl:attribute name="filename"><xsl:value-of select="field[@name='binary']"/></xsl:attribute>
		</multimedia>
	</multimediaGroup>
</xsl:template>	
<xsl:template match="content[@type='news' or @type='review']">
	<article>
		<xsl:attribute name="source">MEDIANORGE</xsl:attribute>
		<xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
		<xsl:attribute name="id"><xsl:value-of select="@sourceid"/></xsl:attribute>
		<xsl:attribute name="state"><xsl:value-of select="@state"/></xsl:attribute>
		<xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
		<section source="escenic" name="Promo" uniquename="promo" homeSection="yes"/>
		<reference type="image" source="MEDIANORGE" sourceid="1475307" priority="1">
		<xsl:apply-templates select="relation"/>
		</reference>
		<creator>
		<xsl:attribute name="firstname"><xsl:value-of select="creator/@first-name"/></xsl:attribute>
		<xsl:attribute name="surname"><xsl:value-of select="creator/@last-name"/></xsl:attribute>
		<xsl:attribute name="email"></xsl:attribute>
		</creator>
		<author>
		<xsl:attribute name="firstname"><xsl:value-of select="author/@first-name"/></xsl:attribute>
		<xsl:attribute name="surname"><xsl:value-of select="author/@last-name"/></xsl:attribute>
		<xsl:attribute name="email"></xsl:attribute>
		</author>
		<field name="INGRESS"><xsl:value-of select="field[@name='leadtext']"/></field>
		<field name="TITLE"><xsl:value-of select="field[@name='title']"/></field>
		<field name="FRONTPAGETITLE"><xsl:value-of select="field[@name='frontpagetitle']"/></field>
		<field name="FRONTPAGELEADTEXT"><xsl:value-of select="field[@name='frontpageleadtext']"/></field>
		<field name="link"></field>
	</article>
</xsl:template>


<xsl:template match="relation">
		<xsl:attribute name="sourceid"><xsl:value-of select="@sourceid"/></xsl:attribute>
		<xsl:attribute name="id"><xsl:value-of select="@sourceid"/></xsl:attribute>
</xsl:template>

<xsl:template match="relation/field">
	<xsl:if test="@name ='title'">
		<xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>
	</xsl:if>
	<xsl:if test="@name ='photographer'">
		<xsl:attribute name="photographer"><xsl:value-of select="photographer"/></xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="relation/field[@name='title']">
		<xsl:attribute name="filename"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="section-ref">
		<xsl:attribute name="uniquename"><xsl:value-of select="@unique-name"/></xsl:attribute>
</xsl:template>

</xsl:transform>
